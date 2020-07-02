`define AWIDTH 12
`define WD 78
module D_MEM (
    input  wire clk,
    input  wire rstn,

    input  wire trans,
    input  wire WEN,
    input  wire [AWIDTH-1:0] ADDR,
    input  wire [31:0] DI,
    output reg [31:0] DOUT,

    output reg [WD-1:0]MEM_I;
    input  wire [WD-1:0] MEM_O;

    output reg trans0,
    output reg [AWIDTH-1:0] ADDR0,
    output reg WEN0,
    output reg [31:0] DI0,
    input  wire [31:0] DOUT0,
);
wire in0[WD-1:0],in1[WD-1:0],in2[WD-1:0],in3[WD-1:0];
wire out0[WD-1:0],out1[WD-1:0],out2[WD-1:0],out3[WD-1:0];

assign in0[WD-1:0]= {trans,ADDR[AWIDTH-1:0],WEN,DI[31:0],DOUT0[31:0]};
// assign out0[WD-1:0]={trans0,ADDR0[AWIDTH-1:0],WEN0,DI0[31:0],DOUT[31:0]};

assign trans0=out3[WD-1];
assign ADDR0[AWIDTH]=out3[WD-2:65];
assign WEN0=out3[64];
assign DI0[31:0]=out3[63:32];
assign DOUT[31:0]=out3[31:0];

assign MEM_I=in3;
assign out0=MEM_O;
//input
REG#(
    .DWIDTH(WD)
)REG0(
    .clk(clk),
    .rstn(rstn),
    .in(in0),
    .DOUT(in1)
);
REG#(
    .DWIDTH(WD)
)REG1(
    .clk(clk),
    .rstn(rstn),
    .in(in1),
    .DOUT(in2)
);
REG#(
    .DWIDTH(WD)
)REG2(
    .clk(clk),
    .rstn(rstn),
    .in(in2),
    .DOUT(in3)
);

//output
REG#(
    .DWIDTH(WD)
)REG_O_0(
    .clk(clk),
    .rstn(rstn),
    .in(out0),
    .DOUT(out1)
);
REG#(
    .DWIDTH(WD)
)REG_O_1(
    .clk(clk),
    .rstn(rstn),
    .in(out1),
    .DOUT(out2)
);
REG#(
    .DWIDTH(WD)
)REG_O_2(
    .clk(clk),
    .rstn(rstn),
    .in(out2),
    .DOUT(out3)
);
endmodule

endmodule //D_MEM