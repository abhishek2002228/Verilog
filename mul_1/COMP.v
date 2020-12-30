module COMP(eqz, d_in);
	input [15:0] d_in;
	output eqz;
	
	assign eqz = ~(|d_in);
	
endmodule 