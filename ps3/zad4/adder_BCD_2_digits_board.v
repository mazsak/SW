module adder_BCD_2_digits_board(
										input [8:0] SW,
										output [9:0] LEDR,
										output [0:6] HEX0, output [0:6] HEX1,
										output [0:6] HEX3, output [0:6] HEX5);					
		
		reg [0:0] error;
		wire [3:0] R0, R1;
		
		assign LEDR[7:0] = SW[7:0];
		assign LEDR[9] = cin;
		
		binary_BCD_4_bits e1(SW[3:0], HEX3[0:6]);
		binary_BCD_4_bits e2(SW[7:4], HEX5[0:6]);
		sum e3(SW[3:0], SW[7:4], SW[8], R0[3:0], R1[3:0], error[0:0]);
		binary_BCD_4_bits e4(R0[3:0], HEX0[0:6]);
		binary_BCD_4_bits e5(R1[3:0], HEX1[0:6]);
		
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

module sum(
		input [3:0] x, y, input [0:0] cin,
		output reg [3:0] reply0, reply1, output [0:0]error);
		
		reg sum_number;
		
		always @(*)
		begin
			sum_number = x + y + cin;
			if(x[3:0] < 10 && y[3:0] < 10)
			begin
				if(sum_number > 9)
				begin
					sum_number = sum_number + 6;
				end
				error = 0;
				reply0 = sum_number%10;
				if(sum_number > 9)
					reply1 = 4'd1;
				else
					reply1 = 4'd0;
			end
			else
			begin
				error = 1;
				reply0 = 4'd0;
				reply1 = 4'd0;
			end
				
		end
		
endmodule

