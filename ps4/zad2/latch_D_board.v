module latch_D_board (input [3:2] SW,
								output [0:0] LEDR);

		latch_D ex1(SW[3], SW[2], LEDR[0]);
								
endmodule


module latch_D (Clk, D, Q);
		input Clk, D;
		output Q;
		
		wire R, R_g, S_g, Qa, Qb; 
		
		assign R = !D;
		
		nand (S_g, D, Clk);
		nand (R_g, R, Clk);
		nand (Qa, S_g, Qb);
		nand (Qb, R_g, Qa);
		assign Q = Qa;
		
endmodule
