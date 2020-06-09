module HALT (
    input  wire [31:0]I_MEM1,
    input  wire [31:0]I_MEM2,
    output reg HALT_o
);

always @(*) begin
    if(I_MEM2==16'hc0093||I_MEM1==16'h8067)
        HALT_o=1;
    else
        HALT_o=0;
end



endmodule //HALT