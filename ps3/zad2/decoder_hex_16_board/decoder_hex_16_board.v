module decoder_hex_16_board(
									input [7:0] SW,
									output [7:0] LEDR,
									output [0:6] HEX0, HEX1);
		
		assign LEDR = SW;
		
		decoder_hex_16 ex1(SW[3:0], HEX0[0:6]);
		decoder_hex_16 ex2(SW[7:4], HEX1[0:6]);
									
endmodule