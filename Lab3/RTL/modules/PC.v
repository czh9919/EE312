module PC (
    input wire clk,
    input  wire rstn,
    input  wire [11:0] I_MEM_ADD,
    output reg [11:0] O_MEM_ADD,
    output reg I_MEM_CSN,
    output reg D_MEM_CSN
);

always @(posedge rstn) begin
    O_MEM_ADD=12'b0;
    I_MEM_CSN = 0;
    D_MEM_CSN =0;
end

always @(posedge clk) begin
    if (rstn) begin
        O_MEM_ADD[11:0]=I_MEM_ADD[11:0];
        I_MEM_CSN = 0;
        D_MEM_CSN =0;
    end
end

endmodule //PC