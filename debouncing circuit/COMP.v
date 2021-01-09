module COMP(out,in1,in2);
	localparam N = 3;
	input wire [N-1:0] in1, in2;
	output wire out;
	
	assign out = (in1 == in2);
endmodule