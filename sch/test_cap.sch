v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -250 -90 -250 -30 {lab=#net1}
N -250 -90 -100 -90 {lab=#net1}
N -100 -90 -100 -70 {lab=#net1}
N -100 -10 -100 60 {lab=0}
N -150 60 -100 60 {lab=0}
N -250 30 -250 60 {lab=0}
N -250 60 -150 60 {lab=0}
C {capa.sym} -100 -40 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {vsource.sym} -250 0 0 0 {name=V1 value="PULSE(0 1.8 0 1n 1n 50n 100n)" savecurrent=false }
C {gnd.sym} -150 60 0 0 {name=l1 lab=0}
C {code_shown.sym} 50 -20 0 0 {name=s1 only_toplevel=false value="
.tran 1n 200n
.control
run
write test_cap.raw
.endc
"
}
