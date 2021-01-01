module fifo_single_clock(fifo_cntr_reg, empty_reg, full_reg, buf_out, buf_in, rst, wr, rd, clk);
	input wire clk, rst, rd, wr ;
	input wire [7:0] buf_in ;
	output reg [7:0] buf_out ;
	output reg [6:0] fifo_cntr_reg ; // should count from 0 to 64
	output reg empty_reg, full_reg ;
	
	wire rd_en, wr_en;
	reg [7:0] buf_mem [63:0] ; // 8 bit words in 64
	reg [5:0] rd_ptr_reg, wr_ptr_reg;
	reg [5:0] rd_ptr_next, wr_ptr_next;
	reg empty_next, full_next;
	reg [6:0] fifo_cntr_next;
	
	assign rd_en = (~empty_reg) & rd;
	assign wr_en = (~full_reg) & wr;
	
	always @(posedge clk, posedge rst)
		begin
		if(rst)
			begin
			empty_reg <= 1'b1;
			full_reg <= 1'b0;
			rd_ptr_reg <= 0;
			wr_ptr_reg <= 0;
			fifo_cntr_reg <= 0;
			end
		else
			begin
			empty_reg <= empty_next;
			full_reg <= full_next;
			rd_ptr_reg <= rd_ptr_next;
			wr_ptr_reg <= wr_ptr_next;
			fifo_cntr_reg <= fifo_cntr_next;
			end
		end	
	
	always @(posedge clk)
		begin
		if(wr_en & rd_en)
			begin
			buf_mem[wr_ptr_reg] <= buf_in;
			buf_out <= buf_mem[rd_ptr_reg];
			end
		else if(wr_en)
			begin
			buf_mem[wr_ptr_reg] <= buf_in;
			buf_out <= {(8){1'bz}};
			end
		else if(rd_en)
			begin
			buf_out <= buf_mem[rd_ptr_reg];
			end
		else
			begin
			buf_out <= {(8){1'bz}};
			end
		end
	always @(*)
		begin
		empty_next = empty_reg ;
		full_next = full_reg;
		rd_ptr_next = rd_ptr_reg;
		wr_ptr_next = wr_ptr_reg;
		fifo_cntr_next = fifo_cntr_reg;
		case({rd,wr})
			2'b01:
				begin
				if(~full_reg)
					begin
					empty_next = 1'b0 ;
					fifo_cntr_next = fifo_cntr_reg + 1;
					full_next = (fifo_cntr_next == 64);
					rd_ptr_next = rd_ptr_reg;
					wr_ptr_next = wr_ptr_reg + 1;
					end
				end
			2'b10:
				begin
				if(~empty_reg)
					begin
					full_next = 1'b0;
					fifo_cntr_next = fifo_cntr_reg - 1;
					empty_next = (fifo_cntr_next == 0);
					rd_ptr_next = rd_ptr_reg + 1;
					wr_ptr_next = wr_ptr_reg;
					end
				end
			2'b11:
				begin
				if(~empty_reg & ~full_reg)
					begin
					rd_ptr_next = rd_ptr_reg + 1;
					wr_ptr_next = wr_ptr_reg + 1;
					end
				end
		endcase
		end
	endmodule
	