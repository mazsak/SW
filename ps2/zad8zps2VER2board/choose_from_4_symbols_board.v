module choose_from_4_symbols_board(  
	input [9:0] SW,
	output [0:6] HEX0,
	output [9:0] LEDR);
	
	wire [1:0] mux;
	
	assign LEDR=SW;
	
	mux_4_1_2_bits ex1(SW[0], SW[2], SW[4], SW[6], SW[8], SW[9], mux[0]);
	mux_4_1_2_bits ex2(SW[1], SW[3], SW[5], SW[7], SW[8], SW[9], mux[1]);
	choose_from_4_symbols ex3(mux[1:0], HEX0[0:6]);
	
endmodule