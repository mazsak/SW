module adder_1_bit_board(
	input [9:0] SW,
	output [9:0] LEDR);
	
	adder_1_bit ex1(SW[3:0], SW[7:4], SW[9], LEDR[3:0], LEDR[9]);
	
endmodule