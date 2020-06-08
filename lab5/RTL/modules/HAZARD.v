module HAZARD (
    input wire clk,
    input wire rstn,
    input  wire [31:0] I2,
    input wire [31:0] I5,
    output reg s
);

always @(posedge rstn) begin
    s=0;
end
/* always @(*) begin
    s=0;
    if (((~(I2[6:0]==7'b0100011&&I2[14:12]==3'b010)))&&((I5[6:0]==7'b0100011&&I5[14:12]==3'b010))&&(I2[19:15]==I5[11:7])&&I5[11:7]!=0)begin
        s=1;
    end
    else begin
        s=0;
    end
end  */

endmodule //CONTROLHAZARD 