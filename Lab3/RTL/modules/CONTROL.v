module CONTROL (
	input wire [31:0] I_OP,
	output wire O_RegDst,
	output wire O_ALUSrc,
	output wire O_MemtoReg,
	output wire O_RegWrite,
	output wire O_MemRead,
	output wire O_MemWrite,
	//output wire O_Branch,
	output wire O_ALUOp
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
						//SLT
					end
					3'b011:begin
						//SLTU
					end
					3'b101:begin
						//SRL
					end
					3'b001:begin
						//SLL
					end
				endcase
			end
			7'b0010011:begin
				case (I_OP[14:12])
					3'b101:begin
						//SRLI
					end
					3'b001:begin
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
							//SUB
						end
						3'b101:begin
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
							//XORI
						end
						3'b010:begin
							//SLTI
						end
						3'b011:begin
							//SLTIU
						end

					endcase
				end
				7'b0110111:begin
					//LUI
				end
				7'b0010111:begin
					//AUIPC
				end
				7'b0000011:begin
					case (I_OP[14:12])
						3'b010:begin
							//LW
						end
					endcase
				end
				7'b0100011:begin
					case (I_OP[14:12])
						3'b010:begin
							//SW
						end
					endcase
				end
				7'b1101111:begin
					//JAL
				end
				7'b1100111:begin
					case (I_OP[14:12])
						3'b000:begin
							//JALR
						end
					endcase
				end
				7'b1100011:begin
					case (I_OP[14:12])
						3'b000:begin
							//BEQ
						end
						3'b001:begin
							//BNE
						end
						3'b100:begin
							//BLT
						end
						3'b101:begin
							//BGE
						end
						3'b110:begin
							//BLTU
						end
						3'b111:begin
							//BGEU
						end
					endcase
				end
			endcase
		end
	endcase
end
endmodule //CONTROL