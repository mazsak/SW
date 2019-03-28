module master_slave_D_board (input [3:2] SW,
								output [1:0] LEDR);

		master_slave_D ex1(SW[3], SW[2], LEDR[1], LEDR[0]);
								
endmodule


module master_slave_D(Clk, D, Qa, Q);
		input Clk, D;
		output Qa, Q;
				
		latch_D ex2(!Clk, D, Qa);
		latch_D ex3(Clk, Qa, Q);

endmodule


module latch_D (Clk, D, Q);
		input Clk, D;
		output Q;
		
		(* KEEP = "TRUE" *) wire R, R_g, S_g, Qa, Qb; 
		
		assign R = !D;
		
		nand (S_g, D, Clk);
		nand (R_g, R, Clk);
		nand (Qa, S_g, Qb);
		nand (Qb, R_g, Qa);
		assign Q = Qa;
		
endmodule
