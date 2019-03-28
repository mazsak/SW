module deoder_7_seg_board(  
	input [1:0] SW,
	output [0:6] HEX0);
	
	decoder_7_seg ex1(SW[1:0], HEX0[0:6]);
	
endmodule