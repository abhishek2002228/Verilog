module fb(fib_out,done_tick,ready,fib_in,start,clk,rst);
	parameter N1 = 5, N2 = 20;
	input wire start, clk, rst;
	input wire [N1-1:0] fib_in;
	output reg done_tick, ready;
	output wire [N2-1:0] fib_out;
	
	//states
	localparam [1:0] idle = 2'b00, op = 2'b01, done = 2'b10;
	
	//registers used 
	reg [N2-1:0] t0_reg, t1_reg, t0_next, t1_next;
	reg [1:0] state_reg, state_next;
	reg [N1-1:0] index_reg, index_next;
	
	//state and register logic
	always @(posedge clk, posedge rst)
		begin
		if(rst)
			begin
			state_reg <= idle;
			t0_reg <= 0;
			t1_reg <= 0;
			index_reg <= 0;
			end
		else 
			begin
			state_reg <= state_next;
			t0_reg <= t0_next;
			t1_reg <= t1_next;
			index_reg <= index_next;
			end
		end
	
	//next state logic and output logic
	always @* 
		begin
		state_next = state_reg;
		t0_next = t0_reg;
		t1_next = t1_reg;
		index_next = index_reg;
		done_tick = 1'b0;
		ready = 1'b0;
		case(state_reg)
			idle:
				begin
				ready = 1'b1;
				if(start)
					begin
					t0_next = {(N2){1'b0}};
					t1_next = {(N2){1'b1}};
					index_next = fib_in;
					state_next = op;
					end
				end
			op:
				begin
				if(index_reg == 0)
					begin
					t1_next = 0;
					state_next = done;
					end
				else if(index_reg == 1)
					begin
					state_next = done;
					end
				else 
					begin
					t1_next = t0_reg + t1_reg;
					t0_next = t1_reg;
					index_next = index_reg - 1;
					end
				end
			done:
				begin
				done_tick = 1'b1;
				state_next = idle;
				end
			default: state_next = idle;
		endcase
		end
	assign fib_out = t1_reg;
endmodule
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	