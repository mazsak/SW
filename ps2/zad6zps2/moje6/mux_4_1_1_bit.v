module mux_4_1_1_bit(
	input u, v, w, x, S0, S1,
	output m);
	
	assign m = (~S0 & ~S1 & u) | (S0 & ~S1 & v) | (~S0 & S1 & w) | (S0 & S1 & x);
	
endmodule