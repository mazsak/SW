module my_ram32x4_board(
		input [9:0] SW,
		input [0:0] KEY,
		output [0:6] HEX0,HEX2,HEX4,HEX5);
	
	wire [3:0] h0;
	
	my_ram32x4 x0(SW[8:4],KEY[0],SW[3:0],SW[9],h0);
	
	decoder_hex_16 hex5({3'b000,SW[8]},HEX5);
	decoder_hex_16 hex4(SW[7:4],HEX4);
	decoder_hex_16 hex2(SW[3:0],HEX2);
	decoder_hex_16 hex0(h0,HEX0);
			
endmodule

module my_ram32x4(
	input [4:0] address,
	input clk,
	input [3:0] data,
	input wren,
	output reg [3:0] q);
	
	reg[3:0] memory_array[31:0];
	
	always @(posedge clk)
		begin
			if(wren)
				memory_array[address] = data;
				
			q = memory_array[address];
		end
	
endmodule

module decoder_hex_16(
							input [3:0] x,
							output reg [0:6] h);
		
		always @(*)
		casex(x)
			4'd0: h=7'b0000001;
			4'd1: h=7'b1001111;
			4'd2: h=7'b0010010;
			4'd3: h=7'b0000110;
			4'd4: h=7'b1001100;
			4'd5: h=7'b0100100;
			4'd6: h=7'b0100000;
			4'd7: h=7'b0001111;
			4'd8: h=7'b0000000;
			4'd9: h=7'b0000100;
			4'd10: h=7'b0001000;
			4'd11: h=7'b1100000;
			4'd12: h=7'b0110001;
			4'd13: h=7'b1000010;
			4'd14: h=7'b0110000;
			4'd15: h=7'b0111000;
			default: h=7'b1111111;
		endcase
		
endmodule
