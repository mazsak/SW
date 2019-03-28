module mux_2_1_1_bit_board(
	input [1:0] SW, input [0:0]KEY,
	output [0:0]LEDR);
	
	mux_2_1_1_bit ex1(SW[0], SW[1], KEY[0], LEDR[0]);
	
endmodule