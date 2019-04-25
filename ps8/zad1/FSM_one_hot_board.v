module FSM_one_hot_board(
		input [1:0] SW,
		input [0:0] KEY,
		output [9:0] LEDR);
	
	FSM_one_hot ex1(SW[1],KEY[0],SW[0],LEDR[9], LEDR[8:0]);
	
endmodule


module FSM_one_hot(
		input w, clk, aclr,
		output reg z, output reg [8:0] stan);
			
	reg [8:0] y_Q, Y_D; 	// aktualny stan, nastepny stan
			
	localparam [7:0] A = 8'b00000000, 
		B = 8'b00000001,
		C = 8'b00000010,
		D = 8'b00000100,
		E = 8'b00001000,
		F = 8'b00010000,
		G = 8'b00100000,
		H = 8'b01000000,
		I = 8'b10000000;
			
	always @(*)		// definicja przejsc
		case (y_Q)
			A: 	if (!w) Y_D = B; 	else Y_D = F;
			B: 	if (!w) Y_D = C; 	else Y_D = F;
			C: 	if (!w) Y_D = D; 	else Y_D = F;
			D: 	if (!w) Y_D = E; 	else Y_D = F;
			E: 	if (!w) Y_D = E; 	else Y_D = F;
			F: 	if (!w) Y_D = B; 	else Y_D = G;
			G: 	if (!w) Y_D = B; 	else Y_D = H;
			H: 	if (!w) Y_D = B; 	else Y_D = I;
			I: 	if (!w) Y_D = B; 	else Y_D = I;
			default: 	Y_D = 8'bxxxxxxxx;
		endcase
		
	always @(posedge clk,negedge aclr)	// definicja pamieci
		if (~aclr) 		y_Q <= 0;
		else		y_Q <= Y_D;
	
	always @(*)
		stan <= y_Q;
	
	always @(*)			// definicja wyjsc
		z = (y_Q == E) | (y_Q == I);
		
endmodule
