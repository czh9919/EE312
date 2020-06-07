/* module HAZARD (
    input wire clk,
    input wire rstn,
    input wire [11:0] PC4_2,
    input wire [11:0] PC4,
    input  wire [31:0] NUM_INST,
    output reg s
);
reg [2:0]temp;
always @(posedge rstn) begin
    s=0;
    temp=0;
end
always @(negedge clk) begin
    if (PC4_2!=PC4-4&&NUM_INST[31]!=1'b1&&temp>4) begin
        s=1;
    end
    else begin
        s=0;
    end

    temp=temp+1;
end */
/* 
endmodule //CONTROLHAZARD */