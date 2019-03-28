module binary_BCD_4_bits(
input [3:0]v,
output reg[3:0]d1,
output reg[3:0]d0);
reg [3:0]tmp;

always @(*)
begin
integer value;
value =  v[0] * 4'b0001 + v[1] * 4'b0010 + v[2] * 4'b0100 + v[3] * 4'b1000; 
d0 = value%10;

if(value<=9)
d1 = 4'b0000;
else
d1 = 4'b0001;

end

endmodule