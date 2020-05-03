module CONTROL (
    input  wire clk,
	input  wire rstn,
	input wire [31:0] I_OP,
	output reg PC_source,//PCsource
    output reg MUX_A，//CON_A
    output reg [1:0]MUX_B，//CON_B
	output reg MemtoReg,
	output reg RegWrite,//Register
	output reg I_Mem_Read,
	output reg MemWrite,//data
	output reg [3:0] ALUOp,
	output reg I_MEM_write,//instrution
	output reg [1:0] sign_ex,//CON_sign
	output reg Reg_MUX,//RegDst
);
endmodule //CONTROL
reg [1:0]state;//IF 00/ ID 01 / EX 10 / WB 11
always @(posedge  rstn) begin
    state=2'b00;
	PCsource=0;
    MUX_A=0;
    [1:0]MUX_B=2'b00;
	MemtoReg=0;
	RegWrite=0;
	I_Mem_Read=0;
	MemWrite=0;
	[3:0] ALUOp=3'b0;
	I_MEM_write=0;
	sign_ex=0;
end
always @(posedge clk) begin
    if (I_OP[31:25]==7'b0000000&&I_OP[6:0]==7'b0110011&&I_OP[14:12]==3'b111)begin
        case (state)
            2'b 00:begin
                PC_source=0;//PC+4
                MUX_A=0;
                MUX_B=2'b10;
	            MemtoReg=0;
	            RegWrite=0;
	            I_Mem_Read=1;
	            MemWrite=0;
				Reg_MUX=1;
	            ALUOp=4'b0000;
	            I_MEM_write=1;
	            sign_ex=0;

            end       //ADD
            2'b01:begin
                PC_source=0;
                MUX_A=1;
                MUX_B=2'b00;
	            MemtoReg=0;
	            RegWrite=1;
	            I_Mem_Read=0;
	            MemWrite=0;
				Reg_MUX=1;
	            ALUOp=4'b0000;
	            I_MEM_write=0;
	            sign_ex=0; 
            end
			2'b10:begin
                PC_source=0;
                MUX_A=1;
                MUX_B=2'b00;
	            MemtoReg=0;
	            RegWrite=0;
	            I_Mem_Read=0;
	            MemWrite=0;
				Reg_MUX=1;
	            ALUOp=4'b0000;
	            I_MEM_write=0;
	            sign_ex=0; 
            end
			2'b11:begin
                PC_source=0;//pc+4
                MUX_A=1;
                MUX_B=2'b00;
	            MemtoReg=1;
	            RegWrite=0;
	            I_Mem_Read=0;
	            MemWrite=0;
				Reg_MUX=1;
	            ALUOp=4'b0000;
	            I_MEM_write=0;
	            sign_ex=0;
			end 
        end
		state=state+1;
    end
   
end
end