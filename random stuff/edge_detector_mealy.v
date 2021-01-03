module edge_detector_mealy(clk,rst,lvl,edge_tick);
	input wire clk, rst, lvl;
	output reg edge_tick;
	wire tick;
	
	reg state_reg, state_next;
	localparam zero=1'b0, one=1'b1;
	
	always @(posedge clk, posedge rst)
		begin
		if(rst)
			state_reg <= zero;
		else
			state_reg <= state_next;
		end
	
	always @*
		begin
		state_next = state_reg;
		case(state_reg)
			zero:
				if(lvl)
					state_next = one;
			one:
				if(~lvl)
					state_next = zero;
		endcase
		end
	assign tick = (~state_reg)&(lvl);
	
	always @(posedge clk, posedge rst)
		if(rst)
			edge_tick <= 1'b0;
		else
			edge_tick <= tick;

endmodule