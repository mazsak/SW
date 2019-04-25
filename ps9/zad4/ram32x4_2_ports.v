module ram32x4_2_ports(
		input [9:0] SW,
		input CLOCK_50,
		input [1:0] KEY,
		output [0:6] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	
	wire clk_1_sec;
	wire [4:0] read_addr;
	wire [3:0] q;

	delay #(50000000) ex0(CLOCK_50, clk_1_sec);
	
	counter_N_bits #(5) cnt_addr(clk_1_sec,KEY[0],1'b1,read_addr);
	
	ram32x4 mem(CLOCK_50,SW[3:0],read_addr,SW[8:4],SW[9],q);
	
	decoder_hex_16 d0(q,HEX0);
	decoder_hex_16 d1(SW[3:0],HEX1);
	decoder_hex_16 d2(read_addr[3:0],HEX2);
	decoder_hex_16 d3({3'b000,read_addr[4]},HEX3);
	decoder_hex_16 d4(SW[7:4],HEX4);
	decoder_hex_16 d5({3'b000,SW[8]},HEX5);
			
endmodule

module delay
				#(parameter M=20)
				(input clk,
				output q);
					
		wire [26:0] A;
		wire	e, q1;
					
		counter_mod_M #(M) count0(clk,1'd1,1'd1,A);

		assign e = ~|A;
		
		counter_mod_M #(2) count1(clk,1'd1,e,q);

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
			else if (enable) 		Q <= Q + 1'b1;			
			else 			Q <= Q;


endmodule

module counter_N_bits
	#(parameter N=16)
	(input clk,aclr,enable,
	output reg [N-1:0] Q);
	
	always @(posedge clk, negedge aclr)
		if (!aclr) 		Q <= {N{1'b0}};
		else if (enable) 	Q <= Q + 1'b1;
		else 		Q <= Q;
		
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
