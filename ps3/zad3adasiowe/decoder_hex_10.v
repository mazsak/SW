module decoder_hex_10(input [3:0]a,
output reg[6:0]aout);

 always @(*)
 begin
	casex(a)
		4'd0: aout=7'b1000000;
		4'd1:aout=7'b1111001;
		4'd2:aout=7'b0100100;
		4'd3:aout=7'b0110000;
		4'd4:aout=7'b0011001;
		4'd5:aout=7'b0010010;
		4'd6:aout=7'b0000010;
		4'd7:aout=7'b1111000;
		4'd8:aout=7'b0000000;
		4'd9:aout=7'b0010000;
		default:aout=7'b1111111;
	endcase
end
endmodule