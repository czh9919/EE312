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
	output reg is_sign_ex
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
end

always @(*) begin
	if(I_OP[31:25]==7'b0000000)
			if (I_OP[6:0]==7'b0110011)
				if (I_OP[14:12]==3'b000)
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
					//TODO ADD
				if(I_OP[14:12]==3'b111)
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
					//AND
				if(I_OP[14:12]==3'b110)
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
					//OR
				if(I_OP[14:12]==3'b100)
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
					//XOR
					
				if(I_OP[14:12]==3'b010)
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
					//SLT

				if(I_OP[14:12]==3'b011)
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
					//SLTU
					
				if(I_OP[14:12]==3'b101)
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
					//SRL
				if(I_OP[14:12]==3'b001)
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
						//SLL
					
				
			
			if(I_OP[6:0]==7'b0010011)
				if (I_OP[14:12]==3'b101)
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
						//SRLI
					
				if(I_OP[14:12]==3'b001)
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
						//SLLI
					
				
			
		
			//TODO R1-type
		
	if(I_OP[31:25]==7'b0100000)
			if (I_OP[6:0]==7'b0110011)	
				if (I_OP[14:12]==3'b000)
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
							//SUB
						
				if (I_OP[14:12]==3'b101)
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
							//SRA
						
					
			
			if (I_OP[6:0]==	7'b0010011)
				if (I_OP[14:12]==3'b101)
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
					//SRAI
						
					
			
			
			//TODO R2-type
		
			if(I_OP[6:0]==7'b0010011)
					if(I_OP[14:12]==3'b000)
						
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
						//ADDI
						
					if(I_OP[14:12]==3'b111)
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
							//ANDI
						
					if(I_OP[14:12]==3'b110)
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
							//ORI
						
					if(I_OP[14:12]==3'b100)
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
							//XORI
						
					if(I_OP[14:12]==3'b010)
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
							//SLTI
						
					if(I_OP[14:12]==3'b011)
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
							//SLTIU
						

					
				
				if(I_OP[6:0]==7'b0110111)
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
					//LUI
				
				if(I_OP[6:0]==7'b0010111)
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
					//AUIPC
				
				if(I_OP[6:0]==7'b0000011)
					if(I_OP[14:12]== 3'b010)
						
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
							//LW
						
					if(I_OP[14:12]==3'b000)
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
							//LB
						
					if(I_OP[14:12]==3'b001)
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
							//LH
						
					if(I_OP[14:12]==3'b100)
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
							//LBU
						
					if(I_OP[14:12]==3'b101)
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
							//LHU
						
					
				
				if(I_OP[6:0]==7'b0100011)
					if (I_OP[14:12]==3'b010)
						
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
							//SW
						
					if(I_OP[14:12]==3'b001)
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
							//!SH
						
					if(I_OP[14:12]==3'b000)
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
							//!SB
						
					
			
				if(I_OP[6:0]==7'b1101111)
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
					//JAL
				
				if(I_OP[6:0]==7'b1100111)
					if(I_OP[14:12]==3'b000)
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
						//JALR
						
					
				
				if(I_OP[6:0]==7'b1100011)
					if(I_OP[14:12]==3'b000)
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
							//BEQ
						
					if(I_OP[14:12]==3'b001)
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
							//BNE
						
					if(I_OP[14:12]==3'b100)
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
							//BLT
						
					if(I_OP[14:12]==3'b101)
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
							//BGE
						
					if(I_OP[14:12]==3'b110)
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
							//BLTU
						
					if(I_OP[14:12]==3'b111)
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
							//BGEU
					
				
		
		
end	
endmodule //CONTROL