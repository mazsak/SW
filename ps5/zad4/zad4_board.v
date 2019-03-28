module zad4_board(
					output [0:6] HEX0, HEX1, HEX2, HEX3);
					
		wire [1:0] c0;
		wire [1:0] c1;
		wire [1:0] c2;
		wire [1:0] c3;
		
		assign c0 = 2'd0;
		assign c1 = 2'd1;
		assign c2 = 2'd2;
		assign c3 = 2'd3;
					
		decoder_7_seg ex3(c3[1:0], HEX3[0:6]);
		decoder_7_seg ex2(c2[1:0], HEX2[0:6]);
		decoder_7_seg ex1(c1[1:0], HEX1[0:6]);
		decoder_7_seg ex0(c0[1:0], HEX0[0:6]);

endmodule

module decoder_7_seg(  
	input [1:0] x,
	output reg [0:6] h);
	
	always @(*)
		casex(x)
			4'd0: h=7'b1000010;
			4'd1: h=7'b0110000;
			4'd2: h=7'b1001111;
			4'd3: h=7'b1110111;
			default: h=7'b1111111;
		endcase

	
endmodule
