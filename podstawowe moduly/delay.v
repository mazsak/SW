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