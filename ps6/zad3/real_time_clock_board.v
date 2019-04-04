module real_time_clock_board(
											input CLOCK_50,
											input [3:0] KEY,
											input [7:0] SW,
											output [0:6] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,
											output [8:0] LEDR);

		wire c, c0, c1, c2, c3, c4;
		wire [3:0] h, h0, h1, h2, h3, h4;
		wire [3:0] he, he0, he1, he2, he3, he4;
		
		assign LEDR[7:0] = SW[7:0];
		
		setTime e1(SW[7:0], he, he0);
		setTime e2(SW[7:0], he1, he2);
		setTime e3(SW[7:0], he3, he4);
		
		delay ex1(CLOCK_50, c);
		
		counter_modulo_k #(10) ex2(c,KEY[1],!KEY[0],he,h, c0);
		counter_modulo_k #(10) ex3(~c0,KEY[1],1'd1,he0,h0,c1);
		counter_modulo_k #(10) ex4(~c1,KEY[2],1'd1,he1,h1, c2);
		counter_modulo_k #(6) ex5(~c2,KEY[2],1'd1,he2,h2, c3);
		counter_modulo_k #(10) ex6(~c3,KEY[3],1'd1,he3,h3, c4);
		counter_modulo_k #(6) ex7(~c4,KEY[3],1'd1,he4,h4, LEDR[8]);
		
		decoder_hex_10 ex8(h,HEX0);
		decoder_hex_10 ex9(h0,HEX1);
		decoder_hex_10 ex10(h1,HEX2);
		decoder_hex_10 ex11(h2,HEX3);
		decoder_hex_10 ex12(h3,HEX4);
		decoder_hex_10 ex13(h4,HEX5);
 
endmodule

module setTime(
					input [7:0] x,
					output reg [3:0] j, d);
					
		always @ (*)
		begin
			j = x%10;
			d = (x - x%10)/10;
		end

endmodule

module delay(
					input clk,
					output q);
					
		wire [25:0]A;
		wire e;
					
		counter_mod_M #(500000) count0(clk,1'd1,1'd1,A);

		assign e = ~|A;
		counter_mod_M #(2) count1(clk,1'd1, e, q);

endmodule

module counter_modulo_k
	#(parameter M=20)
	(input clk,aclr,enable,
		input [3:0] x,
	output reg [N-1:0] Q,
	output reg rollover);
	
	localparam N=clogb2(M-1);
	
	function integer clogb2(input [31:0] v);
		for (clogb2 = 0; v > 0; clogb2 = clogb2 + 1)
			v = v >> 1;
	endfunction
	
	always @(posedge clk, negedge aclr)
		if (!aclr) 			
			Q <= x;
		else if (Q == M-1)	
			Q <= {N{1'b0}};
		else if (enable) 		
			Q <= Q + 1'b1;			
		else 	
			Q <= Q;
	
	always @(*)
		if (Q == M-1) 	
			rollover = 1'b1;
		else	
			rollover = 1'b0;
endmodule

module counter_mod_M
						#(parameter M=20)
						(input clk,aclr,enable,
						output reg [N-1:0] Q);
		
		localparam N=clogb2(M-1);
		
		function integer clogb2(input [31:0] v);
			for (clogb2 = 0; v > 0; clogb2 = clogb2 + 1)
				v = v >> 1;
		endfunction
		
		always @(posedge clk, negedge aclr)
			if (!aclr) 			Q <= {N{1'b0}};
			else if (Q == M-1)	Q <= {N{1'b0}};
			else if (enable) 		Q <= Q + 1'b1;			else 			Q <= Q;


endmodule


module decoder_hex_10 (
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
