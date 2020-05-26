module CONTROL (
	input  wire clk,
    input  wire rstn,
    input wire [31:0] I_OP,
    output reg PC_source,//MUX for pc
    output reg [1:0]MUX_SEXT,//mux for sign extend
    output reg RegWrite,//Register
    output reg MemWrite,//data
    output reg [3:0] ALUOp,
    output reg Reg_MUX,//RegDst
    output reg MUX_ALU,
    output reg beq_con
);

always @(posedge rstn) begin
    PC_source=0;
    MUX_SEXT=2'b00;
    RegWrite=0;
    MemWrite=0;
    ALUOp=4'b0000;
    Reg_MUX=0;
    MUX_ALU=0;
    beq_con=0;
end

always @(*) begin

	if(I_OP[31:25]==7'b0000000&&I_OP[6:0]==7'b0110011)begin
        PC_source=0;
        MUX_SEXT=2'b00;
        RegWrite=1;
        MemWrite=1;
        Reg_MUX=1;
        MUX_ALU=0;
        beq_con=0;
		if(I_OP[14:12]==3'b111)begin//AND
            ALUOp=4'b0010;
        end
        if(I_OP[14:12]==3'b110)begin//OR
            ALUOp=4'b0011;
        end
        if(I_OP[14:12]==3'b100)begin//XOR
            ALUOp=4'b1101;
        end
        if(I_OP[14:12]==3'b010)begin//SLT
            ALUOp=4'b0111;
        end
        if(I_OP[14:12]==3'b011)begin//SLTU
            ALUOp=4'b1001;
        end
        if(I_OP[14:12]==3'b101)begin//SRL
            ALUOp=4'b0101;
        end
        if(I_OP[14:12]==3'b001)begin//SLL
            ALUOp=4'b0100;
        end
        if(I_OP[14:12]==3'b000)begin//ADD
            ALUOp=4'b0000;
        end
	end

	
    if(I_OP[31:25]==7'b0000000&&I_OP[6:0]==7'b0010011&&(I_OP[14:12]==3'b101||I_OP[14:12]==3'b001))begin
        PC_source=0;
        MUX_SEXT=2'b00;
        RegWrite=1;
        MemWrite=1;
        Reg_MUX=1;
        MUX_ALU=0;
        beq_con=0;
        if(I_OP[14:12]==3'b101)begin//SRLI
            ALUOp=4'b0101;
        end
        if(I_OP[14:12]==3'b001)begin//SLLI
            ALUOp=4'b0100;
        end

	if (I_OP[31:25]==7'b0100000&&I_OP[6:0]==7'b0110011&&I_OP[14:12]==3'b101)begin
		PC_source=0;
        MUX_SEXT=2'b00;
        RegWrite=1;
        MemWrite=1;
        ALUOp=4'b0000;
        Reg_MUX=1;
        MUX_ALU=0;
        beq_con=0;
		//SRA
	end
    if (I_OP[31:25]==7'b0100000&&I_OP[6:0]==7'b0110011)begin//sub
        PC_source=0;
        MUX_SEXT=2'b00;
        RegWrite=1;
        MemWrite=1;
        Reg_MUX=1;
        MUX_ALU=0;
        beq_con=0;
        if(I_OP[14:12]==3'b000)begin//SUB
            ALUOp=4'b0001;
        end
        if(I_OP[14:12]==3'b101)begin//SRA
            ALUOp=4'b0110;
        end
    end
	if (I_OP[31:25]==7'b0100000&&I_OP[6:0]==7'b0010011&&I_OP[14:12]==3'b101)begin
		PC_source=0;
        MUX_SEXT=2'b00;
        RegWrite=1;
        MemWrite=1;
        ALUOp=4'b0000;
        Reg_MUX=1;
        MUX_ALU=0;
        beq_con=0;
		//SRAI
	end
		

	if (I_OP[6:0]==7'b0010011)begin//ANDI
        PC_source=0;
        MUX_SEXT=2'b01;
        RegWrite=1;
        MemWrite=1;
        Reg_MUX=1;
        MUX_ALU=1;
        beq_con=0;
        if(I_OP[14:12]==3'b111)begin//ANDI
            ALUOp=4'b0010;
        end
        if(I_OP[14:12]==3'b110)begin//ORI
            ALUOp=4'b0011;
        end
        if(I_OP[14:12]==3'b100)begin//XORI
            ALUOp=4'b0011;
        end
        if(I_OP[14:12]==3'b010)begin//SLTI
            ALUOp=4'b0111;
        end
        if(I_OP[14:12]==3'b011)begin//SLTIU
            ALUOp=4'b1001;
        end
        if(I_OP[14:12]==3'b000)begin//ADDI
            ALUOp=4'b0000;
        end
    end
	if(I_OP[6:0]==7'b0000011&&I_OP[14:12]== 3'b010)begin
		PC_source=0;
        MUX_SEXT=2'b01;
        RegWrite=0;
        MemWrite=0;
        ALUOp=4'b0000;
        Reg_MUX=0;
        MUX_ALU=1;
        beq_con=0;
			//LW
	end
	if (I_OP[6:0]==7'b0100011&&I_OP[14:12]==3'b010)begin
		PC_source=0;
        MUX_SEXT=2'b00;
        RegWrite=1;
        MemWrite=1;
        ALUOp=4'b0000;
        Reg_MUX=1;
        MUX_ALU=1;
        beq_con=0;
			//SW
	end
	
	if(I_OP[6:0]==7'b1101111)begin
		PC_source=1;
        MUX_SEXT=2'b10;
        RegWrite=0;
        MemWrite=0;
        ALUOp=4'b0000;
        Reg_MUX=0;
        MUX_ALU=1;
        beq_con=0;
		//JAL
	end


	if(I_OP[6:0]==7'b1100111&&I_OP[14:12]==3'b000)begin
		PC_source=0;
        MUX_SEXT=2'b01;
        RegWrite=0;
        MemWrite=0;
        ALUOp=4'b0000;
        Reg_MUX=1;
        MUX_ALU=1;
        beq_con=0;
		//JALR
	end

	if (I_OP[6:0]==7'b1100011)begin//BEQ
        PC_source=1;
        MUX_SEXT=2'b00;
        RegWrite=0;
        MemWrite=0;
        Reg_MUX=1;
        MUX_ALU=1;
        beq_con=1;
        if(I_OP[14:12]==3'b000)begin//BEQ
            ALUOp=4'b1100;
        end
        if(I_OP[14:12]==3'b001)begin//BNE
            ALUOp=4'b1011;
        end
        if(I_OP[14:12]==3'b100)begin//BLT
            ALUOp=4'b0111;
        end
        if(I_OP[14:12]==3'b101)begin//BGE
            ALUOp=4'b1000;
        end
        if(I_OP[14:12]==3'b110)begin//BLTU
            ALUOp=4'b1001;
        end
        if(I_OP[14:12]==3'b111)begin//BGEU
            ALUOp=4'b1010;
        end
    end
endmodule //CONTROL