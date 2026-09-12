#!/usr/bin/env python3
"""
Closed-loop SAR ADC sweep.

For each input voltage this runs the ngspice netlist three times, once per SAR
cycle. After each run it reads the real comparator + SR-latch output and uses
that decision to build the switch timing for the next cycle. The bits come from
the transistor-level comparator, not from a prediction.

Each run replays the whole charge history from t=0, so the physics stays
correct -- only the switch controls for not-yet-decided cycles change.

Usage:
    python3 sar_sweep.py           # 8-point sanity check (~1 min)
    python3 sar_sweep.py --fine    # 181-point sweep for DNL/INL (slow)
"""

import argparse
import re
import subprocess
import sys
from pathlib import Path

NETLIST_IN = Path("/headless/.xschem/simulations/cap_array.spice")
WORKDIR = Path("/foss/designs/sar_adc/sim")
VREF = 1.8
LOGIC_THRESHOLD = 0.9

# Comparator strobes at 165n / 205n / 245n. Decisions are read 15 ns after each
# strobe, by which point the SR latch is holding a settled value.
CONTROL_BLOCK = """.control
tran 0.1n 280n
meas tran d0 FIND v(comp_out) AT=180n
meas tran d1 FIND v(comp_out) AT=220n
meas tran d2 FIND v(comp_out) AT=260n
.endc"""

# Timeline
#   0    - 101n : sampling, S2 holds vx at vcm, bottom plates on Vin
#   101n         : S2 opens (top plate isolated)
#   112n         : bottom plates leave Vin  <- the non-overlap gap
#   150n         : cycle 1 switches settled
#   190n         : cycle 2 switches settled
#   230n         : cycle 3 switches settled


def switch_lines(b2, b1):
    """Bottom-plate switch controls for the three weighted caps.

    Each cap keeps its Vref switch closed if its bit resolved to 1, otherwise
    it flips back to ground at the start of the next cycle.
    """
    if b2:
        ref4 = "PWL(0 0 148n 0 150n 1.8)"
        gnd4 = "PWL(0 0 112n 0 114n 1.8 148n 1.8 150n 0)"
    else:
        ref4 = "PWL(0 0 148n 0 150n 1.8 188n 1.8 190n 0)"
        gnd4 = "PWL(0 0 112n 0 114n 1.8 148n 1.8 150n 0 188n 0 190n 1.8)"

    if b1:
        ref2 = "PWL(0 0 188n 0 190n 1.8)"
        gnd2 = "PWL(0 0 112n 0 114n 1.8 188n 1.8 190n 0)"
    else:
        ref2 = "PWL(0 0 188n 0 190n 1.8 228n 1.8 230n 0)"
        gnd2 = "PWL(0 0 112n 0 114n 1.8 188n 1.8 190n 0 228n 0 230n 1.8)"

    # LSB cap: nothing samples vx after its decision, so it just turns on.
    ref1 = "PWL(0 0 228n 0 230n 1.8)"
    gnd1 = "PWL(0 0 112n 0 114n 1.8 228n 1.8 230n 0)"

    return {
        "Vs_ref4": ref4, "Vs_gnd4": gnd4,
        "Vs_ref2": ref2, "Vs_gnd2": gnd2,
        "Vs_ref1": ref1, "Vs_gnd1": gnd1,
    }


def build_netlist(base_lines, vin, b2, b1):
    """Patch the xschem netlist for one input voltage and one decision path."""
    sw = switch_lines(b2, b1)
    out = []
    in_control = False

    for line in base_lines:
        stripped = line.strip()
        lowered = stripped.lower()

        # Swap the whole .control block for ours
        if lowered.startswith(".control"):
            in_control = True
            out.append(CONTROL_BLOCK)
            continue
        if in_control:
            if lowered.startswith(".endc"):
                in_control = False
            continue

        parts = stripped.split()
        tok = parts[0] if parts else ""

        if tok == "Vin":
            out.append(f"Vin vin 0 {vin:.6f}")
        elif tok == "V2":
            # dummy cap tracks Vin during sampling, then sits at ground
            out.append(f"V2 bd 0 PWL(0 {vin:.6f} 110n {vin:.6f} 112n 0)")
        elif tok == "Vcmp":
            # 40 ns period -> strobes land in settled windows
            out.append("Vcmp net2 0 PULSE(0 1.8 165n 0.1n 0.1n 10n 40n)")
        elif tok in sw:
            out.append(f"{tok} {tok.lower()} 0 {sw[tok]}")
        else:
            out.append(line.rstrip())

    return "\n".join(out) + "\n"


def run_ngspice(netlist_text, tmp_path):
    """Run one simulation, return {'d0': v, 'd1': v, 'd2': v}."""
    tmp_path.write_text(netlist_text)
    proc = subprocess.run(
        ["ngspice", "-b", str(tmp_path)],
        capture_output=True, text=True, cwd=str(WORKDIR),
    )
    vals = {}
    for m in re.finditer(r"^\s*(d[012])\s*=\s*([-\d.eE+]+)", proc.stdout, re.M):
        vals[m.group(1)] = float(m.group(2))
    if not vals:
        sys.stderr.write("--- ngspice produced no measurements ---\n")
        sys.stderr.write(proc.stdout[-2000:])
        sys.stderr.write(proc.stderr[-2000:])
    return vals


def convert(base_lines, vin, tmp_path):
    """One full 3-bit conversion. Three sims, each informed by the last."""
    # Cycle 1: dac = 100. Result does not depend on b2/b1 yet.
    v = run_ngspice(build_netlist(base_lines, vin, 0, 0), tmp_path)
    b2 = 1 if v.get("d0", 0.0) > LOGIC_THRESHOLD else 0

    # Cycle 2: 4C now held per b2, 2C under test.
    v = run_ngspice(build_netlist(base_lines, vin, b2, 0), tmp_path)
    b1 = 1 if v.get("d1", 0.0) > LOGIC_THRESHOLD else 0

    # Cycle 3: 4C and 2C both held, 1C under test.
    v = run_ngspice(build_netlist(base_lines, vin, b2, b1), tmp_path)
    b0 = 1 if v.get("d2", 0.0) > LOGIC_THRESHOLD else 0

    return b2, b1, b0


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--fine", action="store_true",
                    help="181-point sweep at 10 mV steps (for DNL/INL)")
    ap.add_argument("--out", default="sweep.csv")
    args = ap.parse_args()

    if not NETLIST_IN.exists():
        sys.exit(f"Netlist not found: {NETLIST_IN}\n"
                 "Open cap_array.sch in xschem and click Netlist first.")

    WORKDIR.mkdir(parents=True, exist_ok=True)
    base_lines = NETLIST_IN.read_text().splitlines()
    tmp_path = WORKDIR / "sweep_run.spice"

    if args.fine:
        points = [i * VREF / 180.0 for i in range(181)]
    else:
        points = [0.10, 0.30, 0.50, 0.80, 1.00, 1.20, 1.45, 1.70]

    print(f"Vref = {VREF} V, 1 LSB = {VREF/8:.4f} V")
    print(f"{len(points)} input points, {len(points)*3} ngspice runs\n")

    rows = []
    mismatches = 0
    for vin in points:
        b2, b1, b0 = convert(base_lines, vin, tmp_path)
        code = b2 * 4 + b1 * 2 + b0
        ideal = min(int(vin / (VREF / 8.0)), 7)
        flag = ""
        if code != ideal:
            flag = f"   <-- ideal {ideal}"
            mismatches += 1
        print(f"vin={vin:6.4f} V   code={b2}{b1}{b0} ({code}){flag}")
        rows.append((vin, code))

    csv_path = WORKDIR / args.out
    csv_path.write_text(
        "vin,code\n" + "\n".join(f"{v:.6f},{c}" for v, c in rows) + "\n"
    )
    print(f"\n{len(points)-mismatches}/{len(points)} match the ideal transfer curve")
    print(f"Wrote {csv_path}")


if __name__ == "__main__":
    main()