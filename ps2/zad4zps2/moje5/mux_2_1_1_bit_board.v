module mux_2_1_1_bit_board(
	input [7:0] SW, input [0:0]KEY,
	output [3:0]LEDR);
	
	mux_2_1_1_bit ex1(SW[0], SW[4], KEY[0], LEDR[0]);
	mux_2_1_1_bit ex2(SW[1], SW[5], KEY[0], LEDR[1]);
	mux_2_1_1_bit ex3(SW[2], SW[6], KEY[0], LEDR[2]);
	mux_2_1_1_bit ex4(SW[3], SW[7], KEY[0], LEDR[3]);
	
endmodule