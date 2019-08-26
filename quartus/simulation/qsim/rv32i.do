onerror {quit -f}
vlib work
vlog -work work rv32i.vo
vlog -work work rv32i.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.datapath_vlg_vec_tst
vcd file -direction rv32i.msim.vcd
vcd add -internal datapath_vlg_vec_tst/*
vcd add -internal datapath_vlg_vec_tst/i1/*
add wave /*
run -all
