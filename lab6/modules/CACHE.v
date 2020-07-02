`define LEN 8
`define FR_LEN 2
`define MID_LEN 4
`define BA_LEN 1
module CACHE (
	input wire clk,
	input wire rstn,
	input  wire WEN,
	input wire [11:0]	ADDR, //地址
	input wire [31:0]	DI, //进入的数据
	output	reg	[31:0]	DOUT, //出去的数据
	output  reg stall, //没找到就是1，通常为0

	output reg trans;
	output reg MEMW,
	output reg  [11:0] MEM_ADDR,
	output reg  [31:0] MEM_DI,
	input  wire [31:0] MEM_DOUT,

	input  wire BA_trans,
	input  wire BA_MEMW,
	input  wire [11:0] BA_MEM_ADDR,
	input  wire [31:0] BA_MEM_DI,
);

reg [BA_LEN:0]p[0:LEN-1];
reg [FR_LEN:0]index[0:LEN-1];
reg [MID_LEN:0]sign[0:LEN-1];

reg [31:0]cache0[0:LEN-1];
reg [31:0]cache1[0:LEN-1];
reg [31:0]cache2[0:LEN-1];
reg [31:0]cache3[0:LEN-1];

reg [2:0]state;
reg valid;

reg [31:0] MEM_DOUT;
reg [11:0] ADDR_DOUT;

always @(posedge rstn) begin //todo这里补下
	stall=0;
	DOUT=32'b00;
	state=0;
end

assign valid=p[ADDR[11:9]][ADDR[3:2]]&(sign[ADDR[11:9]]==ADDR[8:4]);

assign MEM_ADDR=ADDR;
assign MEM_DI=DI;
assign MEM_DOUT=DOUT;

always @(posedge clk) begin //? 没想好有没有必要
	state=3'b0;
	state[1]=~WEN;
end

MUX4(
	.clk(clk),
	.rstn(rstn),
	.CON(ADDR[3:2]),
	.in0(cache0),
	.in1(cache1),
	.in2(cache2),
	.in3(cache3),
	.DOUT(DOUT)
);
assign state[0]=valid;

always @(*) begin
	if (state[1]==1) begin
		MEMW=0;
		trans=~BA_trans;
		if (ADDR[3:2]=2'b0) begin
			cache0[ADDR[11:9]]=DI;
		end
		if (ADDR[3:2]=2'b1) begin
			cache1[ADDR[11:9]]=DI;
		end
		if (ADDR[3:2]=2'b10) begin
			cache2[ADDR[11:9]]=DI;
		end
		if (ADDR[3:2]=2'b11) begin
			cache3[ADDR[11:9]]=DI;
		end
		//save
	end
	if (state==3'b01) begin
		MEMW=1;
		trans=BA_trans;
	end
	if (state==3'b00) begin
		MEMW=1;
		trans=~BA_trans;
	end
end
always @(*) begin
	if (BA_MEMW) begin
		//load
		if (ADDR[3:2]=2'b0) begin
			cache0[ADDR[11:9]]=MEM_DOUT;
		end
		if (ADDR[3:2]=2'b1) begin
			cache1[ADDR[11:9]]=MEM_DOUT;
		end
		if (ADDR[3:2]=2'b10) begin
			cache2[ADDR[11:9]]=MEM_DOUT;
		end
		if (ADDR[3:2]=2'b11) begin
			cache3[ADDR[11:9]]=MEM_DOUT;
		end
		p[ADDR[11:9]][ADDR[3:2]]=1;
	end
	if (BA_trans==trans) begin
		stall=0;
	end
	else begin
		stall=1;
	end
end
endmodule //CACHE