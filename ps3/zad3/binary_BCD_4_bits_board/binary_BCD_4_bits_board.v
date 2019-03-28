module binary_BCD_4_bits_board(
										input [3:0] SW,
										output [3:0] LEDR,
										output [0:6] HEX0, output reg [0:6] HEX1);
										
		reg s;
		wire [3:0] reply , m;
		
		
		assign LEDR = SW;
		
		binary_BCD_4_bits ex1(reply[3:0], HEX0);
		circuit_a e1(SW[3:0], m[3:0]);
		mux_2_1_1_bit ex2(SW[0], m[0], s, reply[0]);
		mux_2_1_1_bit ex3(SW[1], m[1], s, reply[1]);
		mux_2_1_1_bit ex4(SW[2], m[2], s, reply[2]);
		mux_2_1_1_bit ex5(SW[3], m[3], s, reply[3]);
		
		
		always @(*) 
		begin
			HEX1 = 7'b0000001;
			s = 0;
			if (SW[3:0] > 4'b1001) HEX1 = 7'b1001111; s = 1;
		end		
		
		
endmodule