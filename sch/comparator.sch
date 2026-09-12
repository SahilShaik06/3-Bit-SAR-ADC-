v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 1010 2950 1010 3020 {lab=#net1}
N 890 2950 1010 2950 {lab=#net1}
N 1010 2950 1120 2950 {lab=#net1}
N 1120 2870 1120 2890 {lab=q}
N 1010 3080 1010 3130 {lab=0}
N 1000 2920 1120 2920 {lab=0}
N 890 2920 990 2920 {lab=0}
N 990 2920 1000 2920 {lab=0}
N 1010 3050 1130 3050 {lab=0}
N 240 2500 1570 2500 {lab=vdd}
N 890 2850 890 2890 {lab=p}
N 1120 2850 1120 2870 {lab=q}
N 890 2710 890 2790 {lab=x}
N 1040 2820 1080 2820 {lab=x}
N 890 2750 1040 2820 {lab=x}
N 930 2820 970 2820 {lab=y}
N 970 2820 1120 2740 {lab=y}
N 1120 2700 1120 2790 {lab=y}
N 890 2680 890 2710 {lab=x}
N 1120 2680 1120 2700 {lab=y}
N 930 2650 970 2650 {lab=y}
N 970 2650 1060 2700 {lab=y}
N 1060 2700 1120 2700 {lab=y}
N 1040 2650 1080 2650 {lab=x}
N 970 2700 1040 2650 {lab=x}
N 890 2700 970 2700 {lab=x}
N 770 2820 890 2820 {lab=0}
N 1120 2820 1230 2820 {lab=0}
N 890 2500 890 2620 {lab=vdd}
N 1120 2500 1120 2620 {lab=vdd}
N 840 2500 840 2650 {lab=vdd}
N 1160 2500 1160 2650 {lab=vdd}
N 840 2650 890 2650 {lab=vdd}
N 1120 2650 1160 2650 {lab=vdd}
N 440 2500 440 2600 {lab=vdd}
N 440 2660 440 2870 {lab=p}
N 440 2870 890 2870 {lab=p}
N 440 2630 500 2630 {lab=vdd}
N 500 2500 500 2630 {lab=vdd}
N 670 2500 670 2590 {lab=vdd}
N 670 2620 700 2620 {lab=vdd}
N 700 2500 700 2620 {lab=vdd}
N 670 2650 670 2720 {lab=x}
N 670 2720 890 2720 {lab=x}
N 1310 2690 1310 2740 {lab=y}
N 1120 2740 1310 2740 {lab=y}
N 1310 2500 1310 2630 {lab=vdd}
N 1260 2660 1310 2660 {lab=vdd}
N 1260 2500 1260 2660 {lab=vdd}
N 1570 2500 1690 2500 {lab=vdd}
N 1410 2670 1500 2670 {lab=vdd}
N 1410 2500 1410 2670 {lab=vdd}
N 1500 2500 1500 2640 {lab=vdd}
N 1500 2700 1500 2870 {lab=q}
N 1120 2870 1500 2870 {lab=q}
C {sky130_fd_pr/nfet_01v8.sym} 870 2920 0 0 {name=M1

W=4
L=0.5
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 1140 2920 0 1 {name=M2
W=4
L=0.5
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 990 3050 0 0 {name=Mtail
W=8
L=0.5
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {gnd.sym} 1010 3130 0 0 {name=l2 lab=0}
C {lab_pin.sym} 890 2880 0 0 {name=p1 sig_type=std_logic lab=p
}
C {lab_pin.sym} 1120 2880 0 0 {name=p2 sig_type=std_logic lab=q}
C {gnd.sym} 1000 2920 0 0 {name=l6 lab=0}
C {gnd.sym} 1130 3050 0 0 {name=l7 lab=0}
C {sky130_fd_pr/nfet_01v8.sym} 1100 2820 0 0 {name=M4

W=1
L=0.15
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 910 2820 0 1 {name=M3
W=1
L=0.15
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {lab_pin.sym} 890 2770 0 0 {name=p3 sig_type=std_logic lab=x}
C {lab_pin.sym} 1120 2770 0 0 {name=p4 sig_type=std_logic lab=y}
C {sky130_fd_pr/pfet_01v8.sym} 910 2650 0 1 {name=M5
W=2
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 1100 2650 0 0 {name=M6
W=2
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {gnd.sym} 770 2820 0 0 {name=l5 lab=0}
C {gnd.sym} 1230 2820 0 0 {name=l8 lab=0}
C {lab_wire.sym} 840 2500 0 0 {name=p5 sig_type=std_logic lab=vdd}
C {sky130_fd_pr/pfet_01v8.sym} 420 2630 0 0 {name=Sw1
W=2
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 650 2620 0 0 {name=Sw3
W=2
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 1330 2660 0 1 {name=Sw2
W=2
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 1520 2670 0 1 {name=Sw4
W=2
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {lab_pin.sym} 400 2630 0 0 {name=p7 sig_type=std_logic lab=clk}
C {lab_pin.sym} 630 2620 0 0 {name=p8 sig_type=std_logic lab=clk}
C {lab_pin.sym} 1350 2660 0 1 {name=p9 sig_type=std_logic lab=clk}
C {lab_pin.sym} 1540 2670 0 1 {name=p10 sig_type=std_logic lab=clk}
C {ipin.sym} 850 2920 0 0 {name=p11 lab=vinp}
C {ipin.sym} 1160 2920 0 1 {name=p12 lab=vinn}
C {opin.sym} 1120 2770 0 0 {name=p13 lab=y}
C {opin.sym} 890 2750 0 1 {name=p14 lab=x}
C {ipin.sym} 240 2500 0 0 {name=p15 lab=vdd}
C {ipin.sym} 970 3050 0 0 {name=p16 lab=clk}
