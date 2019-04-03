module zad5_board(
					input [2:0] SW,
					input [0:0] CLOCK_50,
					output [0:6] HEX0, HEX1, HEX2, HEX3);
					
		wire [1:0] s;
		wire [25:0] A;
		wire e;
		wire [1:0] c0,c1,c2,c3;

		counter_mod_M #(50000000) count0(CLOCK_50,SW[0],SW[1],1,A);

		assign e = ~|A;
		counter_mod_M #(5) count1(CLOCK_50,SW[0],e,SW[2],s);

		mux_4_1_2 ex0(2'b00,2'b01,2'b10,2'b11,s,c0);
		mux_4_1_2 ex1(2'b01,2'b10,2'b11,2'b00,s,c1);
		mux_4_1_2 ex2(2'b10,2'b11,2'b00,2'b01,s,c2);
		mux_4_1_2 ex3(2'b11,2'b00,2'b01,2'b10,s,c3);
		
		decoder_7_seg d0(c0,HEX3);
		decoder_7_seg d1(c1,HEX2);
		decoder_7_seg d2(c2,HEX1);
		decoder_7_seg d3(c3,HEX0);

endmodule

module counter_mod_M
	#(parameter M=16)
	(input clk,aclr,enable, dir,
	output reg [N-1:0] Q);
	
	localparam N=clogb2(M-1);
	
	function integer clogb2(input [31:0] v);
		for (clogb2 = 0; v > 0; clogb2 = clogb2 + 1)
			v = v >> 1;
	endfunction
	
	always @(posedge clk, negedge aclr)
		if (!aclr) 		Q <= {N{1'b0}};
		else if (Q == M-1)	Q <= {N{1'b0}};
		else if (enable)
		begin
			if(dir)
				Q <= Q + 1'b1;	
			else
				Q <= Q - 1'b1;
		end
		else 		Q <= Q;
		
endmodule

module mux_4_1_2 (
		input  [1:0]u,v,w,x,S,
		output [1:0]m);

		mux_4_1_1 m1(u[0],v[0],w[0],x[0],S[1],S[0], m[0]);
		mux_4_1_1 m2(u[1],v[1],w[1],x[1],S[1],S[0], m[1]);

endmodule

module mux_4_1_1 (
		input u, v, w, x, S1, S0,
		output m);

		assign m = (~S0 & ~S1 & u) | (S0 & ~S1 & v) | (~S0 & S1 & w) | (S0 & S1 & x) ;

endmodule


module decoder_7_seg(  
	input [1:0] x,
	output reg [0:6] h);
	
	always @(*)
		casex(x)
			4'd0: h=7'b0101000;
			4'd1: h=7'b1000001;
			4'd2: h=7'b1110001;
			4'd3: h=7'b0110000;
			default: h=7'b1111111;
		endcase

	
endmodule
