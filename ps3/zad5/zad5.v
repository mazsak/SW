module zad5(
				input [8:0] SW,
				output [9:0] LEDR,
				output [0:6] HEX0, output [0:6] HEX1,
				output [0:6] HEX3, output [0:6] HEX5);					
		
		wire [0:0] error;
		wire [3:0] R0, R1;
		
		assign LEDR[8:0] = SW[8:0];
		assign LEDR[9] = error;
		
		decoder e1(SW[3:0], HEX3[0:6]);
		decoder e2(SW[7:4], HEX5[0:6]);
		sum e3(SW[3:0], SW[7:4], SW[8], R0[3:0], R1[3:0], error[0:0]);
		decoder e4(R0[3:0], HEX0[0:6]);
		decoder e5(R1[3:0], HEX1[0:6]);
		
endmodule


module decoder(
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

module sum(
		input [3:0] x, y, input [0:0] cin,
		output reg [3:0] reply0, reply1, output reg [0:0] error);
		
		reg [7:0] reply;
		reg [3:0]z0;
		
		always @ (*)
		begin
			reply = x + y + cin;
			if(reply > 8'd9)
			begin
				z0 = 4'd10;
				reply1 = 4'd1;
			end
			else
			begin
				z0 = 4'd0;
				reply1 = 4'd0;
			end
			reply0 = reply - z0;
			if(x > 4'd9 || y > 4'd9)
				error = 1'd1;
			else
				error = 1'd0;
		end
		
		
endmodule

