module HAZARD (
    input wire clk,
    input wire rstn,
    input wire [11:0] PC4_2,
    input wire [11:0] PC4,
    input  wire [31:0] NUM_INST,
    output reg s
);

always @(posedge rstn) begin
    s=0;
end
always @(negedge clk) begin
    if (PC4_2!=PC4-4&&NUM_INST>0) begin
        s=1;
    end
    else begin
        s=0;
    end
end

endmodule //CONTROLHAZARD