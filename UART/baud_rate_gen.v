module baud_gen(s_tick,q,clk,rst);
	parameter N = 8; // mod 163 -> 8 bits atleast
	parameter M = 163;
	input wire clk, rst;
	output wire s_tick;
	output wire [N-1:0] q;
	
	reg [N-1:0] r_reg;
	wire [N-1:0] r_next;
	
	always @(posedge clk, posedge rst)
		begin
			if(rst)
				r_reg <= 0;
			else 
				r_reg <= r_next;
		end
	
	assign r_next = (r_reg == (M-1)) ? 0 : r_reg + 1;
	assign s_tick = (r_reg == M-1);
	assign q = r_reg;
	
endmodule 