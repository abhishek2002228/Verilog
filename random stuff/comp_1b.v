module comp_1b(eq,in1,in2)
	input wire in1, in2;
	output reg eq;
	reg p0,p1;
	
	always @(in1 or in2)
		begin
			p0 = ~in1 & ~in2 ;
			p1 = in1 &in2 ;
			eq = p0|p1 ;
		end
endmodule
