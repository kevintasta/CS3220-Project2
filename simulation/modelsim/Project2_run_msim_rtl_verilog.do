transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Yuanhan/Documents/2016-2017/CS\ 3220/Project2 {C:/Users/Yuanhan/Documents/2016-2017/CS 3220/Project2/SignExtension.v}
vlog -vlog01compat -work work +incdir+C:/Users/Yuanhan/Documents/2016-2017/CS\ 3220/Project2 {C:/Users/Yuanhan/Documents/2016-2017/CS 3220/Project2/Register.v}
vlog -vlog01compat -work work +incdir+C:/Users/Yuanhan/Documents/2016-2017/CS\ 3220/Project2 {C:/Users/Yuanhan/Documents/2016-2017/CS 3220/Project2/Project2.v}
vlog -vlog01compat -work work +incdir+C:/Users/Yuanhan/Documents/2016-2017/CS\ 3220/Project2 {C:/Users/Yuanhan/Documents/2016-2017/CS 3220/Project2/InstMemory.v}
vlog -vlog01compat -work work +incdir+C:/Users/Yuanhan/Documents/2016-2017/CS\ 3220/Project2 {C:/Users/Yuanhan/Documents/2016-2017/CS 3220/Project2/DataMemory.v}
vlog -vlog01compat -work work +incdir+C:/Users/Yuanhan/Documents/2016-2017/CS\ 3220/Project2 {C:/Users/Yuanhan/Documents/2016-2017/CS 3220/Project2/ClockDivider.v}
vlog -vlog01compat -work work +incdir+C:/Users/Yuanhan/Documents/2016-2017/CS\ 3220/Project2 {C:/Users/Yuanhan/Documents/2016-2017/CS 3220/Project2/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/Yuanhan/Documents/2016-2017/CS\ 3220/Project2 {C:/Users/Yuanhan/Documents/2016-2017/CS 3220/Project2/Controller.v}
vlog -vlog01compat -work work +incdir+C:/Users/Yuanhan/Documents/2016-2017/CS\ 3220/Project2 {C:/Users/Yuanhan/Documents/2016-2017/CS 3220/Project2/Multiplexer.v}
vlog -vlog01compat -work work +incdir+C:/Users/Yuanhan/Documents/2016-2017/CS\ 3220/Project2 {C:/Users/Yuanhan/Documents/2016-2017/CS 3220/Project2/Adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Yuanhan/Documents/2016-2017/CS\ 3220/Project2 {C:/Users/Yuanhan/Documents/2016-2017/CS 3220/Project2/LeftShift.v}
vlog -vlog01compat -work work +incdir+C:/Users/Yuanhan/Documents/2016-2017/CS\ 3220/Project2 {C:/Users/Yuanhan/Documents/2016-2017/CS 3220/Project2/RegFile.v}
vlog -vlog01compat -work work +incdir+C:/Users/Yuanhan/Documents/2016-2017/CS\ 3220/Project2 {C:/Users/Yuanhan/Documents/2016-2017/CS 3220/Project2/BranchPicker.v}
vlog -vlog01compat -work work +incdir+C:/Users/Yuanhan/Documents/2016-2017/CS\ 3220/Project2 {C:/Users/Yuanhan/Documents/2016-2017/CS 3220/Project2/hex2_7seg.v}

vlog -vlog01compat -work work +incdir+C:/Users/Yuanhan/Documents/2016-2017/CS\ 3220/Project2 {C:/Users/Yuanhan/Documents/2016-2017/CS 3220/Project2/TestProject2.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  TestProject2

add wave *
view structure
view signals
run -all
