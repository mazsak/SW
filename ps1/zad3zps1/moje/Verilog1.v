module adder_1_bit (
				input a, b, cin,
		      output s, cout);

	assign {cout, s} = a + b + cin;
	
endmodule
