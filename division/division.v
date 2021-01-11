module divison(quo,rem,ready,done_tick,dvsr,dvdn,start,clk,rst);
	parameter W = 8, CBIT = 4;
	input wire clk, rst, start;
	input wire [W-1:0] dvsr, dvdn;
	output reg ready, done_tick;
	output wire [W-1:0] quo, rem;
	
	localparam [1:0]
		idle = 2'b00,
		op = 2'b01,
		last = 2'b10,
		done = 2'b11;
		
	reg [1:0] state_reg, state_next;
	reg [W-1:0] rh_reg, rh_next, rl_reg, rl_next, rh_tmp;
	reg [W-1:0] d_reg, d_next;
	reg [CBIT-1:0] n_reg, n_next;
	reg q_bit;
	
	always @(posedge clk, posedge rst)
		if(rst)
			begin
			state_reg <= idle;
			rh_reg <= 0;
			rl_reg <= 0;
			d_reg <= 0;
			n_reg <= 0;
			end
		else
			begin
			state_reg <= state_next;
			rh_reg <= rh_next;
			rl_reg <= rl_next;
			d_reg <= d_next;
			n_reg <= n_next;
			end
	always @*
		begin
		state_next = state_reg;
		rh_next = rh_reg;
		rl_next = rl_reg;
		d_next = d_reg;
		n_next = n_reg;
		done_tick = 1'b0;
		ready = 1'b0;
		case(state_reg)
			idle:
				begin
				ready = 1'b1;
				if(start)
					begin
					rh_next = 0;
					rl_next = dvdn;
					d_next = dvsr;
					n_next = CBIT;
					state_next = op;
					end
				end
			op:
				begin
				rl_next = {rl_reg[W-2:0],q_bit};
				
				rh_next = {rh_tmp[W-2:0],rl_reg[W-1]};
				
				n_next = n_reg - 1;
				if(n_next == 1)
					state_next = last;
				end
			last:
				begin
				end
		end
	