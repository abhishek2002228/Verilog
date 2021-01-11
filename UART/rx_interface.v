module rx_interface(full,empty,rd_data,rd,s_tick,r_x,rst,clk);
	input wire rd, s_tick, clk, r_x, rst;
	output wire full, empty;
	output wire [7:0] rd_data;
	
	wire [7:0] dout;
	wire rx_done;
	wire [6:0] fifo_cntr_reg;
	
	rx A(dout,rx_done,s_tick,r_x,clk,rst);
	fifo_single_clock B(fifo_cntr_reg,empty,full,rd_data,dout,rst,rx_done,rd,clk);
endmodule