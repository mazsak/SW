module accum_N_bits_board(
									input [7:0] SW,
									input [1:0] KEY,
									output [9:0] LEDR,
									output [0:6] HEX0, HEX1, HEX2, HEX3);
		
		assign LEDR[7:0] = SW[7:0];
		
		decoder_hex_16 ex1(SW[3:0], HEX2[0:6]);
		decoder_hex_16 ex2(SW[7:4], HEX3[0:6]);
		
endmodule

module adder_carry
						#(parameter N=8)(
						input [N-1:0] x, y, input [0:0] carryi,
						output [N-1:0] q,
						output [0:0] carryo);
		
		wire[N-1:0] carry;
		
		assign carry[0] = carryi[0];
		
		adder_1_bit ex1(x[0],y[0],carry[0],q[0],carry[1]);
		
		generate 
			
			genvar i;
			for(i = 1; i < N-1; i = i + 1)
			begin:cc
				adder_1_bit ex2(x[i],y[i],carry[i-1],q[i],carry[i]);
			end
			
		endgenerate
		
		assign carryo[0] = carry[N-1];
		
endmodule

module adder_1_bit(
							input x,y,carryi,
							output q, carryo);

		assign q = x ^ y ^ carryi;
		assign carryo = x & y | (x ^ y) & carryi;

endmodule

module latch_D (
					input Clk, D,
					output reg Q);
		
		always @ (D, Clk)
		begin
			if (Clk)
				Q = D;
		end
		
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
