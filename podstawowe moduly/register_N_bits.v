module register_N_bits
	#(N=8)
	(input [N-1:0] D,
	input clk,
	input reset,
	output reg [N-1:0] Q);
	
	always @(posedge clk)
	begin
		if(reset)
			Q <= 0;
		else	
			Q <= D;
	end
		
endmodule