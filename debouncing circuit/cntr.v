module CNTR(buf_out,load,dec,rst,clk);
	localparam N = 3;
	input wire load, dec, rst, clk;
	output wire [N-1:0] buf_out;

	reg [N-1:0] q_reg, q_next;
	
	assign buf_out = q_reg;
	
	always @(posedge clk, posedge rst)
		if(rst)	
			q_reg <= 0;
		else
			q_reg <= q_next;

	always @*
		if(load)
			q_next = {(N){1'b1}};
		else if(dec)
			q_next = q_reg - 1;
		else 
			q_next = q_reg;
endmodule