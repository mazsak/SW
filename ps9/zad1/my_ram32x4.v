module my_ram32x4(
	input [4:0] address,
	input clk,
	input [3:0] data,
	input wren,
	output [3:0] q);
	
	ram32x4 x1(address,clk,data,wren,q);
endmodule
