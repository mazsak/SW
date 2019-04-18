module accum_N_bits_board(
									input [7:0] SW,
									input [1:0] KEY,
									output [9:0] LEDR,
									output [0:6] HEX0, HEX1, HEX2, HEX3);
		
	
	accumulator_N_bits 
	#(8) ex(SW[7:0], KEY[1], !KEY[0], LEDR[7:0], LEDR[8], LEDR[9]);
	
	decoder_hex_16 d3(SW[7:4],HEX3[0:6]);
	decoder_hex_16 d2(SW[3:0],HEX2[0:6]);
	decoder_hex_16 d1(LEDR[7:4],HEX0[0:6]);
	decoder_hex_16 d0(LEDR[3:0],HEX1[0:6]);	
		
endmodule

module adder_carry
						#(N=8)(
						input [N-1:0] x, y, input [0:0] carryi,
						output [N-1:0] q,
						output [0:0] carryo);
		
		wire[N-1:0] carry;
		
		generate 
			
			genvar i;
			for(i = 0; i < N-1; i = i + 1)
				begin: adder
      			case(i)
         			0:	adder_1_bit ex0(x[i], y[i], carryi, q[i], carry[i]);
         			N-1:	adder_1_bit ex1(x[i], y[i], carry[i-1], q[i], carryo);
         			default: 	adder_1_bit ex2(x[i], y[i], carry[i-1], q[i], carry[i]);
      			endcase
				end
			
		endgenerate
		
endmodule

module adder_1_bit(
							input x,y,carryi,
							output q, carryo);

		assign q = x ^ y ^ carryi;
		assign carryo = x & y | (x ^ y) & carryi;

endmodule


module adder 
				#(N=8)(
				input [N-1:0]x,y, input carryi,
				output [N-1:0] q, output carryo);
							
		assign {carryo,q} = x + y + carryi;

endmodule
		
module FlipFlopD(
	input D,clk,
	output reg Q);
	
	always @(posedge clk)
		Q <= D;
endmodule

module register_N_bits
	#(N=8)
	(input [N-1:0] D,
	input clk,
	input reset,
	output reg [N-1:0] Q);
	
	always @(posedge clk)
	begin
		if(reset)
			Q <= 0;
		else	
			Q <= D;
	end
		
endmodule

module accumulator_N_bits	
	#(N=8)
	(input [N-1:0] A,
	input clk, aclr,
	output [N-1:0] S,
	output overflow, carry);
	
	wire [N-1:0] B;
	
	adder sum(A[N-1:0],S[N-1:0], 1'd1, B[N-1:0], carry);
	
	register_N_bits r(B[N-1],clk,aclr,S[N-1:0]);
	
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
