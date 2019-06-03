module liczba_bitow(
		input [9:0] SW,
		input CLOCK_50,
		input [0:0] KEY,
		output [0:6] HEX0,
		output [9:9] LEDR);
		
	wire [3:0] result;
	
	liczba_b x0(SW[7:0], CLOCK_50, KEY[0:0],SW[9], result[3:0], LEDR[9:9]);
	
	decoder_hex_10 dec(result, HEX0);
	
endmodule

module liczba_b(
		input [7:0] in,
		input clk,
		input sclr,
		input run,
		output reg [3:0] result,
		output reg done);
		
   
   reg [1:0] state,next;
	reg [7:0] A;
	localparam 
		s0=2'b00,
		s1=2'b01,
		s2=2'b10,
		s3=2'b11;
	always @(posedge clk, negedge sclr)
		if (~sclr) 	
			state <= s0;
		else		
			state <= next;	
	
	always @(*)
		begin
		if(run)
			begin
				case (state)
					s0: next = s1;
					s1: 
						begin
							result=0; 
							if (~sclr)
								begin
									A=in;
									next = s1;
								end
							else
								begin
									next=s2;
								end
						end	
					s2: 
						begin
							A=A>>1;
							if(A==0)
								begin
									next=s3;
								end
							else
								begin
									if(A[0]==1)
										begin
											result=result+1;
										end
									next=s2;
								end
						end
					s3: 
						begin
							done=1;
							if(~sclr)
								begin
									next=s0;
									done = 0;
								end
							else
								begin
									next=s3;
								end
						end
					default: next = s0;
				endcase
			end
		end
endmodule

module decoder_hex_10(
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
			default: h=7'b1111111;
		endcase
		
endmodule

