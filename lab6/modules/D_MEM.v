`define AWIDTH 12
module D_MEM (
    input  wire clk,
    input  wire rstn,
    input  wire [AWIDTH-1:0] ADDR,
    input  wire WEN,
    input  wire [31:0] DI,
    input  wire [31:0] DOUT0,
    output wire [31:0] DOUT,
    output wire [AWIDTH-1:0] ADDR0,
    output wire WEN0,
    output wire [31:0] DI0,
);
wire in0[76:0],in1[76:0],in2[76:0],in3[76:0];
wire out0[76:0],out1[76:0],out2[76:0],out3[76:0];

assign in0[76:0]={ADDR[AWIDTH-1:0],WEN,DI[31:0],DOUT0[31:0]};
assign out0[76:0]={ADD0R[AWIDTH-1:0],WEN0,DI0[31:0],DOUT[31:0]};

assign ADDR0[AWIDTH]=in3[76:65];
assign WEN0=in3[64];
assign DI0[31:0]=in3[63:32];
assign DOUT[31:0]=in3[31:0];

//input
REG#(
    .DWIDTH(77)
)REG0(
    .clk(clk),
    .rstn(rstn),
    .in(in0),
    .DOUT(in1)
);
REG#(
    .DWIDTH(77)
)REG1(
    .clk(clk),
    .rstn(rstn),
    .in(in1),
    .DOUT(in2)
);
REG#(
    .DWIDTH(77)
)REG2(
    .clk(clk),
    .rstn(rstn),
    .in(in2),
    .DOUT(in3)
);
/* 
//output
REG#(
    .DWIDTH(77)
)REG_O_0(
    .clk(clk),
    .rstn(rstn),
    .in(out0),
    .DOUT(out1)
);
REG#(
    .DWIDTH(77)
)REG_O_1(
    .clk(clk),
    .rstn(rstn),
    .in(out1),
    .DOUT(out2)
);
REG#(
    .DWIDTH(77)
)REG_O_2(
    .clk(clk),
    .rstn(rstn),
    .in(out2),
    .DOUT(out3)
); */
endmodule

endmodule //D_MEM