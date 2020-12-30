module CNTR(d_out,d_in,ld,dec,clk);
	input ld,dec,clk;
	input [15:0] d_in;
	output reg [15:0] d_out;
	
	always @(posedge clk)
		begin
			if(ld)
				begin
					d_out <= d_in;
				end
			else if(dec)
				begin
					d_out <= d_out - 1;
				end
		end
endmodule