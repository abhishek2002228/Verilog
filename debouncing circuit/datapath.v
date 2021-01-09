module datapath(q_zero,load,dec,rst,clk);
	localparam N = 3;
	input wire load, dec, rst, clk;
	output wire q_zero;
	
	wire [N-1:0] buf_out;
	wire [N-1:0] zero;
	
	assign zero = {(N){1'b0}} ;
	
	CNTR A(buf_out,load,dec,rst,clk);
	COMP B(q_zero,zero,buf_out);
endmodule
