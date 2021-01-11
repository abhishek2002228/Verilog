module tx_interface(t_x,full,wr_data,wr,s_tick,rst,clk);
	input wire s_tick, rst, clk, wr;
	input wire [7:0] wr_data;
	output wire full, t_x;
	
	wire empty, tx_done;
	wire [7:0] rd_data;
	wire tx_start;
	wire [6:0] fifo_cntr_reg;
	
	assign tx_start = ~empty;
	
	tx A(t_x,tx_done,rd_data,tx_start,s_tick,clk,rst);
	fifo_single_clock B(fifo_cntr_reg,empty,full,rd_data,wr_data,rst,wr,tx_done,clk);
endmodule