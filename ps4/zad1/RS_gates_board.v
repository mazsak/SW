module RS_gates_board (input [4:2] SW,
								output [0:0] LEDR);

		RS_gates ex1(SW[4], SW[3], SW[2], LEDR[0]);

endmodule



module RS_gates (Clk, R, S, Q);
		input Clk, R, S;
		output Q;
		
		(* KEEP = "TRUE" *) wire R_g, S_g, Qa, Qb /* synthesis keep */ ;
		and (R_g, R, Clk);
		and (S_g, S, Clk);
		nor (Qa, R_g, Qb);
		nor (Qb, S_g, Qa);
		
		assign Q = Qa;
	
endmodule
