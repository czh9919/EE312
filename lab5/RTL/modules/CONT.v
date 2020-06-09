module CONT (
    input  wire clk,
    input  wire rstn,
    input  wire [31:0] I_OP,
    output reg [3:0] ALUOp
);

always @(posedge rstn) begin
    ALUOp=4'b0;
end
always @(*) begin
    ALUOp=4'b0;
    if(I_OP[6:0]==7'b1100111&&I_OP[14:12]==3'b000)begin
        ALUOp=4'b1110;
    end
end
	
endmodule //CONT