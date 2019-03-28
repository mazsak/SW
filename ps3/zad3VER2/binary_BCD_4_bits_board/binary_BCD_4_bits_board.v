module binary_BCD_4_bits_board(
										input [3:0] SW,
										output [3:0] LEDR,
										output [0:6] HEX0, output [0:6] HEX1);
										
		wire [3:0] m, f, k;
		
		
		assign LEDR = SW;
		
		circuit_a e1(SW[3:0], m[3:0]);
		comparator e2(SW[3:0], k[3:0]);
		mux_4 e3(SW[3:0], m[3:0], k[3:0], f[3:0]);
		binary_BCD_4_bits ex4(k[3:0], HEX1[0:6]);
		binary_BCD_4_bits ex5(f[3:0], HEX0[0:6]);
		
			
		
		
endmodule

module comparator(
	input [3:0] x,
	output reg [3:0] m);
	
	always @(*) 
		begin
			m = 4'd0;
			if (x[3:0] > 4'b1001) m = 4'd1;
		end		
	
endmodule

module binary_BCD_4_bits(
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

module circuit_a (
						input [3:0] x,
						output [3:0] m);

		assign m = x - 4'd10;

		
endmodule

module mux(
	input x, y, s,
	output m);
	
	assign m = (~s&x)|(s&y);
	
endmodule

module mux_4(
	input [3:0] x, y, input s,
	output [3:0] m);
	
	mux ex2(x[0], y[0], s, m[0]);
	mux ex3(x[1], y[1], s, m[1]);
	mux ex4(x[2], y[2], s, m[2]);
	mux ex5(x[3], y[3], s, m[3]);	
	
endmodule


