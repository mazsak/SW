module segment (
	input [3:0]KEY,
	output [3:0] LEDR);
	
	assign LEDR = KEY;
	
endmodule