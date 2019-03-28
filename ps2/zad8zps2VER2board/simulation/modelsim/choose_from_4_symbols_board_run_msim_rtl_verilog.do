transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Acerek/Desktop/SW/ps2/zad6zps2VER2 {C:/Users/Acerek/Desktop/SW/ps2/zad6zps2VER2/mux_4_1_2_bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/Acerek/Desktop/SW/ps2/zad8zps2VER2 {C:/Users/Acerek/Desktop/SW/ps2/zad8zps2VER2/choose_from_4_symbols.v}
vlog -vlog01compat -work work +incdir+C:/Users/Acerek/Desktop/SW/ps2/zad8zps2VER2board {C:/Users/Acerek/Desktop/SW/ps2/zad8zps2VER2board/choose_from_4_symbols_board.v}

