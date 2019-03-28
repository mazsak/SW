module counter_mod_M_board(
					input [0:0] CLOCK_50,
					input [2:1] SW,
					output [0:6] HEX0);
		
		lab5_part3a exx(CLOCK_50[0], SW[1], SW[2], HEX0[0:6]);

endmodule

module counter_mod_M
	#(parameter M=16)
	(input clk,aclr,enable,
	output reg [N-1:0] Q);
	
	localparam N=clogb2(M-1);
	
	function integer clogb2(input [31:0] v);
		for (clogb2 = 0; v > 0; clogb2 = clogb2 + 1)
			v = v >> 1;
	endfunction
	
	always @(posedge clk, negedge aclr)
		if (!aclr) 		Q <= {N{1'b0}};
		else if (Q == M-1)	Q <= {N{1'b0}};
		else if (enable) 	Q <= Q + 1'b1;	
		else 		Q <= Q;
		
endmodule

module lab5_part3a(
	input clk,aclr,enable,
	output [0:6] h);
	localparam sizeA=clogb2(50000000);
	function integer clogb2(input [31:0] v);
		for (clogb2 = 0; v > 0; clogb2 = clogb2 + 1)
			v = v >> 1;
	endfunction
	wire [sizeA-1:0] A;
	wire e_1_sec;
	wire [3:0] B;
	counter_mod_M #(50000000) ex0(clk,aclr,enable,A);
	assign e_1_sec = ~|A;
	counter_mod_M #(11) ex1(clk,aclr,e_1_sec,B);
	decoder_hex_10 ex(B,h);
endmodule

module decoder_hex_10 (
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
			default: h=7'b1111111;
		endcase
								
endmodule
