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
	output reg isLUIAUI
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
end

always @(*) begin
	case (I_OP[31:25])
		7'b0000000:begin
		case (I_OP[6:0])
			7'b0110011:begin
				case (I_OP[14:12])
					3'b000:begin
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
						//TODO ADD
					end
					3'b111:begin
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
						//AND
					end
					3'b110:begin
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
						//OR
					end
					3'b100:begin
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
						//XOR
					end
					3'b010:begin
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
						//SLT
					end
					3'b011:begin
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
						//SLTU
					end
					3'b101:begin
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
						//SRL
					end
					3'b001:begin
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
						//SLL
					end
				endcase
			end
			7'b0010011:begin
				case (I_OP[14:12])
					3'b101:begin
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
						//SRLI
					end
					3'b001:begin
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
						//SLLI
					end
				endcase
			end
		endcase
			//TODO R1-type
		end
		7'b0100000:begin
			case (I_OP[6:0])
				7'b0110011:begin
					case (I_OP[14:12])
						3'b000:begin
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
							//SUB
						end
						3'b101:begin
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
							//SRA
						end
					endcase
				end
				7'b0010011:begin
					case (I_OP[14:12])
						3'b101:begin
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
							//SRAI
						end
					endcase
				end
			endcase
			//TODO R2-type
		end
		default begin
			case (I_OP[6:0])
				//7'b0110011:begin
				//	
				//end
				7'b0010011:begin
					case (I_OP[14:12])
						3'b000:begin
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
							//ADDI
						end
						3'b111:begin
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
							//ANDI
						end
						3'b110:begin
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
							//ORI
						end
						3'b100:begin
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
							//XORI
						end
						3'b010:begin
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
							//SLTI
						end
						3'b011:begin
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
							//SLTIU
						end

					endcase
				end
				7'b0110111:begin	
						O_RegWrite=1;
						O_MemWrite=0;
						O_MemRead=4'b0;
						O_MemtoReg=1;
						O_ALUSrc=1;
						O_ALUOp=4'b1101;
						isnot_PC_4=1;
						isJALR=1;
						isCout=0;
						isJAL=0;
						is_down_se=0;
						isLUI=0;
						isLUIAUI=0;
					//LUI
				end
				7'b0010111:begin
						O_RegWrite=1;
						O_MemWrite=0;
						O_MemRead=4'b0;
						O_MemtoReg=1;
						O_ALUSrc=1;
						O_ALUOp=4'b1000;
					//AUIPC
				end
				7'b0000011:begin
					case (I_OP[14:12])
						3'b010:begin
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
							//LW
						end
						3'b000:begin
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
							//LB
						end
						3'b001:begin
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
							//LH
						end
						3'b100:begin
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
							//LBU
						end
						3'b101:begin
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
							//LHU
						end
					endcase
				end
				7'b0100011:begin
					case (I_OP[14:12])
						3'b010:begin
							O_RegWrite=0;
							O_MemWrite=1;
							O_MemRead=4'b1111;
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
							//SW
						end
						3'b001:begin
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
							//!SH
						end
						3'b000:begin
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
							//!SB
						end
					endcase
				end
				7'b1101111:begin
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
					//JAL
				end
				7'b1100111:begin
					case (I_OP[14:12])
						3'b000:begin
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
						//JALR
						end
					endcase
				end
				7'b1100011:begin
					case (I_OP[14:12])
						3'b000:begin
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
							//BEQ
						end
						3'b001:begin
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
							//BNE
						end
						3'b100:begin
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
							//BLT
						end
						3'b101:begin
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
							//BGE
						end
						3'b110:begin
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
							//BLTU
						end
						3'b111:begin
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
							//BGEU
						end
					endcase
				end
			endcase
		end
	endcase
end
endmodule //CONTROL