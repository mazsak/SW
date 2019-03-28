module counter_T_4_bits_board(
					input [0:0] KEY,
					input [1:0] SW,
					output [0:6] HEX0);
					
		wire [3:0] A;
		
		counter_T_4_bits ex0(KEY[0], SW[0], SW[1], A[3:0]);
		decoder_hex_16 ex1(A[3:0], HEX0[0:6]);

endmodule

module counter_T_4_bits(
	input clk, aclr, enable,
	output [3:0] q);
	
	wire [3:1] c;
	
	assign c[1] = q[0] & enable;
	assign c[2] = q[1] & c[1];
	assign c[3] = q[2] & c[2];
	
	FFT_areset ex0(enable,clk,aclr,q[0]);
	FFT_areset ex1(c[1],clk,aclr,q[1]);
	FFT_areset ex2(c[2],clk,aclr,q[2]);
	FFT_areset ex3(c[3],clk,aclr,q[3]);
	
endmodule

module FFT_areset(
	input T,clk,aclr,
	output reg Q);
	
	always @(posedge clk, negedge aclr)
		if (!aclr) 	Q <= 1'b0;
		else if (T) 	Q <= ~Q;
		else	Q <= Q;
		
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
