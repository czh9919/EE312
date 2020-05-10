module CONTROL (
    input  wire clk,
    input  wire rstn,
    input wire [31:0] I,
    output reg PC_source,//PCsource
    output reg MUX_A,//CON_A
    output reg [1:0]MUX_B,//CON_B
    output reg RegWrite,//Register
    output reg MemWrite,//data
    output reg [3:0] ALUOp,
    output reg I_MEM_write,//instrution
    output reg [1:0] sign_ex,//CON_sign
    output reg Reg_MUX,//RegDst
    output reg [31:0] NUM_INS
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
end
always @(*) begin 
    if(state==2'b 01)begin//我感觉01的时候所有的指令都是一样的。。。
        temp_I=I;
        PC_source=1;//PC+4
        MUX_A=0;
        MUX_B=2'b10;
        RegWrite=0;
        MemWrite=0;
        Reg_MUX=1;
        ALUOp=4'b0000;
        I_MEM_write=1;
        sign_ex=0;
    end
    if (state==2'b10)begin
        if (temp_I[31:25]==7'b0000000&&temp_I[6:0]==7'b0110011)begin//AND 
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=1;
            MemWrite=0;
            Reg_MUX=1;
            I_MEM_write=0;
            sign_ex=2'b00;
        end
        if (temp_I[31:25]==7'b0100000&&temp_I[6:0]==7'b0110011)begin//sub
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=1;
            MemWrite=0;
            Reg_MUX=1;
            I_MEM_write=0;
            sign_ex=2'b00;
        end
        if (temp_I[6:0]==7'b0010011)begin//ANDI
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=1;
            MemWrite=0;
            Reg_MUX=1;
            I_MEM_write=0;
            sign_ex=2'b00;
        end
        if (temp_I[31:25]==7'b0100000&&temp_I[6:0]==7'b0010011)begin//SRI...
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=1;
            MemWrite=0;
            Reg_MUX=1;
            I_MEM_write=0;
            sign_ex=2'b01;
        end
        if (temp_I[31:25]==7'b0000000&&temp_I[6:0]==7'b0010011&&(temp_I[14:12]==3'b101||temp_I[14:12]==3'b001))begin//SRLI  SLLI
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=1;
            MemWrite=0;
            Reg_MUX=1;
            I_MEM_write=0;
            sign_ex=2'b01;
        end
        //BEQ.........
        //_________________________________//
        if (temp_I[6:0]==7'b0000011&&temp_I[14:12]==3'b010)begin//LW
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=1;
            MemWrite=0;
            Reg_MUX=1;
            I_MEM_write=0;
            sign_ex=2'b00;
        end
        if (temp_I[6:0]==7'b0100011&&temp_I[14:12]==3'b010)begin//SW
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=1;
            MemWrite=0;
            Reg_MUX=1;
            I_MEM_write=0;
            sign_ex=2'b00;
        end 




    end

    if(state==2'b 11)begin
        if (temp_I[31:25]==7'b0000000&&temp_I[6:0]==7'b0110011)begin
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=1;
            if(temp_I[14:12]==3'b111)begin//ADD
                ALUOp=4'b0000;
            end
            if(temp_I[14:12]==3'b000)begin//AND
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
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=1;
            if(temp_I[14:12]==3'b000)begin//SUB
                ALUOp=4'b0001;
            end
            if(temp_I[14:12]==3'b101)begin//SRA
                ALUOp=4'b0110;
            end
            I_MEM_write=1;
            sign_ex=2'b00;
        end
        //___________________________________________________________________//
        if (temp_I[6:0]==7'b0010011)begin//ANDI
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=1;
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
            I_MEM_write=1;
            sign_ex=2'b00;
        end
        //_________________________________________________________//
        if (temp_I[31:25]==7'b0100000&&temp_I[6:0]==7'b0010011)begin
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=1;
            if(temp_I[14:12]==3'b101)begin//SRAI
                ALUOp=4'b0110;
            end
            I_MEM_write=1;
            sign_ex=2'b00;
        end
        //_________________________________________________________________//
        if (temp_I[31:25]==7'b0000000&&temp_I[6:0]==7'b0010011&&(temp_I[14:12]==3'b101||temp_I[14:12]==3'b001))begin
            PC_source=0;
            MUX_A=0;
            MUX_B=2'b10;
            RegWrite=0;
            MemWrite=0;
            Reg_MUX=1;
            if(temp_I[14:12]==3'b101)begin//SRLI
                ALUOp=4'b0101;
            end
            if(temp_I[14:12]==3'b001)begin//SLLI
                ALUOp=4'b0100;
            end
            I_MEM_write=1;
            sign_ex=2'b00;
        end
        //______________










        //BEQ................
        //___________________
        if (temp_I[6:0]==7'b0000011&&temp_I[14:12]==3'b010)begin//LW
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=1;
            MemWrite=0;
            Reg_MUX=1;
            I_MEM_write=0;
            sign_ex=2'b00;
        end
        if (temp_I[6:0]==7'b0100011&&temp_I[14:12]==3'b010)begin//SW
            PC_source=0;
            MUX_A=1;
            MUX_B=2'b01;
            RegWrite=1;
            MemWrite=0;
            Reg_MUX=1;
            I_MEM_write=1;
            sign_ex=2'b00;
        end 
    end

    if(state==2'b 00)begin
        PC_source=0;//pc+4
        MUX_A=1;
        MUX_B=2'b00;
        RegWrite=1;
        MemWrite=1;
        Reg_MUX=1;
        I_MEM_write=1;
        sign_ex=0;
    end
end
always @(posedge clk) begin
    state=state+1;
    NUM_INS=NUM_INS+1;
end
endmodule //CONTROL