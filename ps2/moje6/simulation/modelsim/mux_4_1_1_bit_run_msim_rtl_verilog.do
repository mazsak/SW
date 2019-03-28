transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Acerek/Desktop/SW/ps2/moje6 {C:/Users/Acerek/Desktop/SW/ps2/moje6/mux_4_1_1_bit.v}

