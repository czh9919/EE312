module PC (
    input wire clk,
    input  wire rstn,
    input  wire [12:0] I_MEM_ADDR,
    output wire [12:0] O_MEM_ADDR
);

always @(posedge clk) begin
    if (rstn) begin
        O_MEM_ADDR=0;
    end
    else begin
        O_MEM_ADDR[12:0]=I_MEM_ADDR[12:0]
    end
end

endmodule //PC