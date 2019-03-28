module mux_4_1_1_bit_board(
	input [9:0] SW, input [1:0] KEY,
	output [3:0] LEDR);
	
	mux_4_1_1_bit ex1(SW[2], SW[4], SW[6], SW[8], KEY[0], KEY[1], LEDR[2]);
	mux_4_1_1_bit ex2(SW[3], SW[5], SW[7], SW[9], KEY[0], KEY[1], LEDR[3]);
	
endmodule