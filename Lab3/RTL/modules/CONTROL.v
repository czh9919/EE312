module CONTROL (
	input wire [31:0] I_OP,
	output wire O_RegDst,
	output wire O_ALUSrc,
	output wire O_MemtoReg,
	output wire O_RegWrite,
	output wire O_MemRead,
	output wire O_MemWrite,
	//output wire O_Branch,
	output wire O_ALUOp,
	output wire isnot_PC_4,
	output wire back_PC_CON,
	output wire isJALR,
	output wire isCout
	//output wire O_ALUOp2
);
always @(*) begin
	case (I_CON)

always @(*) begin
	case (I_OP[31:25])
		7'b0000000:begin
		case (I_OP[6:0])
			7'b0110011:begin
				case (I_OP[14:12])
					3'b000:begin
						O_RegWrite=1;
						O_MemWrite=0;
						O_MemRead=0;
						O_MemtoReg=1;
						O_ALUSrc=1;
						O_ALUOp=4'b0000;
						//TODO ADD
					end
					3'b111:begin
						O_RegWrite=1;
						O_MemWrite=0;
						O_MemRead=0;
						O_MemtoReg=1;
						O_ALUSrc=1;
						O_ALUOp=4'b0010;
						//AND
					end
					3'b110:begin
						O_RegWrite=1;
						O_MemWrite=0;
						O_MemRead=0;
						O_MemtoReg=1;
						O_ALUSrc=1;
						O_ALUOp=4'b0011;
						//OR
					end
					3'b100:begin
						O_RegWrite=1;
						O_MemWrite=0;
						O_MemRead=0;
						O_MemtoReg=1;
						O_ALUSrc=1;
						O_ALUOp=4'b0110;
						//XOR
					end
					3'b010:begin
						O_RegWrite=1;
						O_MemWrite=0;
						O_MemRead=0;
						O_MemtoReg=1;
						O_ALUSrc=1;
						O_ALUOp=4'b0100;
						//SLT
					end
					3'b011:begin
						O_RegWrite=1;
						O_MemWrite=0;
						O_MemRead=0;
						O_MemtoReg=1;
						O_ALUSrc=1;
						O_ALUOp=4'b0100;
						//SLTU
					end
					3'b101:begin
						O_RegWrite=1;
						O_MemWrite=0;
						O_MemRead=0;
						O_MemtoReg=1;
						O_ALUSrc=1;
						O_ALUOp=4'b1010;
						//SRL
					end
					3'b001:begin
						O_RegWrite=1;
						O_MemWrite=0;
						O_MemRead=0;
						O_MemtoReg=1;
						O_ALUSrc=1;
						O_ALUOp=4'b0101;
						//SLL
					end
				endcase
			end
			7'b0010011:begin
				case (I_OP[14:12])
					3'b101:begin
						O_RegWrite=1;
						O_MemWrite=0;
						O_MemRead=0;
						O_MemtoReg=1;
						O_ALUSrc=1;
						O_ALUOp=4'b1010;
						//SRLI
					end
					3'b001:begin
						O_RegWrite=1;
						O_MemWrite=0;
						O_MemRead=0;
						O_MemtoReg=1;
						O_ALUSrc=1;
						O_ALUOp=4'b0101;
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
							O_MemRead=0;
							O_MemtoReg=1;
							O_ALUSrc=1;
							O_ALUOp=4'b0001;
							//SUB
						end
						3'b101:begin
							O_RegWrite=1;
							O_MemWrite=0;
							O_MemRead=0;
							O_MemtoReg=1;
							O_ALUSrc=1;
							O_ALUOp=4'b0111;
							//SRA
						end
					endcase
				end
				7'b0010011:begin
					case (I_OP[14:12])
						3'b101:begin
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
							O_MemRead=0;
							O_MemtoReg=1;
							O_ALUSrc=0;
							O_ALUOp=4'b0000;
							//ADDI
						end
						3'b111:begin
							O_RegWrite=1;
							O_MemWrite=0;
							O_MemRead=0;
							O_MemtoReg=1;
							O_ALUSrc=0;
							O_ALUOp=4'b0010;
							//ANDI
						end
						3'b110:begin
							O_RegWrite=1;
							O_MemWrite=0;
							O_MemRead=0;
							O_MemtoReg=1;
							O_ALUSrc=0;
							O_ALUOp=4'b0011;
							//ORI
						end
						3'b100:begin
							O_RegWrite=1;
							O_MemWrite=0;
							O_MemRead=0;
							O_MemtoReg=1;
							O_ALUSrc=0;
							O_ALUOp=4'b0110;
							//XORI
						end
						3'b010:begin
							O_RegWrite=1;
							O_MemWrite=0;
							O_MemRead=0;
							O_MemtoReg=1;
							O_ALUSrc=0;
							O_ALUOp=4'b0100;
							//SLTI
						end
						3'b011:begin
							O_RegWrite=1;
							O_MemWrite=0;
							O_MemRead=0;
							O_MemtoReg=1;
							O_ALUSrc=0;
							O_ALUOp=4'b0100;
							//SLTIU
						end

					endcase
				end
				7'b0110111:begin	
						O_RegWrite=1;
						O_MemWrite=0;
						O_MemRead=0;
						O_MemtoReg=1;
						O_ALUSrc=1;
						O_ALUOp=4'1101;
					//LUI
				end
				7'b0010111:begin
						O_RegWrite=1;
						O_MemWrite=0;
						O_MemRead=0;
						O_MemtoReg=1;
						O_ALUSrc=1;
						O_ALUOp=4'1000;
					//AUIPC
				end
				7'b0000011:begin
					case (I_OP[14:12])
						3'b010:begin
							O_RegWrite=1;
							O_MemWrite=0;
							O_MemRead=0;
							O_MemtoReg=1;
							O_ALUSrc=1;
							O_ALUOp=4'b;
							//LW
						end
					endcase
				end
				7'b0100011:begin
					case (I_OP[14:12])
						3'b010:begin
							O_RegWrite=1;
							O_MemWrite=0;
							O_MemRead=0;
							O_MemtoReg=1;
							O_ALUSrc=1;
							O_ALUOp=4'b0101;
							//SW
						end
					endcase
				end
				7'b1101111:begin
						O_RegWrite=1;
						O_MemWrite=0;
						O_MemRead=0;
						O_MemtoReg=1;
						O_ALUSrc=1;
						O_ALUOp=4'b1001;
					//JAL
				end
				7'b1100111:begin
					case (I_OP[14:12])
						3'b000:begin
						O_RegWrite=1;
						O_MemWrite=0;
						O_MemRead=0;
						O_MemtoReg=1;
						O_ALUSrc=1;
						O_ALUOp=4'b1011;
							//JALR
						end
					endcase
				end
				7'b1100011:begin
					case (I_OP[14:12])
						3'b000:begin
							O_RegWrite=1;
							O_MemWrite=0;
							O_MemRead=0;
							O_MemtoReg=1;
							O_ALUSrc=1;
							O_ALUOp=4'b1110;
							//BEQ
						end
						3'b001:begin
							O_RegWrite=1;
							O_MemWrite=0;
							O_MemRead=0;
							O_MemtoReg=1;
							O_ALUSrc=1;
							O_ALUOp=4'b1110;
							//BNE
						end
						3'b100:begin
							O_RegWrite=1;
							O_MemWrite=0;
							O_MemRead=0;
							O_MemtoReg=1;
							O_ALUSrc=1;
							O_ALUOp=4'b1111;
							//BLT
						end
						3'b101:begin
							O_RegWrite=1;
							O_MemWrite=0;
							O_MemRead=0;
							O_MemtoReg=1;
							O_ALUSrc=1;
							O_ALUOp=4'b1111;
							//BGE
						end
						3'b110:begin
							O_RegWrite=1;
							O_MemWrite=0;
							O_MemRead=0;
							O_MemtoReg=1;
							O_ALUSrc=1;
							O_ALUOp=4'b1111;
							//BLTU
						end
						3'b111:begin
							O_RegWrite=1;
							O_MemWrite=0;
							O_MemRead=0;
							O_MemtoReg=1;
							O_ALUSrc=1;
							O_ALUOp=4'b1111;
							//BGEU
						end
					endcase
				end
			endcase
		end
	endcase
end
endmodule //CONTROL