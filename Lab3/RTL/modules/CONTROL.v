module CONTROL (
	input  wire clk,
	input  wire rstn,
	input wire [31:0] I_OP,
	output reg O_ALUSrc,
	output reg O_MemtoReg,
	output reg O_RegWrite,
	output reg [3:0]O_MemRead,
	output reg O_MemWrite,
	output reg [3:0] O_ALUOp,
	output reg isnot_PC_4,
	output reg isJALR,
	output reg isCout,
	output reg isJAL,
	output reg is_down_se,
	output reg isLUI,
	output reg isLUIAUI,
	output reg is_sign_ex,
	output reg isSLLISRLISRAI,
	output reg issw
	//output wire O_ALUOp2
);

always @(posedge rstn) begin
		O_ALUSrc=0;
		O_MemtoReg=0;
		O_RegWrite=0;
		O_MemRead=4'b0;
		O_MemWrite=0;
		O_ALUOp=4'b0;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
end

always @(*) begin
	if (I_OP[31:25]==7'b0000000&&I_OP[6:0]==7'b0110011&&I_OP[14:12]==3'b000)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b0000;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
		//TODO ADD
	end

	if(I_OP[31:25]==7'b0000000&&I_OP[6:0]==7'b0110011&&I_OP[14:12]==3'b111)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b0010;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
		//AND
	end

	if(I_OP[31:25]==7'b0000000&&I_OP[6:0]==7'b0110011&&I_OP[14:12]==3'b110)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b0011;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
		//OR
	end

	if(I_OP[31:25]==7'b0000000&&I_OP[6:0]==7'b0110011&&I_OP[14:12]==3'b100)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b0110;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
		//XOR
	end
	if(I_OP[31:25]==7'b0000000&&I_OP[6:0]==7'b0110011&&I_OP[14:12]==3'b010)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b1100;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
		//SLT
	end


	if(I_OP[31:25]==7'b0000000&&I_OP[6:0]==7'b0110011&&I_OP[14:12]==3'b011)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b0100;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
		//SLTU
	end

	if(I_OP[31:25]==7'b0000000&&I_OP[6:0]==7'b0110011&&I_OP[14:12]==3'b101)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b1010;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
		//SRL
	end

	if(I_OP[31:25]==7'b0000000&&I_OP[6:0]==7'b0110011&&I_OP[14:12]==3'b001)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b0101;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//SLL
	end




	if (I_OP[31:25]==7'b0000000&&I_OP[6:0]==7'b0010011&&I_OP[14:12]==3'b101)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=0;
		O_ALUOp=4'b1010;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=1;
		issw=0;
			//SRLI
	end


	if(I_OP[31:25]==7'b0000000&&I_OP[6:0]==7'b0010011&&I_OP[14:12]==3'b001)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=0;
		O_ALUOp=4'b0101;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=1;
		issw=0;
			//SLLI
	end

	if (I_OP[31:25]==7'b0100000&&I_OP[6:0]==7'b0110011&&I_OP[14:12]==3'b000)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b0001;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
		//SUB
	end

	if (I_OP[31:25]==7'b0100000&&I_OP[6:0]==7'b0110011&&I_OP[14:12]==3'b101)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b0111;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
		//SRA
	end
	if (I_OP[31:25]==7'b0100000&&I_OP[6:0]==7'b0010011&&I_OP[14:12]==3'b101)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=0;
		O_ALUOp=4'b0111;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=1;
		issw=0;
		//SRAI
	end
		//TODO R2-type

	if(I_OP[6:0]==7'b0010011&&I_OP[14:12]==3'b000)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=0;
		O_ALUOp=4'b0000;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
		//ADDI
	end
	if(I_OP[6:0]==7'b0010011&&I_OP[14:12]==3'b111)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=0;
		O_ALUOp=4'b0010;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//ANDI
	end
	if(I_OP[6:0]==7'b0010011&&I_OP[14:12]==3'b110)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=0;
		O_ALUOp=4'b0011;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//ORI
	end
	if(I_OP[6:0]==7'b0010011&&I_OP[14:12]==3'b100)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=0;
		O_ALUOp=4'b0110;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//XORI
	end
	if(I_OP[6:0]==7'b0010011&&I_OP[14:12]==3'b010)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=0;
		O_ALUOp=4'b1100;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//SLTI
	end
	if(I_OP[6:0]==7'b0010011&&I_OP[14:12]==3'b011)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=0;
		O_ALUOp=4'b0100;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//SLTIU
	end
	if(I_OP[6:0]==7'b0110111)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=0;
		O_ALUSrc=1;
		O_ALUOp=4'b1101;
		isnot_PC_4=1;
		isJALR=1;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=1;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
		//LUI
	end
	if(I_OP[6:0]==7'b0010111)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=0;
		O_ALUSrc=1;
		O_ALUOp=4'b1000;
		isnot_PC_4=0;
		isJALR=1;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=1;
		isLUIAUI=1;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
		//AUIPC
	end


	if(I_OP[6:0]==7'b0000011&&I_OP[14:12]== 3'b010)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b1111;
		O_MemtoReg=0;
		O_ALUSrc=0;
		O_ALUOp=4'b0000;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//LW
	end
	if(I_OP[6:0]==7'b0000011&&I_OP[14:12]==3'b000)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0001;
		O_MemtoReg=0;
		O_ALUSrc=0;
		O_ALUOp=4'b0000;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//LB
	end
	if(I_OP[6:0]==7'b0000011&&I_OP[14:12]==3'b001)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0011;
		O_MemtoReg=0;
		O_ALUSrc=0;
		O_ALUOp=4'b0000;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//LH
	end


	if(I_OP[6:0]==7'b0000011&&I_OP[14:12]==3'b100)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0001;
		O_MemtoReg=0;
		O_ALUSrc=0;
		O_ALUOp=4'b0000;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//LBU
	end
	if(I_OP[6:0]==7'b0000011&&I_OP[14:12]==3'b101)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0011;
		O_MemtoReg=0;
		O_ALUSrc=0;
		O_ALUOp=4'b0000;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//LHU
	end
	if (I_OP[6:0]==7'b0100011&&I_OP[14:12]==3'b010)begin
		O_RegWrite=0;
		O_MemWrite=1;
		O_MemRead=4'b1111;
		O_MemtoReg=0;
		O_ALUSrc=0;
		O_ALUOp=4'b0101;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=1;
		isSLLISRLISRAI=0;
		issw=1;
			//SW
	end
	if(I_OP[6:0]==7'b0100011&&I_OP[14:12]==3'b001)begin
		O_RegWrite=0;
		O_MemWrite=1;
		O_MemRead=4'b0011;
		O_MemtoReg=1;
		O_ALUSrc=0;
		O_ALUOp=4'b0101;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=1;
		isSLLISRLISRAI=0;
		issw=1;
			//!SH
	end
	if(I_OP[6:0]==7'b0100011&&I_OP[14:12]==3'b000)begin
		O_RegWrite=0;
		O_MemWrite=1;
		O_MemRead=4'b0001;
		O_MemtoReg=1;
		O_ALUSrc=0;
		O_ALUOp=4'b0101;
		isnot_PC_4=0;
		isJALR=0;
		isCout=0;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=1;
		isSLLISRLISRAI=0;
		issw=1;
			//!SB
	end

	if(I_OP[6:0]==7'b1101111)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b1001;
		isnot_PC_4=1;
		isJALR=0;
		isCout=0;
		isJAL=1;
		is_down_se=1;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
		//JAL
	end


	if(I_OP[6:0]==7'b1100111&&I_OP[14:12]==3'b000)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=0;
		O_ALUOp=4'b0000;
		isnot_PC_4=1;
		isJALR=1;
		isCout=0;
		isJAL=1;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
		//JALR
	end

	if(I_OP[6:0]==7'b1100011&&I_OP[14:12]==3'b000)begin
		O_RegWrite=0;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b0000;
		isnot_PC_4=0;
		isJALR=0;
		isCout=1;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//BEQ
	end


	if(I_OP[6:0]==7'b1100011&&I_OP[14:12]==3'b001)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b1110;
		isnot_PC_4=0;
		isJALR=0;
		isCout=1;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//BNE
	end


	if(I_OP[6:0]==7'b1100011&&I_OP[14:12]==3'b100)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b1101;
		isnot_PC_4=0;
		isJALR=0;
		isCout=1;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//BLT
	end


	if(I_OP[6:0]==7'b1100011&&I_OP[14:12]==3'b101)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b1111;
		isnot_PC_4=0;
		isJALR=0;
		isCout=1;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//BGE
	end


	if(I_OP[6:0]==7'b1100011&&I_OP[14:12]==3'b110)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b1111;
		isnot_PC_4=0;
		isJALR=0;
		isCout=1;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//BLTU
	end
	if(I_OP[6:0]==7'b1100011&&I_OP[14:12]==3'b111)begin
		O_RegWrite=1;
		O_MemWrite=0;
		O_MemRead=4'b0;
		O_MemtoReg=1;
		O_ALUSrc=1;
		O_ALUOp=4'b1111;
		isnot_PC_4=0;
		isJALR=0;
		isCout=1;
		isJAL=0;
		is_down_se=0;
		isLUI=0;
		isLUIAUI=0;
		is_sign_ex=0;
		isSLLISRLISRAI=0;
		issw=0;
			//BGEU
	end


end
endmodule //CONTROL