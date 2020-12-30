module PIPO1(d_out,d_in,ld,clk);
	input  ld, clk;
	input [15:0] d_in;
	output reg [15:0] d_out;
	
	always @(posedge clk)
		begin
			if(ld)
				begin
					d_out <= d_in ;
				end
		end
endmodule