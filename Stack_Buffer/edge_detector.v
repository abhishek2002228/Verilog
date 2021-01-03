 module edge_detector(clk,rst,lvl,edge_tick);
	input wire clk, rst, lvl;
	output wire edge_tick;
	
	localparam zero=2'b00, edg=2'b01, one=2'b10;
	
	reg [1:0] state_reg, state_next;
	
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
					state_next = edg;
			edg:
				begin
				if(lvl)
					state_next = one;
				else
					state_next = zero;
				end
			one:
				if(~lvl)
					state_next = zero;
			default: 
				state_next = zero;
		endcase
		end
	
	assign edge_tick = (state_reg == edg) ;
	