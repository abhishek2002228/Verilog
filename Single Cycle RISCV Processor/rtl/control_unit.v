module control_unit(opcode, regwrite, immsel, alusrc, aluop, memread, memwrite, memtoreg, branch);
	input wire [6:0] opcode;
	output reg [1:0] immsel, aluop;
	output reg regwrite, alusrc, memread, memwrite, memtoreg, branch;
	
	localparam [6:0] R_type = 7'b0110011, I_type = 7'b0000011, S_type = 7'b0100011, B_type = 7'b1100011;
	
	always @(*)
		begin
		case(opcode)
			R_type:
				begin
				immsel = 2'bxx;
				regwrite = 1'b1;
				alusrc = 1'b0;
				aluop = 2'b10;
				memread = 1'b0;
				memwrite = 1'b0;
				memtoreg = 1'b0;
				branch = 1'b0;
				end
			I_type:
				begin
				immsel = 2'b00;
				regwrite = 1'b1;
				alusrc = 1'b1;
				aluop = 2'b00;
				memread = 1'b1;
				memwrite = 1'b0;
				memtoreg = 1'b1;
				branch = 1'b0;
				end
			S_type:
				begin
				immsel = 2'b01;
				regwrite = 1'b0;
				alusrc = 1'b1;
				aluop = 2'b00;
				memread = 1'b0;
				memwrite = 1'b1;
				memtoreg = 1'bx;
				branch = 1'b0;
				end
			B_type:
				begin
				immsel = 2'b10;
				regwrite = 1'b0;
				alusrc = 1'b0;
				aluop = 2'b01;
				memread = 1'b0;
				memwrite = 1'b0;
				memtoreg = 1'bx;
				branch = 1'b1;
				end
			default:
				begin
				immsel = 2'bxx;
				regwrite = 1'b0;
				alusrc = 1'b0;
				aluop = 2'bxx;
				memread = 1'b0;
				memwrite = 1'b0;
				memtoreg = 1'b0;
				branch = 1'b0;
				end
		endcase
		end
endmodule