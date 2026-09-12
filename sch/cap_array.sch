v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -10 -120 -10 -70 {lab=b2}
N 200 -120 200 -70 {lab=bd}
N -130 60 -130 100 {lab=0}
N -130 100 30 100 {lab=0}
N 30 100 30 120 {lab=0}
N -10 60 -10 100 {lab=0}
N 30 100 200 100 {lab=0}
N 200 60 200 100 {lab=0}
N 90 60 90 100 {lab=0}
N -130 -180 200 -180 {lab=vx}
N -320 -210 -320 -120 {lab=vx}
N -320 -210 -80 -210 {lab=vx}
N -80 -210 -80 -180 {lab=vx}
N -320 -60 -320 20 {lab=vcm}
N -540 -120 -360 -120 {lab=#net1}
N -360 -120 -360 -90 {lab=#net1}
N -360 -70 -360 -60 {lab=0}
N -540 -60 -360 -60 {lab=0}
N 580 -0 580 30 {lab=0}
N 200 100 580 100 {lab=0}
N 580 -180 580 -60 {lab=vx}
N 200 -180 580 -180 {lab=vx}
N -540 -60 -540 -10 {lab=0}
N 350 -240 710 -240 {lab=vx}
N 350 -240 350 -180 {lab=vx}
N 710 -200 710 -170 {lab=#net2}
N -470 20 -290 20 {lab=vcm}
N 580 30 580 100 {lab=0}
N 200 -70 200 -0 {lab=bd}
N 90 -120 90 -100 {lab=b1}
C {gnd.sym} 30 120 0 0 {name=l1 lab=0}
C {vsource.sym} 200 30 0 0 {name=V2 value="PWL(0 1.2 110n 1.2 112n 0)" savecurrent=false}
C {code_shown.sym} 810 120 0 0 {name=s1 only_toplevel=false value="
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.ic v(comp_out)=0
.control
tran 0.1n 320n
meas tran bit2 FIND v(comp_out) AT=180n
meas tran bit1 FIND v(comp_out) AT=240n
meas tran bit0 FIND v(comp_out) AT=300n
.endc
"}
C {lab_pin.sym} -130 -180 0 0 {name=p1 sig_type=std_logic lab=vx
}
C {lab_pin.sym} -130 -120 0 0 {name=p2 sig_type=std_logic lab=b4}
C {lab_pin.sym} -10 -70 0 0 {name=p3 sig_type=std_logic lab=b2}
C {lab_pin.sym} 90 -100 0 0 {name=p4 sig_type=std_logic lab=b1}
C {lab_pin.sym} 200 -120 0 0 {name=p5 sig_type=std_logic lab=bd}
C {vsource.sym} -540 -90 0 0 {name=V3 value="PWL(0 1.8 99n 1.8 101n 0)" savecurrent=false}
C {switch_ngspice.sym} -320 -90 0 0 {name=S2 model=swmod
device_model=".MODEL swmod SW 
+ VT=0.9 VH=0.5
+ RON=0.01 ROFF=1T "}
C {res.sym} 580 -30 0 0 {name=Rleak
value=1T
footprint=1206
device=resistor
m=1}
C {gnd.sym} -540 -10 0 0 {name=l3 lab=0}
C {comparator.sym} 860 -230 0 0 {name=x1}
C {vsource.sym} 710 -140 0 0 {name=Vcmp value="PULSE(0 1.8 165n 0.1n 0.1n 10n 60n)" savecurrent=false}
C {gnd.sym} 710 -110 0 0 {name=l5 lab=0}
C {vsource.sym} 450 -410 0 0 {name=Vdd value=1.8 savecurrent=false}
C {gnd.sym} 450 -380 0 0 {name=l6 lab=0}
C {lab_pin.sym} 450 -440 0 0 {name=p6 sig_type=std_logic lab=Vdd}
C {lab_pin.sym} 710 -260 0 0 {name=p7 sig_type=std_logic lab=Vdd}
C {lab_pin.sym} 1010 -240 0 1 {name=p8 sig_type=std_logic lab=cmp_y}
C {lab_pin.sym} 1010 -260 0 1 {name=p9 sig_type=std_logic lab=cmp_x}
C {vsource.sym} -320 50 0 0 {name=Vcm value=0.9 savecurrent=false}
C {lab_pin.sym} -470 20 0 0 {name=p10 sig_type=std_logic lab=vcm}
C {gnd.sym} -320 80 0 0 {name=l7 lab=0}
C {lab_pin.sym} 710 -220 0 0 {name=p11 sig_type=std_logic lab=vcm}
C {vsource.sym} -540 200 0 0 {name=Vin value=1.2 savecurrent=false}
C {vsource.sym} -530 290 0 0 {name=Vref value=1.8 savecurrent=false}
C {lab_pin.sym} -540 170 0 0 {name=p12 sig_type=std_logic lab=vin
}
C {lab_pin.sym} -530 260 0 0 {name=p13 sig_type=std_logic lab=vref}
C {gnd.sym} -540 230 0 0 {name=l2 lab=0}
C {gnd.sym} -530 320 0 0 {name=l4 lab=0}
C {switch_ngspice.sym} -110 180 0 0 {name=SW_in4 model=swmod
device_model=".MODEL swmod SW 
+ VT=0.9 VH=0.5
+ RON=0.01 ROFF=1T "}
C {switch_ngspice.sym} -110 380 0 0 {name=SW_gnd4 model=swmod
device_model=".MODEL swmod SW 
+ VT=0.9 VH=0.5
+ RON=0.01 ROFF=1T "}
C {switch_ngspice.sym} -110 270 0 0 {name=SW_ref4 model=swmod
device_model=".MODEL swmod SW 
+ VT=0.9 VH=0.5
+ RON=0.01 ROFF=1T "}
C {vsource.sym} -370 190 0 0 {name=Vs_in value="PWL(0 1.8 110n 1.8 112n 0)" savecurrent=false}
C {lab_pin.sym} -370 160 0 0 {name=p16 sig_type=std_logic lab=vs_in}
C {lab_pin.sym} -150 180 0 0 {name=p17 sig_type=std_logic lab=vs_in}
C {lab_pin.sym} -110 210 0 0 {name=p19 sig_type=std_logic lab=vin
}
C {lab_pin.sym} -110 150 0 0 {name=p20 sig_type=std_logic lab=b4}
C {lab_pin.sym} -110 300 0 0 {name=p21 sig_type=std_logic lab=vref}
C {lab_pin.sym} -110 240 0 0 {name=p22 sig_type=std_logic lab=b4}
C {vsource.sym} -370 290 0 0 {name=Vs_ref4 value="PWL(0 0 148n 0 150n 1.8)" savecurrent=false}
C {lab_pin.sym} -370 260 0 0 {name=p25 sig_type=std_logic lab=vs_ref4}
C {lab_pin.sym} -150 270 0 0 {name=p28 sig_type=std_logic lab=vs_ref4}
C {lab_pin.sym} -110 350 0 0 {name=p31 sig_type=std_logic lab=b4}
C {vsource.sym} -440 400 0 0 {name=Vs_gnd4 value="PWL(0 0 112n 0 114n 1.8 148n 1.8 150n 0)" savecurrent=false}
C {lab_pin.sym} -440 370 0 0 {name=p33 sig_type=std_logic lab=vs_gnd4}
C {lab_pin.sym} -150 380 0 0 {name=p34 sig_type=std_logic lab=vs_gnd4}
C {gnd.sym} -440 430 0 0 {name=l8 lab=0}
C {gnd.sym} -370 320 0 0 {name=l9 lab=0}
C {gnd.sym} -370 220 0 0 {name=l10 lab=0}
C {gnd.sym} -150 200 0 0 {name=l11 lab=0}
C {gnd.sym} -150 290 0 0 {name=l12 lab=0}
C {gnd.sym} -150 400 0 0 {name=l13 lab=0}
C {gnd.sym} -110 410 0 0 {name=l14 lab=0}
C {switch_ngspice.sym} 20 580 0 0 {name=SW_ref2 model=swmod
device_model=".MODEL swmod SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {switch_ngspice.sym} 30 480 0 0 {name=SW_in2 model=swmod
device_model=".MODEL swmod SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {switch_ngspice.sym} 20 680 0 0 {name=SW_gnd2 model=swmod
device_model=".MODEL swmod SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {lab_pin.sym} 30 450 0 0 {name=p14 sig_type=std_logic lab=b2}
C {lab_pin.sym} 20 550 0 0 {name=p15 sig_type=std_logic lab=b2}
C {gnd.sym} -20 700 0 0 {name=l15 lab=0}
C {gnd.sym} 20 710 0 0 {name=l16 lab=0}
C {gnd.sym} -20 600 0 0 {name=l17 lab=0}
C {gnd.sym} -10 500 0 0 {name=l18 lab=0}
C {lab_pin.sym} 30 510 0 0 {name=p18 sig_type=std_logic lab=vin
}
C {lab_pin.sym} 20 610 0 0 {name=p23 sig_type=std_logic lab=vref}
C {vsource.sym} -270 590 0 0 {name=Vs_ref2 value="PWL(0 0 188n 0 190n 1.8 228n 1.8 230n 0)" savecurrent=false}
C {vsource.sym} -270 710 0 0 {name=Vs_gnd2 value="PWL(0 0 112n 0 114n 1.8 188n 1.8 190n 0 228n 0 230n 1.8)" savecurrent=false}
C {gnd.sym} -270 740 0 0 {name=l20 lab=0}
C {gnd.sym} -270 620 0 0 {name=l21 lab=0}
C {lab_pin.sym} -10 480 0 0 {name=p24 sig_type=std_logic lab=vs_in}
C {lab_pin.sym} -270 560 0 0 {name=p26 sig_type=std_logic lab=vs_ref2}
C {lab_pin.sym} -270 680 0 0 {name=p27 sig_type=std_logic lab=vs_gnd2}
C {lab_pin.sym} -20 680 0 0 {name=p29 sig_type=std_logic lab=vs_gnd2}
C {lab_pin.sym} -20 580 0 0 {name=p30 sig_type=std_logic lab=vs_ref2}
C {switch_ngspice.sym} 490 210 0 0 {name=SW_in1 model=swmod
device_model=".MODEL swmod SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {switch_ngspice.sym} 480 320 0 0 {name=SW_ref1 model=swmod
device_model=".MODEL swmod SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {switch_ngspice.sym} 500 430 0 0 {name=SW_ref3 model=swmod
device_model=".MODEL swmod SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {gnd.sym} 450 230 0 0 {name=l19 lab=0}
C {gnd.sym} 440 340 0 0 {name=l22 lab=0}
C {gnd.sym} 460 450 0 0 {name=l23 lab=0}
C {gnd.sym} 500 460 0 0 {name=l24 lab=0}
C {lab_pin.sym} 490 180 0 0 {name=p32 sig_type=std_logic lab=b1}
C {lab_pin.sym} 480 290 0 0 {name=p35 sig_type=std_logic lab=b1}
C {lab_pin.sym} 500 400 0 0 {name=p36 sig_type=std_logic lab=b1}
C {lab_pin.sym} 450 210 0 0 {name=p37 sig_type=std_logic lab=vs_in}
C {lab_pin.sym} 490 240 0 0 {name=p38 sig_type=std_logic lab=vin
}
C {lab_pin.sym} 480 350 0 0 {name=p39 sig_type=std_logic lab=vref}
C {vsource.sym} 200 270 0 0 {name=Vs_ref1 value="PWL(0 0 228n 0 230n 1.8)" savecurrent=false}
C {vsource.sym} 200 370 0 0 {name=Vs_gnd1 value="PWL(0 0 112n 0 114n 1.8 228n 1.8 230n 0)" savecurrent=false}
C {gnd.sym} 200 300 0 0 {name=l25 lab=0}
C {gnd.sym} 200 400 0 0 {name=l26 lab=0}
C {lab_pin.sym} 200 340 0 0 {name=p40 sig_type=std_logic lab=vs_gnd1}
C {lab_pin.sym} 200 240 0 0 {name=p41 sig_type=std_logic lab=vs_ref1}
C {lab_pin.sym} 460 430 0 0 {name=p42 sig_type=std_logic lab=vs_gnd1}
C {lab_pin.sym} 440 320 0 0 {name=p43 sig_type=std_logic lab=vs_ref1}
C {lab_pin.sym} 20 650 0 0 {name=p44 sig_type=std_logic lab=b2}
C {sr_latch.sym} 1300 -240 0 0 {name=x2}
C {lab_pin.sym} 1150 -220 0 0 {name=p45 sig_type=std_logic lab=Vdd}
C {lab_pin.sym} 1150 -240 0 0 {name=p46 sig_type=std_logic lab=cmp_y}
C {lab_pin.sym} 1150 -260 0 0 {name=p47 sig_type=std_logic lab=cmp_x}
C {lab_pin.sym} 1450 -260 0 1 {name=p48 sig_type=std_logic lab=comp_out}
C {sky130_fd_pr/cap_mim_m3_1.sym} -130 -150 0 0 {name=C5 model=cap_mim_m3_1 W=7 L=7 MF=4 spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_1.sym} -10 -150 0 0 {name=C6 model=cap_mim_m3_1 W=7 L=7 MF=2 spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_1.sym} 90 -150 0 0 {name=C7 model=cap_mim_m3_1 W=7 L=7 MF=1 spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_1.sym} 200 -150 0 0 {name=C8 model=cap_mim_m3_1 W=7 L=7 MF=1 spiceprefix=X}
