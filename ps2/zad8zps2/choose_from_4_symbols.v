module choose_from_4_symbols(  
		input u, v, w, x, S0, S1,
		output reg [0:6] h);
		
		assign m = (~S0 & ~S1 & u) | (S0 & ~S1 &v) | (~S0 & S1 & w) | (S0 & S1 & x);

		
		always @(*)
			casex(m)
				4'd0: h=7'b0000001;
				4'd1: h=7'b1001111;
				4'd2: h=7'b0010010;
				4'd3: h=7'b0000110;
				default: h=7'b1111111;
			endcase
	
endmodule