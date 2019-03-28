module zad5(input [8:0]SW, output [9:0]LEDR, output [0:6]HEX0,HEX1,HEX3,HEX5);

wire [4:0]suma,S1,S0;
reg [3:0]z;
reg [3:0]c;
reg error;

assign suma = SW[7:4] + SW[3:0] + SW[8];
assign LEDR[7:0] = SW[7:0];

always@(*)
	begin
		if(suma > 4'b1001)
			begin
				z = 4'b1010;
				c = 4'b0001;
			end
		else
			begin
				z = 0;
				c = 0;
			end
	end
always@(*)
	begin
		if(SW[7:4] > 4'b1001 || SW [3:0] > 4'b1001 || suma > 5'b10100)
			error = 1;
		else
			error = 0;
	end

	
assign LEDR[9] = error;	
assign S0 = suma - z;
assign S1 = c;

binary_BCD_4_bits(S0,HEX0);
binary_BCD_4_bits(S1,HEX1);
binary_BCD_4_bits(SW[7:4],HEX5);
binary_BCD_4_bits(SW[3:0],HEX3);

endmodule