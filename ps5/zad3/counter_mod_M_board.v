module counter_mod_M_board(
					input [0:0] CLOCK_50,
					input [1:0] SW,
					output [0:6] HEX0);
					
		wire [0:0] A;
		wire [0:0] rollover;
		wire [3:0] B;
		
		counter_modulo_M_rollover #(10000000) ex(CLOCK_50[0], SW[0], SW[1], A[0], rollover[0]);
		counter_mod_10 ex0(rollover[0], SW[0], SW[1], B[3:0]);
		decoder_hex_10 ex1(B[3:0], HEX0[0:6]);

endmodule

module counter_modulo_M_rollover
	#(parameter M=16)
	(input clk,aclr,enable,
	output reg [N-1:0] Q,
	output rollover);
	localparam N=clogb2(M-1);

	function integer clogb2(input [31:0] v);
		for (clogb2 = 0; v > 0; clogb2 = clogb2 + 1)
			v = v >> 1;
	endfunction
	
	always @(posedge clk, negedge aclr)
		if (!aclr) 			Q <= {N{1'b0}};
		else 	if (Q == M-1)	Q <= {N{1'b0}};
		else 	if (enable) 	Q <= Q + 1'b1;		
		else 			Q <= Q;
		
	assign rollover = (Q == M-1);
	
endmodule

module counter_mod_10(
	input clk,aclr,enable,
	output [3:0] Q);
	
	counter_mod_M #(10) 
	ex(clk,aclr,enable,Q);
	
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

module counter_N_bits
	#(parameter N=16)
	(input clk,aclr,enable,
	output reg [N-1:0] Q);
	
	always @(posedge clk, negedge aclr)
		if (!aclr) 		Q <= {N{1'b0}};
		else if (enable) 	Q <= Q + 1'b1;
		else 		Q <= Q;
		
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
