module PC (
    input wire clk,
    input  wire rstn,
    input  wire [11:0] I_MEM_ADD,
    output reg [11:0] O_MEM_ADD
);

always @(posedge clk) begin
    if (~rstn) begin
        O_MEM_ADD=12'b0;
    end
    else begin
        O_MEM_ADD[11:0]=I_MEM_ADD[11:0];
        $display("%b has been passed",O_MEM_ADD);
    end
end

endmodule //PC