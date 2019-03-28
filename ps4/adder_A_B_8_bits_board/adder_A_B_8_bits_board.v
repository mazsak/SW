module adder_A_B_8_bits_board(
					input [7:0] SW,
					input [1:0] KEY,
					output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
					output [0:0] LEDR);
		
		wire [7:0]A;
					
		register ex1(SW[7:0], !KEY[1], !KEY[0], A[7:0]);
		decoder_hex_16 ex2(A[3:0], HEX2[0:6]);
		decoder_hex_16 ex3(A[7:4], HEX3[0:6]);
		decoder_hex_16 ex4(SW[3:0], HEX4[0:6]);
		decoder_hex_16 ex5(SW[7:4], HEX5[0:6]);
		decoder_reply ex6(A[7:0], SW[7:0], HEX0[0:6], HEX1[0:6] ,LEDR[0]);

endmodule				


module register (input [7:0] a, input Clk, input reset,
				output reg [7:0] Q);

		always @ (Clk, a)
		begin
			if(Clk)
				Q = a;
			if(reset)
				Q = 0;
		end
				
endmodule



module decoder_reply(
							input [7:0] a, b,
							output [0:6] h0, h1,
							output [0:0] cout);
		
		wire [7:0] reply;
		
		assign {cout, reply} = a + b;
				
		decoder_hex_16 ex1(reply[3:0], h0[0:6]);
		decoder_hex_16 ex2(reply[7:4], h1[0:6]);
									
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
