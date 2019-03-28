transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Acerek/Desktop/SW/ps4/zad6 {C:/Users/Acerek/Desktop/SW/ps4/zad6/subtractor_A_B_8_bits_board.v}

