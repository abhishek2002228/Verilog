module test_ALU();
	wire [3:0] ALU_Cntrl;
	reg [31:0] In1, In2;
	reg [1:0] ALU_Op;
	reg [6:0] funct7;
	reg [2:0] funct3;
	wire Zero;
	wire [31:0] ALU_Result;
	
	ALU A(ALU_Cntrl, In1, In2, Zero, ALU_Result);
	ALU_Control_Unit B(ALU_Op, funct3, funct7, ALU_Cntrl);
	
	initial
		begin
		ALU_Op = 2'd0;
		funct3 = 3'd0;
		funct7 = 7'd0;
		In1 = 32'd1;
		In2 = 32'd2;
		
		#10
		
		ALU_Op = 2'd1;
		funct3 = 3'd0;
		funct7 = 7'd0;
		In1 = 32'd10;
		In2 = 32'd2;

		#10
		
		ALU_Op = 2'd2;
		funct3 = 3'd0;
		funct7 = 7'd32;
		In1 = 32'd12;
		In2 = 32'd2;

		#10
		
		ALU_Op = 2'd2;
		funct3 = 3'b111;
		funct7 = 7'd0;
		In1 = 32'd1;
		In2 = 32'd2;
		
		#10 $finish;
		end
	
	initial
		begin
		$dumpfile("ALU.vcd");
		$dumpvars(0,test_ALU);
		end
endmodule