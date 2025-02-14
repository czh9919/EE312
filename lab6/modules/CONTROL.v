module CONTROL (
    input  wire clk,
    input  wire rstn,
    input wire [31:0] I,
    input  wire stall,
    output reg PC_source,//PCsource
    output reg MUX_A,//CON_A
    output reg [1:0]MUX_B,//CON_B
    output reg RegWrite,//Register
    output reg MemWrite,//data
    output reg [3:0] ALUOp,
    output reg I_MEM_write,//instrution
    output reg [1:0] sign_ex,//CON_sign
    output reg [1:0] Reg_MUX,//RegDst
    output reg [31:0] NUM_INS,
    output reg [31:0]o,
    output reg is_BEQ
);
reg [31:0] temp_I;
reg [1:0] state;//IF 00/ ID 01 / EX 10 / WB 11
//reg [31:0] temp_I;

always @(posedge rstn) begin
    state=2'b00;
    PC_source=0;
    MUX_A=0;
    MUX_B=2'b00;
    RegWrite=0;
    MemWrite=0;
    ALUOp=4'b0;
    I_MEM_write=0;
    sign_ex=0;
    NUM_INS=0;
    is_BEQ=0;
    Reg_MUX=2'b00;
end
always @(*) begin
    o=temp_I;
end

always @(*) begin 
    if(state==2'b 01)begin//我感觉01的时候所有的指令都是一样的。。。
        temp_I=I;
        PC_source=0;//PC+4
        MUX_A=0;
        MUX_B=2'b10;
        RegWrite=0;
        MemWrite=0;
        Reg_MUX=2'b01;
        ALUOp=4'b0000;
        I_MEM_write=1;
        if (temp_I[6:0]==7'b1101111)begin
            I_MEM_write=0;
        end
        sign_ex=0;
        is_BEQ=0;
    end
    if (state==2'b10)begin
        is_BEQ=0;
        if (temp_I[31:25]==7'b0000000&&temp_I[6:0]==7'b0110011)begin//AND 
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b00;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b01;
            I_MEM_write=0;
            sign_ex=2'b00;
        end
        if (temp_I[31:25]==7'b0100000&&temp_I[6:0]==7'b0110011)begin//sub
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b00;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b01;
            I_MEM_write=0;
            sign_ex=2'b00;
        end
        if (temp_I[6:0]==7'b0010011)begin//ANDI
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b01;
            I_MEM_write=0;
            sign_ex=2'b00;
        end
        if (temp_I[31:25]==7'b0100000&&temp_I[6:0]==7'b0010011)begin//SRI...
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b01;
            I_MEM_write=0;
            sign_ex=2'b01;
        end
        if (temp_I[31:25]==7'b0000000&&temp_I[6:0]==7'b0010011&&(temp_I[14:12]==3'b101||temp_I[14:12]==3'b001))begin//SRLI  SLLI
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b01;
            I_MEM_write=0;
            sign_ex=2'b10;
        end
        //BEQ.........
        if (temp_I[6:0]==7'b1100011)begin//BEQ
            PC_source=0;
            MUX_A=0;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b01;
            is_BEQ=0;
            I_MEM_write=0;
            sign_ex=2'b01;
            ALUOp=4'b1111;
        end

        
        //_________________________________//
        if (temp_I[6:0]==7'b0000011&&temp_I[14:12]==3'b010)begin//LW
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b00;
            I_MEM_write=0;
            sign_ex=2'b00;
        end
        if (temp_I[6:0]==7'b0100011&&temp_I[14:12]==3'b010)begin//SW
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b01;
            I_MEM_write=0;
            sign_ex=2'b01;
        end 
        if (temp_I[6:0]==7'b1101111)begin //jal
            PC_source=1;
            MUX_A=0;
            MUX_B=2'b01;
            RegWrite=1;
            MemWrite=0;
            Reg_MUX=2'b01;
            I_MEM_write=0;
            sign_ex=2'b00;
        end
        if (temp_I[6:0]==7'b1101111&&temp_I[14:12]==3'b000)begin //jalr
            PC_source=1;
            MUX_A=0;
            MUX_B=2'b01;
            RegWrite=1;
            MemWrite=0;
            Reg_MUX=2'b01;
            I_MEM_write=0;
            sign_ex=2'b00;
        end


    end

    if(state==2'b 11)begin
    is_BEQ=0;
        if (temp_I[31:25]==7'b0000000&&temp_I[6:0]==7'b0110011)begin
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b00;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b01;
            if(temp_I[14:12]==3'b000)begin//ADD
                ALUOp=4'b0000;
            end
            if(temp_I[14:12]==3'b111)begin//AND
                ALUOp=4'b0010;
            end
            if(temp_I[14:12]==3'b110)begin//or
                ALUOp=4'b0011;
            end
            if(temp_I[14:12]==3'b100)begin//XOR
                ALUOp=4'b1101;
            end
            if(temp_I[14:12]==3'b010)begin//SLT
                ALUOp=4'b0111;
            end
            if(temp_I[14:12]==3'b011)begin//SLTU
                ALUOp=4'b1001;
            end
            if(temp_I[14:12]==3'b101)begin//SRL
                ALUOp=4'b0101;
            end
            if(temp_I[14:12]==3'b001)begin//SLL
                ALUOp=4'b0100;
            end
            I_MEM_write=0;
            sign_ex=2'b00;
        end
        //_________________________________________________________________//
        if (temp_I[31:25]==7'b0100000&&temp_I[6:0]==7'b0110011)begin//sub
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b00;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b01;
            if(temp_I[14:12]==3'b000)begin//SUB
                ALUOp=4'b0001;
            end
            if(temp_I[14:12]==3'b101)begin//SRA
                ALUOp=4'b0110;
            end
            I_MEM_write=0;
            sign_ex=2'b00;
        end
        //___________________________________________________________________//
        if (temp_I[6:0]==7'b0010011)begin//ANDI
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b01;
            if(temp_I[14:12]==3'b111)begin//ANDI
                ALUOp=4'b0010;
            end
            if(temp_I[14:12]==3'b110)begin//ORI
                ALUOp=4'b0011;
            end
            if(temp_I[14:12]==3'b100)begin//XORI
                ALUOp=4'b0011;
            end
            if(temp_I[14:12]==3'b010)begin//SLTI
                ALUOp=4'b0111;
            end
            if(temp_I[14:12]==3'b011)begin//SLTIU
                ALUOp=4'b1001;
            end
            if(temp_I[14:12]==3'b000)begin//ADDI
                ALUOp=4'b0000;
            end
            I_MEM_write=0;
            sign_ex=2'b00;
        end
        //_________________________________________________________//
        if (temp_I[31:25]==7'b0100000&&temp_I[6:0]==7'b0010011)begin
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b01;
            if(temp_I[14:12]==3'b101)begin//SRAI
                ALUOp=4'b0110;
            end
            I_MEM_write=0;
            sign_ex=2'b00;
        end
        //_________________________________________________________________//
        if (temp_I[31:25]==7'b0000000&&temp_I[6:0]==7'b0010011&&(temp_I[14:12]==3'b101||temp_I[14:12]==3'b001))begin
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b01;
            if(temp_I[14:12]==3'b101)begin//SRLI
                ALUOp=4'b0101;
            end
            if(temp_I[14:12]==3'b001)begin//SLLI
                ALUOp=4'b0100;
            end
            I_MEM_write=0;
            sign_ex=2'b10;
        end
        //______________
        if (temp_I[6:0]==7'b1100011)begin//BEQ
            PC_source=1;
            MUX_A=1;
            MUX_B=2'b00;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b01;
            is_BEQ=1;
            if(temp_I[14:12]==3'b000)begin//BEQ
                ALUOp=4'b1100;
            end
            if(temp_I[14:12]==3'b001)begin//BNE
                ALUOp=4'b1011;
            end
            if(temp_I[14:12]==3'b100)begin//BLT
                ALUOp=4'b0111;
            end
            if(temp_I[14:12]==3'b101)begin//BGE
                ALUOp=4'b1000;
            end
            if(temp_I[14:12]==3'b110)begin//BLTU
                ALUOp=4'b1001;
            end
            if(temp_I[14:12]==3'b111)begin//BGEU
                ALUOp=4'b1010;
            end
            I_MEM_write=1;
            sign_ex=2'b00;
        end






        //BEQ................
        //___________________
        if (temp_I[6:0]==7'b0000011&&temp_I[14:12]==3'b010)begin//LW
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b00;
            I_MEM_write=0;
            sign_ex=2'b00;
        end
        if (temp_I[6:0]==7'b0100011&&temp_I[14:12]==3'b010)begin//SW
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b01;
            I_MEM_write=0;
            sign_ex=2'b01;
        end
        if (temp_I[6:0]==7'b1101111)begin //jal
            PC_source=1;
            MUX_A=0;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b01;
            I_MEM_write=1;
            sign_ex=2'b00;
            ALUOp=4'b0000;
        end
        if (temp_I[6:0]==7'b1101111&&temp_I[14:12]==3'b010)begin //jalr
            PC_source=0;
            MUX_A=0;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b01;
            I_MEM_write=1;
            ALUOp=4'b1110;
            sign_ex=2'b00;
        end
    end

    if(state==2'b 00)begin
        is_BEQ=0;
        if (temp_I[6:0]==7'b0000011&&temp_I[14:12]==3'b010)begin//LW
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=1;
            MemWrite=0;
            Reg_MUX=2'b01;
            I_MEM_write=0;
            sign_ex=2'b00;
        end
        else if (temp_I[6:0]==7'b0100011&&temp_I[14:12]==3'b010)begin//SW
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=1;
            Reg_MUX=2'b00;
            I_MEM_write=0;
            sign_ex=2'b01;
        end
        else if (temp_I[6:0]==7'b1101111)begin //jal
            PC_source=0;//pc+4
            MUX_A=1;
            MUX_B=2'b00;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=2'b10;
            I_MEM_write=0;
            sign_ex=0;
        end
        else begin
            PC_source=0;//pc+4
            MUX_A=1;
            MUX_B=2'b00;
            RegWrite=1;
            MemWrite=0;
            Reg_MUX=0;
            I_MEM_write=0;
            sign_ex=0;
        end
    end
end

always @(posedge clk) begin
    state=state+1;
    NUM_INS=NUM_INS+1;
end
always @(posedge clk) begin
    if (stall) begin
        state=state-1;
        NUM_INS=NUM_INS-1;
    end
    
end
endmodule //CONTROL