module rx(dout,rx_done,s_tick,rx,clk,rst);
	parameter data_size = 8, stop_ticks = 16;
	input wire clk, rst, rx, s_tick;
	output reg rx_done;
	output wire [data_size-1:0] dout;
	
	reg [1:0] state_reg, state_next;
	reg [3:0] s_reg, s_next;
	reg [2:0] n_reg, n_next;
	reg [data_size-1:0] b_reg, b_next;
	
	localparam [1:0]
		idle = 2'b00,
		start = 2'b01,
		data = 2'b10,
		stop = 2'b11;
	
	//state and register logic
	always @(posedge clk, posedge rst)
		begin
		if(rst)
			begin
			state_reg <= idle;
			s_reg <= 0;
			n_reg <= 0;
			b_reg <= 0;
			end
		else
			begin
			state_reg <= state_next;
			s_reg <= s_next;
			n_reg <= n_next;
			b_reg <= b_next;
			end
		end
		
	//next state and output logic
	always @*
		begin
		state_next = state_reg;
		s_next = s_reg;
		n_next = n_reg;
		b_next = b_reg;
		rx_done = 1'b0;
		case(state_reg)
			idle:
				begin
				if(rx==0)
					begin
					s_next = 0;
					state_next = start;
					end
				end
			start:
				begin
				if(s_tick==1)
					begin
					if(s_reg==7)
						begin
						s_next = 0;
						n_next = 0;
						state_next = data;
						end
					else
						begin
						s_next = s_reg + 1;
						end
					end
				end
			data:
				begin
				if(s_tick==1)
					begin
					if(s_reg==15)
						begin
						s_next = 0;
						b_next = {rx,b_reg[7:1]};
						if(n_reg==data_size-1)
							state_next = stop;
						else
							n_next = n_reg + 1;
						end
					else
						s_next = s_reg + 1;
					end
				end
			stop:
				begin
					if(s_tick==1)
						begin
						if(s_reg==stop_ticks-1)
							begin
							rx_done = 1'b1;
							state_next = idle;
							end
						else
							s_next = s_reg + 1;
						end
				end
		endcase
		end
	assign dout = b_reg;
endmodule
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		