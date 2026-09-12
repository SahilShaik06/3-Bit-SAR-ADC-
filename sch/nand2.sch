v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -110 -130 -110 -100 {lab=vdd}
N -110 -130 130 -130 {lab=vdd}
N 130 -130 130 -100 {lab=vdd}
N -110 -40 -110 -10 {lab=y}
N -110 -10 130 -10 {lab=y}
N 130 -40 130 -10 {lab=y}
N -110 -70 130 -70 {lab=vdd}
N -0 -130 -0 -70 {lab=vdd}
N 10 80 130 80 {lab=0}
N 10 20 130 20 {lab=0}
N 130 20 130 80 {lab=0}
C {sky130_fd_pr/pfet_01v8.sym} -130 -70 0 0 {name=P1
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
C {sky130_fd_pr/pfet_01v8.sym} 150 -70 0 1 {name=P2
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
C {sky130_fd_pr/nfet_01v8.sym} -10 20 0 0 {name=N1
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
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -10 80 0 0 {name=N2
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
model=nfet_01v8
spiceprefix=X
}
C {ipin.sym} -230 30 0 0 {name=p5 lab=a}
C {ipin.sym} -110 -130 0 0 {name=p7 lab=vdd}
C {opin.sym} 130 -10 0 0 {name=p3 lab=y}
C {gnd.sym} 10 110 0 0 {name=l1 lab=0}
C {ipin.sym} -230 70 0 0 {name=p8 lab=b}
C {gnd.sym} 130 80 0 0 {name=l2 lab=0}
C {lab_pin.sym} -150 -70 0 0 {name=p4 sig_type=std_logic lab=a
}
C {lab_pin.sym} -30 20 0 0 {name=p9 sig_type=std_logic lab=a
}
C {lab_pin.sym} -230 30 0 1 {name=p10 sig_type=std_logic lab=a
}
C {lab_pin.sym} -30 80 0 0 {name=p11 sig_type=std_logic lab=b}
C {lab_pin.sym} 170 -70 0 1 {name=p6 sig_type=std_logic lab=b}
C {lab_pin.sym} -230 70 0 1 {name=p12 sig_type=std_logic lab=b}
