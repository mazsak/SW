module FSM_one_hot_board(
		input [1:0] SW,
		input [1:0] KEY,
		output [8:0] LEDR);
	
	FSM_one_hot ex1(SW[1],KEY[0],SW[0],LEDR[8], LEDR[7:0]);
	
endmodule


module FSM_one_hot(
		input w, clk, aclr,
		output reg z, output reg [7:0] stan);
		
	reg [8:0] y, d, c; //y - stan obecny, d- stan nastepny
	
	localparam [7:0] A = 8'd1, 
		B = 8'd2,
		C = 8'd4,
		D = 8'd8,
		E = 8'd16,
		F = 8'd32,
		G = 8'd64,
		H = 8'd128,
		I = 8'd256;
	
	always @(*) 
		begin
			case (y)
				A: if (!w) d = B; 	else d = F;
				B: if (!w) d = C; 	else d = F;
				C: if (!w) d = D; 	else d = F;
				D: if (!w) d = E; 	else d = F;
				E: if (!w) d = E; 	else d = F;
				F: if (!w) d = G; 	else d = B;
				G: if (!w) d = H; 	else d = B;
				H: if (!w) d = I; 	else d = B;
				I: if (!w) d = I; 	else d = B;
				default: d = A;
			endcase
		end
		
	always @(*)
		z = y[4] | y[8];
		
	always @(posedge clk, negedge aclr)
		if (~aclr) 
			begin
				y <= 0; 
				stan <= 0;
			end
		else 
			begin
				y <= d;
				stan <= 0;
			end
		
endmodule
