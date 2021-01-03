module stack(error,size,buf_out,empty,full,buf_in,rst,push,pop,clk);
	input wire [7:0] buf_in;
	input wire clk,rst,push,pop; // push -> 0 , pop -> 1 
	output wire [4:0] size; // max size = 16 ( 5 bits )
	output wire empty, full;
	output reg error;
	output reg [7:0] buf_out;
	
	reg [7:0] buf_mem [15:0]; // 8x16
	reg [4:0] SP_reg, SP_next; // extra bit for initial value of SP
	reg empty_reg, full_reg;
	reg empty_next, full_next;
	reg [4:0] size_reg, size_next;
	wire rd_en, wr_en;
	
	assign empty = empty_reg;
	assign full = full_reg;
	assign size = size_reg;
	assign rd_en = pop & ~empty_reg;
	assign wr_en = push & ~full_reg;
	
	always @(posedge clk, posedge rst)
		begin
		if(rst)
			begin
			SP_reg <= 5'd16;
			empty_reg <= 1'b1;
			full_reg <= 1'b0;
			size_reg <= 5'd0;
			end
		else
			begin
			SP_reg <= SP_next;
			empty_reg <= empty_next;
			full_reg <= full_next;
			size_reg <= size_next;
			end
		end
	
	always @(posedge clk)
		begin
		if(rd_en & wr_en) 
			error <= 1;		
		else if(rd_en)
			begin
			error <= 0;
			buf_out <= buf_mem[SP_reg];
			end
		else if(wr_en)
			begin
			error <= 0;
			buf_mem[SP_next] <= buf_in;
			end
		else
			buf_out <= {(8){1'bz}};
		end
	always @*
		begin
		empty_next = empty_reg ;
		full_next = full_reg;
		SP_next = SP_reg;
		size_reg = size_next;
		case({push,pop})
			2'b01:
				begin
				if(~empty_reg)
					begin
					full_next = 1'b0;
					SP_next = SP_reg + 1;
					empty_next = SP_next[4];
					size_next = 5'd16 - SP_next;
				end
			2'b10:
				begin
				if(~full_reg)
					begin
					empty_next = 1'b0;
					SP_next = SP_reg - 1;
					full_next = (SP_next == 0);
					size_next = 5'd16 - SP_next;
					end
		endcase
		end
endmodule
		
		
		
		
		
		
		