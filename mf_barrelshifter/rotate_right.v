module rotate_right(out,in,amt);
	input wire [7:0] in;
	input wire [2:0] amt;
	output wire [7:0] out;

	wire [7:0] s0,s1;
	
	
	assign s0 = amt[0]? {in[0],in[7:1]} : in ;
	assign s1 = amt[1]? {s0[1:0],s0[7:2]} : s0 ;
	assign out = amt[2]? {s1[3:0],s1[7:4]} : s1 ;

endmodule	