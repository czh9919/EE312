module UNIT2 (
    input  wire clk,
    input  wire rstn,
    input  wire [31:0] I1,
    input wire [31:0] I4,
    output reg MUXA,
    output reg MUXB
);

always @(posedge rstn) begin
    MUXA=0;
end
always @(*) begin
    MUXA=0;
    if((I1[19:15]==I4[11:7])&&I4[11:7]!=0)begin
        MUXA=1;//1是旁路
    end
    if (I4[6:0]==7'b0100011&&I4[14:12]==3'b010)begin
        MUXA=0;//0是正常的RF-RD1
    end
    if((I1[24:20]==I4[11:7])&&I4[11:7]!=0)begin
        MUXA=1;//1是旁路
    end
end
endmodule 