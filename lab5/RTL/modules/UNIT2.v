module UNIT (
    input  wire clk,
    input  wire rstn,
    input  wire [31:0] I2,
    input wire [31:0] I4,
    output reg MUX
);

always @(posedge rstn) begin
    MUX=0;
end
always @(*) begin
    MUX=0;
    if((I2[24:20]==I4[11:7])&&I4[11:7]!=0)begin
        MUX=1;//1是旁路
    end
    if (I2[6:0]==7'b0100011&&I2[14:12]==3'b010)begin
        MUX=0;//0是正常的RF-RD1
    end

end
endmodule 