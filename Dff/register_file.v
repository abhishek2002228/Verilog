module register_file 
	#(parameter B = 8,
	  parameter W = 2) 
	(input wire clk, wr_en, rd_en,
	 input wire [W-1:0] wr_addr, rd_addr,
	 input wire [B-1:0] wr_data,
	 output wire [B-1:0] rd_data
	 );
	
	reg [B-1:0] reg_file [2**W-1:0] ;
	
	always @(posedge clk)
		if(wr_en)
			reg_file[wr_addr] <= wr_data ;
		
	assign rd_data = rd_en? reg_file[rd_addr] : {(B)(1'bz)} ;
endmodule