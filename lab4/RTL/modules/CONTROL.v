module CONTROL (
    input  wire clk,
	input  wire rstn,
	input wire [31:0] I_OP,
	output reg PC_MUX,
    output reg MUX_A，
    output reg [1:0]MUX_B，
	output reg D_MemtoReg,
	output reg RegWrite,
	output reg I_MemRead,
	output reg MemWrite,
	output reg [3:0] ALUOp,
	output reg I_MEM_write,
	output reg is_sign_ex,

endmodule //CONTROL
reg [1:0]state;//IF 00/ ID 01 / EX 10 / WB 11
always @(posedge  rstn) begin
    state=2'b00;
	PC_MUX=0;
    MUX_A=0;
    [1:0]MUX_B=2'b00;
	D_MemtoReg=0;
	RegWrite=0;
	I_MemRead=0;
	MemWrite=0;
	[3:0] ALUOp=3'b0;
	I_MEM_write=0;
	is_sign_ex=0;
end
always @(posedge clk) begin
    if (I_OP[31:25]==7'b0000000&&I_OP[6:0]==7'b0110011&&I_OP[14:12]==3'b111)begin
        case (state)
            2'b 00:begin
                PC_MUX=0;
                MUX_A=0;
                [1:0]MUX_B=2'b00;
	            D_MemtoReg=0;
	            RegWrite=0;
	            I_MemRead=0;
	            MemWrite=0;
	            [3:0] ALUOp=4'b0;
	            I_MEM_write=0;
	            is_sign_ex=0;       
            2'b01:begin
                PC_MUX=0;
                MUX_A=0;
                [1:0]MUX_B=2'b00;
	            D_MemtoReg=0;
	            RegWrite=0;
	            I_MemRead=0;
	            MemWrite=0;
	            [3:0] ALUOp=4'b0;
	            I_MEM_write=0;
	            is_sign_ex=0; 
    end
    state=state+1;
end
end