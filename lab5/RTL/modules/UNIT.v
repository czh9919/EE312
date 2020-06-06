module UNIT (
    input  wire clk,
    input  wire rstn,
    // input wire [31:0] I2,
    input  wire [31:0] I3,
    input wire [31:0] I4,
    input  wire [31:0] I5,
    output reg [1:0]MUXA,
    output reg [1:0]MUXB
);
always @(posedge rstn) begin
    MUXA=0;
    MUXB=0;
end
always @(negedge  clk) begin
    MUXA=0;
    MUXB=0;
end
always @(*) begin
    if((I3[24:20]==I5[11:7])&&I5[11:7]!=0)begin
        MUXB=2'b10;
        if ((I3[31:25]==7'b0100000&&I3[6:0]==7'b0010011&&I3[14:12]==3'b101)||I3[6:0]==7'b0010011)begin
            MUXB=0;
        end
    end
    if((I3[19:15]==I5[11:7])&&I5[11:7]!=0)begin
        MUXA=2'b10;
    end
    if((I3[24:20]==I4[11:7])&&I4[11:7]!=0)begin
        MUXB=2'b01;
        if ((I3[31:25]==7'b0100000&&I3[6:0]==7'b0010011&&I3[14:12]==3'b101)||I3[6:0]==7'b0010011)begin
            MUXB=0;
        end
    end
    if((I3[19:15]==I4[11:7])&&I4[11:7]!=0)begin
        MUXA=2'b01;
    end
end
endmodule 