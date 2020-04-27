module Reverse #(
    parameter D=12
)
(
    input  wire rstn,
    input  wire [D-1:0] input1,
    output reg [D-1:0] output1
);
integer i;

always @(posedge rstn) begin
    output1=0;
end

always @(*) begin
    for (i = 0; i<D; i=i+1) begin
        output1[D-1-i]=input1[i];
    end
end

endmodule //Reverse