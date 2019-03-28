module RS_boolean_board (input [4:2] SW,
									output [0:0] LEDR);

		RS_boolean ex1(SW[4], SW[3], SW[2], LEDR[0]);

endmodule



module RS_boolean (Clk, R, S, Q);
		input Clk, R, S;
		output Q;
		
		wire R_g, S_g, Qa, Qb /* synthesis keep */ ;
		
		assign R_g = R & Clk;
		assign S_g = S & Clk;
		assign Qa = ~(R_g | Qb);
		assign Qb = ~(S_g | Qa);
		assign Q = Qa;
		
endmodule
