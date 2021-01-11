module tx(tx,tx_done,din,tx_start,s_tick,clk,rst);
	parameter data_size = 8, stop_ticks = 16;
	input wire clk, rst, s_tick, tx_start;
	input wire [7:0] din;
	output wire tx;
	output reg tx_done;
	
	reg [1:0] state_reg, state_next;
	reg [3:0] s_reg, s_next;
	reg [2:0] n_reg, n_next;
	reg [data_size-1:0] b_reg, b_next;
	
	reg tx_reg, tx_next;
	
	localparam [1:0]
		idle = 2'b00,
		start = 2'b01,
		data = 2'b10,
		stop 2'b11;
	
	always @(posedge clk, posedge rst)
		begin
		if(rst)
			begin
			state_reg <= idle;
			s_reg <= 0;
			n_reg <= 0;
			b_reg <= 0;
			tx_reg <= 1'b1;
			end
		else
			begin
			state_reg <= state_next;
			s_reg <= s_next;
			n_reg <= n_next;
			b_reg <= b_next;
			tx_reg <= tx_next;
			end
		end
	
	always @*
		begin
		state_next = state_reg;
		s_next = s_reg;
		n_next = n_reg;
		b_next = b_reg;
		tx_next = tx_reg;
		tx_done = 1'b0;
		case(state_reg)
			idle:
				begin
				tx_next = 1'b1;
				if(tx_start==1)
					begin
					s_next = 0;
					b_next = din;
					state_next = start;
					end
				end
			start:
				begin
				tx_next = 1'b0;
				if(s_tick)
					if(s_reg==15)
						begin
						s_next = 0;
						n_next = 0;
						state_next = data;
						end
					else
						s_next = s_reg + 1;
				end
			data:
				begin
				tx_next = b_reg[0];
				if(s_tick)
					if(s_reg==15)
						begin
						b_next = b_reg >> 1; //LSB first
						s_next = 0;
						if(n_reg==(data_size-1))
							state_next = stop;
						else
							n_next = n_reg + 1;
						end
					else
						s_next = s_reg + 1;
				end
			stop:
				begin
				tx_next = 1'b1;
				if(s_tick)
					if(s_reg==(stop_ticks-1))
						begin
						state_next = idle;
						tx_done = 1'b1;
						end
					else
						s_next = s_reg + 1;
				end
		endcase
		end	
	assign tx = tx_reg;
endmodule