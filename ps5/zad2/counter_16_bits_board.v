module counter_16_bits_board(
							input [0:0] KEY,
							input [2:1] SW,
							output [0:6] HEX0, HEX1, HEX2, HEX3);

		wire [15:0] A;
		
		counter_N_bits ex0(KEY[0], SW[1], SW[2], A[15:0]);
		decoder_hex_16 ex1(A[3:0], HEX0[0:6]);
		decoder_hex_16 ex2(A[7:4], HEX1[0:6]);
		decoder_hex_16 ex3(A[11:8], HEX2[0:6]);
		decoder_hex_16 ex4(A[15:12], HEX3[0:6]);

endmodule

module counter_N_bits
	#(parameter N=16)
	(input clk,aclr,enable,
	output reg [N-1:0] Q);
	
	always @(posedge clk, negedge aclr)
		if (!aclr) 		Q <= {N{1'b0}};
		else if (enable) 	Q <= Q + 1'b1;
		else 		Q <= Q;
		
endmodule

module decoder_hex_16(
							input [3:0] x,
							output reg [0:6] h);
		
		always @(*)
		casex(x)
			4'd0: h=7'b0000001;
			4'd1: h=7'b1001111;
			4'd2: h=7'b0010010;
			4'd3: h=7'b0000110;
			4'd4: h=7'b1001100;
			4'd5: h=7'b0100100;
			4'd6: h=7'b0100000;
			4'd7: h=7'b0001111;
			4'd8: h=7'b0000000;
			4'd9: h=7'b0000100;
			4'd10: h=7'b0001000;
			4'd11: h=7'b1100000;
			4'd12: h=7'b0110001;
			4'd13: h=7'b1000010;
			4'd14: h=7'b0110000;
			4'd15: h=7'b0111000;
			default: h=7'b1111111;
		endcase
		
endmodule
