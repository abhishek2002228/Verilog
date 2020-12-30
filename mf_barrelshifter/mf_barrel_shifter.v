module mf_barrel_shifter(out,in,amt,lr)
	input wire [7:0] in ;
	input wire [2:0] amt;
	input wire lr ;
	output wire [7:0] out ;
	
	wire [7:0] out1, out2;
	
	rotate_right A(out1,in,amt);
	rotate_left B(out2,in,amt);
	
	assign out = lr ? out1 : out2 ; // 1 for rotate right , 0 for rotate left
endmodule