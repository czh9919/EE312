module PC (
    input wire clk,
    input  wire rstn,
    input  wire [12:0] I_MEM_ADD,
    output reg [12:0] O_MEM_ADD
);

always @(posedge clk) begin
    if (rstn) begin
        O_MEM_ADD=0;
    end
    else begin
        O_MEM_ADD[12:0]=I_MEM_ADD[12:0];
    end
end

endmodule //PC