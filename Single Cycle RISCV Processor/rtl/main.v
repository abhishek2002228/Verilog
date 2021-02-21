`include "ALU.v" 
`include "ALU_Control.v"
`include "control_unit.v"
`include "Data_Mem.v"
`include "Imm_Gen.v"
`include "Instr_Mem.v"
`include "reg_file.v"

module main(rst, clk);
	input wire rst, clk;
	
	wire [4:0] rs1, rs2, rd;
	wire [31:0] instr, wr_data, DAT1, DAT2, In2, ALU_Result, mem_rd_data, Imm_out, br_addr, PC_incr;
	wire [31:0] Offset, PC_next;
	reg [31:0] PC_reg; // initialise to 0 on reset
	wire regwr, alusrc, memread, memwrite, memtoreg, branch, Zero, pcsrc;
	wire [6:0] opcode, funct7;
	wire [1:0] immsel, aluop;
	wire [2:0] funct3;
	wire [3:0] ALU_Cntrl;
	
	assign rs1 = instr[19:15];
	assign rs2 = instr[24:20];
	assign rd = instr[11:7];
	assign opcode = instr[6:0];
	assign funct3 = instr[14:12];
	assign funct7 = instr[31:25];
	assign In2 = (alusrc)? Imm_out: DAT2;
	assign wr_data = (memtoreg)? mem_rd_data: ALU_Result;
	assign pcsrc = branch & Zero;
	assign PC_incr = PC_reg + 4;
	assign br_addr = PC_reg + Offset;
	assign Offset = (Imm_out << 1);
	assign PC_next = (pcsrc)? br_addr: PC_incr;
	
	control_unit cu(opcode, regwr, immsel, alusrc, aluop, memread, memwrite, memtoreg, branch);
	ALU_Control_Unit alu_cu(aluop, funct3, funct7, ALU_Cntrl);
	Instr_Mem I_mem(PC_reg,instr);
	reg_file regs(rs1, rs2, rd, wr_data, DAT1, DAT2, regwr, rst, clk);
	ALU alu(ALU_Cntrl, DAT1, In2, Zero, ALU_Result);
	Data_mem D_mem(ALU_Result,DAT2,mem_rd_data,memread,memwrite, clk, rst);
	Imm_Gen immgen(instr, Imm_out, immsel);
	
	always @(posedge clk, posedge rst)
		begin
		if(rst)
			PC_reg <= 0;
		else
			PC_reg <= PC_next;
		end
		
endmodule