module latch_FDDP_FDDN_board (input [1:0] SW,
								output [2:0] LEDR);

		latch_D ex1(SW[1], SW[0], LEDR[0], LEDR[1], LEDR[2]);
								
endmodule


module latch_D (Clk, D, Qa, Qb, Qc);
		input Clk, D;
		output reg Qa, Qb, Qc;
		
		always @ (D, Clk)
		begin
			if (Clk)
				Qa = D;
		end
		always @ (posedge Clk)
		begin
			if (Clk)
				Qb = D;
		end
		always @ (negedge Clk)
		begin
			if (!Clk)
				Qc = D;
		end

endmodule
