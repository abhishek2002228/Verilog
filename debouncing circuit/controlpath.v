module controlpath(q_load,q_dec,db_tick_output,db_level,sw,q_zero,clk,rst);
	input wire sw, clk, q_zero, rst;
	output reg q_dec, q_load, db_level, db_tick, db_tick_output;
	
	reg [1:0] state_reg, state_next;
	
	localparam [1:0] 
		zero = 2'b00,
		wait1 = 2'b01,
		one = 2'b10,
		wait0 = 2'b11;
	
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
		q_load = 1'b0;
		q_dec = 1'b0;
		db_tick = 1'b0;
		case(state_reg)
			zero:
				begin
				db_level = 1'b0;
				if(sw)
					begin
					state_next = wait1;
					q_load = 1'b1;
					end
				end
			wait1:
				begin
				db_level = 1'b0;
				if(~sw)
					begin
					state_next = zero;
					end
				else if(q_zero)
					begin
					state_next = one;
					db_tick = 1'b1;
					end
				else
					q_dec = 1'b1;
				end
			one:
				begin
				db_level = 1'b1;
				if(~sw)
					begin
					state_next = wait0;
					q_load = 1'b1;
					end
				end
			wait0:
				begin
				db_level = 1'b1;
				if(sw)
					state_next = one;
				else if(q_zero)
					state_next = zero;
				else 
					q_dec = 1'b1;
				end
			default: state_next = zero;
		endcase
		end
		
	always @(posedge clk, posedge rst)
		begin
		if(rst)
			db_tick_output <= 1'b0;
		else
			db_tick_output <= db_tick;
		end

endmodule 