module HALT (
    input  wire [31:0]I_MEM,
    input  wire [31:0]RF_RD,
    output reg HALT_o
);

always @(*) begin
    if(I_MEM==16'h8067&&RF_RD==16'hc)
        HALT_o=1;
    else
        HALT_o=0;
end

endmodule //HALT