module my_ram32x4(
	input [4:0] Address,
	input clk,
	input [3:0] DataIn,
	input Write,
	output [3:0] DataOut);
	
	ram32x4 my(Address,clk,DataIn,Write,DataOut);
endmodule
