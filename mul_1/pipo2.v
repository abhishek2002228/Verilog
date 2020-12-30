module PIPO2(d_out,d_in,ld,clr,clk);
	input ld,clr,clk;
	input [15:0] d_in;
	output reg [15:0] d_out;
	
	always @(posedge clk)
		begin
			if(clr)
				begin
					d_out <= 16'b0 ;
				end
			else if(ld)
				begin
					d_out <= d_in;
				end
		end
endmodule