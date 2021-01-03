module debounce_1(db,sw,rst,clk);
	input wire clk, rst, sw;
	output wire db;
	
	localparam [2:0]
		zero = 3'b000,
		wait1_1 = 3'b001,
		wait1_2 = 3'b010,
		wait1_3 = 3'b011,
		one = 3'b100,
		wait0_1 = 3'b101,
		wait0_2 = 3'b110,
		wait0_3 = 3'b111;
		
	localparam N = 19; // 19 for clk = 50Mhz
	reg [N-1:0] q_reg;
	wire [N-1:0] q_next;
	wire m_tick;
	reg [2:0] state_reg, state_next;
	
	always@(posedge clk, posedge rst)
		begin
		if(rst)
			q_reg <= 0;
		else
			q_reg <= q_next;
		end
	
	assign q_next = q_reg + 1;
	assign m_tick = (q_reg == 2**N-1);
	
	always@(posedge clk, posedge rst)
		if(rst)
			state_reg <= 0;
		else 
			state_reg <= state_next;
	
	always @*
		begin
		state_next = state_reg;
		case(state_reg)
			zero:
				if(sw)
					state_next = wait1_1;
			wait1_1:
				if(sw & m_tick)
					state_next = wait1_2;
				else if(~sw)
					state_next = zero;
			wait1_2:
				if(sw & m_tick)
					state_next = wait1_3;
				else if(~sw)
					state_next = zero;
			wait1_3:
				if(sw & m_tick)
					state_next = one;
				else if(~sw)
					state_next = zero;
			one:
				if(~sw)
					state_next = wait0_1;
			wait0_1:
				if(sw)
					state_next = one;
				else if(m_tick)
					state_next = wait0_2;
			wait0_2:
				if(sw)
					state_next = one;
				else if(m_tick)
					state_next = wait0_3;
			wait0_3:
				if(sw)
					state = one;
				else if(m_tick)
					state_next = zero;
		endcase
		end
		
	assign db = (state_reg == one);
endmodule	