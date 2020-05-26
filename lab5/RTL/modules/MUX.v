module MUX #(
    parameter DWIDTH=32
)(
    input  wire clk,
    input  wire rstn,
    input  wire CON,
    input  wire [DWIDTH-1:0] in0,
    input  wire [DWIDTH-1:0] in1,
    output reg  [DWIDTH-1:0] DOUT
);

always @(posedge rstn) begin
	DOUT=32'b0;
end

always @(*) begin
    if (CON) begin
        DOUT=in1;
    end
    else
        DOUT=in0;
end

endmodule //MUX