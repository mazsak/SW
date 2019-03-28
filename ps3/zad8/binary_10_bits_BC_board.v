module binary_10_bits_BC_board(
											input [9:0] SW,
											output [0:6] HEX0, HEX1, HEX2, HEX3,
											output [9:0] LEDR);
											
		assign LEDR = SW;
		
		binary_10_bits_BCD ex1(SW[9:0], HEX0[0:6], HEX1[0:6], HEX2[0:6], HEX3[0:6]);

endmodule

module binary_10_bits_BCD(
									input [9:0] x,
									output [0:6] h0, h1, h2, h3);
		
		reg [3:0] t, s, d, j;
		
		always @ (*)
		begin
			j = x%10;
			d = ((x - x%10)%100)/10;
			s = ((x - x%100)%1000)/100;
			t = ((x - x%1000))/1000;
		end
		
		decoder_hex_10 ex2(t[3:0], h3[0:6]);
		decoder_hex_10 ex3(s[3:0], h2[0:6]);
		decoder_hex_10 ex4(d[3:0], h1[0:6]);
		decoder_hex_10 ex5(j[3:0], h0[0:6]);

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