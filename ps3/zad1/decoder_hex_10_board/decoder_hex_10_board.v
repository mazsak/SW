module decoder_hex_10_board(
									input [7:0] SW,
									output [9:0] LEDR, 
									output [0:6] HEX0, HEX1);
		
		reg [1:0] error;
		
		assign LEDR[7:0] = SW[7:0];
		assign LEDR[8] = error[0];
		assign LEDR[9] = error[1];
		
		decoder_hex_10 ex1(SW[3:0], HEX0[0:6]);
		decoder_hex_10 ex2(SW[7:4], HEX1[0:6]);
		
		always @(*) 
		begin
			error[0] = 0;
			error[1] = 0;
			if (SW[3:0] > 4'b1001) error[0] = 1;
			if (SW[7:4] > 4'b1001) error[1] = 1;
		end

		
endmodule
