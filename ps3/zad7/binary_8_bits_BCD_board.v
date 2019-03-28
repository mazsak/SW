module binary_8_bits_BCD_board(
											input [7:0] SW,
											output [0:6] HEX0, HEX1, HEX2,
											output [7:0] LEDR);
											
		assign LEDR = SW;
		
		binary_8_bits_BCD ex1(SW[7:0], HEX0[0:6], HEX1[0:6], HEX2[0:6]);

endmodule

module binary_8_bits_BCD(
									input [7:0] x,
									output [0:6] h0, h1, h2);
		
		reg [3:0] s, d, j;
		
		always @ (*)
		begin
			j = x%10;
			d = ((x - x%10)%100)/10;
			s = (x - x%100)/100;
		end
		
		decoder_hex_10 ex2(s[3:0], h2[0:6]);
		decoder_hex_10 ex3(d[3:0], h1[0:6]);
		decoder_hex_10 ex4(j[3:0], h0[0:6]);

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