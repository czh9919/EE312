`define AWIDTH 12
`define WD 78
module D_MEM (
    input  wire clk,
    input  wire rstn,

    input  wire trans,
    input  wire WEN,
    input  wire [11:0] ADDR,
    input  wire [31:0] DI,
    output reg [31:0] DOUT,

    output reg [77:0]MEM_I,
    input  wire [77:0] MEM_O,

    output reg trans0,
    output reg [11:0] ADDR0,
    output reg WEN0,
    output reg [31:0] DI0,
    input  wire [31:0] DOUT0
);
wire [`WD-1:0]in0;
wire [`WD-1:0]in1;
wire [`WD-1:0]in2;
wire [`WD-1:0] in3;
wire [`WD-1:0]out0;
wire [`WD-1:0]out1;
wire [`WD-1:0]out2;
wire [`WD-1:0] out3;

assign in0[`WD-1:0]= {trans,ADDR[`AWIDTH-1:0],WEN,DI[31:0],DOUT0[31:0]};
always @(*) begin
    trans0=out3[`WD-1];
    ADDR0[`AWIDTH-1:0]=out3[`WD-2:65];
    WEN0=out3[64];
    DI0[31:0]=out3[63:32];
    DOUT[31:0]=out3[31:0];
end
always @(*) begin
    assign MEM_I=in3;
end


assign out0=MEM_O;
//input
REG#(
    .DWIDTH(`WD)
)REG0(
    .clk(clk),
    .rstn(rstn),
    .in(in0),
    .DOUT(in1)
);
REG#(
    .DWIDTH(`WD)
)REG1(
    .clk(clk),
    .rstn(rstn),
    .in(in1),
    .DOUT(in2)
);
REG#(
    .DWIDTH(`WD)
)REG2(
    .clk(clk),
    .rstn(rstn),
    .in(in2),
    .DOUT(in3)
);

//output
REG#(
    .DWIDTH(`WD)
)REG_O_0(
    .clk(clk),
    .rstn(rstn),
    .in(out0),
    .DOUT(out1)
);
REG#(
    .DWIDTH(`WD)
)REG_O_1(
    .clk(clk),
    .rstn(rstn),
    .in(out1),
    .DOUT(out2)
);
REG#(
    .DWIDTH(`WD)
)REG_O_2(
    .clk(clk),
    .rstn(rstn),
    .in(out2),
    .DOUT(out3)
);


endmodule //D_MEM