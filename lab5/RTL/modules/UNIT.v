module UNIT (
    input  wire rstn,
    // input wire [31:0] I2,
    input  wire [31:0] I3,
    input wire [31:0] I4,
    output reg MUXA,
    output reg MUXB
);
always @(posedge rstn) begin
    MUXA=0;
    MUXB=0;
end

always @(*) begin
    // if((I2[24:20]==I3[11:7])&&I3[11:7]!=0)begin
    //     MUXA=0;
    //     MUXB=1;
    // end
    if((I3[6:0]==7'b0010011||I3[6:0]==7'b1100111)begin
         MUXA=0;
         MUXB=0;
    end
    if((I3[24:20]==I4[11:7])&&I4[11:7]!=0)begin
        MUXA=0;
        MUXB=1;
    end
    else if((I3[19:15]==I4[11:7])&&I4[11:7]!=0)begin
        MUXA=1;
        MUXB=0;
    end
    else begin
        MUXA=0;
        MUXB=0;
    end
end
endmodule 