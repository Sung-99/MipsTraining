transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/Prog\ Area/MIPS\ Asembly/QuartusProject/Quartus/Test7 {E:/Prog Area/MIPS Asembly/QuartusProject/Quartus/Test7/Processor.v}
vlog -vlog01compat -work work +incdir+E:/Prog\ Area/MIPS\ Asembly/QuartusProject/Quartus/Test7 {E:/Prog Area/MIPS Asembly/QuartusProject/Quartus/Test7/registrador.v}
vlog -vlog01compat -work work +incdir+E:/Prog\ Area/MIPS\ Asembly/QuartusProject/Quartus/Test7 {E:/Prog Area/MIPS Asembly/QuartusProject/Quartus/Test7/MUX.v}
vlog -vlog01compat -work work +incdir+E:/Prog\ Area/MIPS\ Asembly/QuartusProject/Quartus/Test7 {E:/Prog Area/MIPS Asembly/QuartusProject/Quartus/Test7/SignExtend.v}
vlog -vlog01compat -work work +incdir+E:/Prog\ Area/MIPS\ Asembly/QuartusProject/Quartus/Test7 {E:/Prog Area/MIPS Asembly/QuartusProject/Quartus/Test7/somadorcompleto.v}
vlog -vlog01compat -work work +incdir+E:/Prog\ Area/MIPS\ Asembly/QuartusProject/Quartus/Test7 {E:/Prog Area/MIPS Asembly/QuartusProject/Quartus/Test7/pc.v}
vlog -vlog01compat -work work +incdir+E:/Prog\ Area/MIPS\ Asembly/QuartusProject/Quartus/Test7 {E:/Prog Area/MIPS Asembly/QuartusProject/Quartus/Test7/meminstrucao.v}
vlog -vlog01compat -work work +incdir+E:/Prog\ Area/MIPS\ Asembly/QuartusProject/Quartus/Test7 {E:/Prog Area/MIPS Asembly/QuartusProject/Quartus/Test7/ula.v}

