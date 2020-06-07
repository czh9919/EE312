module CONTROLHAZARD (
    input wire clk,
    input wire rstn,
    input wire [11:0] ADDr,//当前地址
    input wire [11:0] ADD,//上一地址
    output reg s
);
//reg [1:0] state=2'b00;
always @(posedge rstn) begin
    s=0;
end
always @(negedge clk) begin
    if(ADDr!=ADD+4)begin//branch
        s=1;
    end
    else begin
        s=0;
    end
end

endmodule //CONTROLHAZARD