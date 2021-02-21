module Instr_Mem(PC,instr);
	input wire rst;
	input wire [31:0] PC;
	output wire [31:0] instr;
	
	reg [7:0] i_mem [(2^32)-1 : 0] ;
	
	initial
		begin
		i_mem[0] = 8'hB3;
		i_mem[1] = 8'h81;
		i_mem[2] = 8'h40;
		i_mem[3] = 8'h00;
		i_mem[4] = 8'hB3;
		i_mem[5] = 8'h81;
		i_mem[6] = 8'h11;
		i_mem[7] = 8'h40;
		i_mem[8] = 8'h23;
		i_mem[9] = 8'h28;
		i_mem[10] = 8'h10;
		i_mem[11] = 8'h00;
		i_mem[12] = 8'h83;
		i_mem[13] = 8'h21;
		i_mem[14] = 8'h00;
		i_mem[15] = 8'h01;
		i_mem[16] = 8'h63;
		i_mem[17] = 8'h08;
		i_mem[18] = 8'h00;
		i_mem[19] = 8'h00;
		end 
		
	assign instr = {i_mem[PC+3],i_mem[PC+2],i_mem[PC+1],i_mem[PC]};
	
endmodule