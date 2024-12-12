transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/cefet\ 20242/LAOC/Quartus/Quest03 {D:/cefet 20242/LAOC/Quartus/Quest03/Extent.v}

