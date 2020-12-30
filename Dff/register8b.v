module register(Q,D,clk,rst);
	input wire clk, rst;
	input wire [7:0] D;
	output reg [7:0] Q;
	
	always @(posedge ckl)
		begin
			if(rst)
				Q <= 8'b0;
			else 
				Q <= D;
		end
endmodule