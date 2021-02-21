module reg_file(rd_reg1, rd_reg2, wr_reg, wr_data, DAT1, DAT2, reg_wr, rst, clk);

	input wire [4:0] rd_reg1, rd_reg2, wr_reg;
	input wire reg_wr, rst, clk;
	input wire [31:0] wr_data;
	output reg [31:0] DAT1, DAT2;
	
	reg [31:0] reg_num [31:0];
	integer i;
	
	always @(posedge rst, posedge clk)
		begin
		if(rst)
			begin
			for(i = 0; i < 32; i = i+1)
				reg_num[i] <= i;
			end
		else
			begin
			if(reg_wr)
				begin
				reg_num[wr_reg] <= wr_data;
				end
			end
		end
	
	always @(*)
		begin
		DAT1 = reg_num[rd_reg1];
		DAT2 = reg_num[rd_reg2];
		end
endmodule 