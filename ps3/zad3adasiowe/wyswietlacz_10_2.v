module wyswietlacz_10_2(input [3:0]SW,
output [6:0]HEX0,output [6:0]HEX1);
wire [3:0]d0;
wire [3:0]d1;
binary_BCD_4_bits bcd(SW[3:0],d1[3:0],d0[3:0]);
decoder_hex_10 dec0(d0[3:0],HEX0[6:0]);
decoder_hex_10 dec1(d1[3:0],HEX1[6:0]);
endmodule