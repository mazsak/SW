module circuit_a (
						input [3:0] x,
						output reg [3:0] m);

		always @(*)
		begin
		if(x[3:0] > 4'b1001)
			m = x - 4'd10;
		end
		
endmodule