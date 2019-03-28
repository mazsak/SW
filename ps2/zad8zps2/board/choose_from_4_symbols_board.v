module choose_from_4_symbols_board(  
	input [9:0] SW, input [1:0]KEY,
	output [0:6] HEX0,
	output [9:0] LEDR);
	
	wire [1:0] mux;
	
	assign LEDR=SW;
	
	mux_4_1_1_bit ex1(SW[0], SW[2], SW[4], SW[6], KEY[0], KEY[1], mux[0]);
	mux_4_1_1_bit ex2(SW[1], SW[3], SW[5], SW[7], KEY[0], KEY[1], mux[1]);
	choose_from_4_symbols ex3(mux[1:0], HEX0[0:6]);
	
endmodule