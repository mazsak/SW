module diode_flashing_board(
											input CLOCK_50,
											output [7:0] LEDR);

		wire c0, c1, c2, c3, c4, c5, c6, c7;
		wire [1:0] a0, a1, a2, a3, a4, a5, a6, a7;
		
		delay #(5000000) ex10(CLOCK_50, c0);
		delay #(12500000) ex11(CLOCK_50, c1);
		delay #(25000000) ex12(CLOCK_50, c2);
		delay #(40000000) ex13(CLOCK_50, c3);
		delay #(60000000) ex14(CLOCK_50, c4);
		delay #(75000000) ex15(CLOCK_50, c5);
		delay #(90000000) ex16(CLOCK_50, c6);
		delay #(100000000) ex17(CLOCK_50, c7);
		
		counter_modulo_k #(2) count1(~c0,1'd1,1'd1,a0,LEDR[0]);
		counter_modulo_k #(2) count2(~c1,1'd1,1'd1,a1,LEDR[1]);
		counter_modulo_k #(2) count3(~c2,1'd1,1'd1,a2,LEDR[2]);
		counter_modulo_k #(2) count4(~c3,1'd1,1'd1,a3,LEDR[3]);
		counter_modulo_k #(2) count5(~c4,1'd1,1'd1,a4,LEDR[4]);
		counter_modulo_k #(2) count6(~c5,1'd1,1'd1,a5,LEDR[5]);
		counter_modulo_k #(2) count7(~c6,1'd1,1'd1,a6,LEDR[6]);
		counter_modulo_k #(2) count8(~c7,1'd1,1'd1,a7,LEDR[7]);
		
		
 
endmodule

module delay
				#(parameter M=20)
				(input clk,
				output q);
					
		wire [25:0] A;
		wire	e, q1;
					
		counter_mod_M #(M) count0(clk,1'd1,1'd1,A);

		assign e = ~|A;
		
		counter_mod_M #(2) count1(clk,1'd1,e,q);

endmodule

module counter_modulo_k
	#(parameter M=20)
	(input clk,aclr,enable,
	output reg [N-1:0] Q,
	output reg rollover);
	
	localparam N=clogb2(M-1);
	
	function integer clogb2(input [31:0] v);
		for (clogb2 = 0; v > 0; clogb2 = clogb2 + 1)
			v = v >> 1;
	endfunction
	
	always @(posedge clk, negedge aclr)
		if (!aclr) 			
			Q <= {N{1'b0}};
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
