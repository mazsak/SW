module decoder_7_seg(  
	input [1:0] x,
	output reg [0:6] h);
	
	always @(*)
		casex(x)
			4'd0: h=7'b1000010;
			4'd1: h=7'b0110000;
			4'd2: h=7'b1001111;
			default: h=7'b1111111;
		endcase

	
endmodule