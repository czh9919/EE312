`define LEN 8
`define FR_LEN 2
`define MID_LEN 4
`define BA_LEN 3
module CACHE (
	input wire clk,
	input wire rstn,
	input  wire WEN,
	input wire [11:0]	ADDR, //地址
	input wire [31:0]	DI, //进入的数据
	output	reg	[31:0]	DOUT, //出去的数据
	output  reg stall, //没找到就是1，通常为0

	output reg trans,
	output reg MEMW,
	output reg  [11:0] MEM_ADDR,
	output reg  [31:0] MEM_DI,
	input  wire [31:0] MEM_DOUT,

	input  wire BA_trans,
	input  wire BA_MEMW,
	input  wire [11:0] BA_MEM_ADDR,
	input  wire [31:0] BA_MEM_DI,
	input  wire [31:0] s,
	input  wire [31:0] temp_I
);

reg [`BA_LEN:0]p[0:`LEN-1];
reg [`FR_LEN:0]index[0:`LEN-1];
reg [`MID_LEN:0]sign[0:`LEN-1];

reg [31:0]cache0[0:`LEN-1];
reg [31:0]cache1[0:`LEN-1];
reg [31:0]cache2[0:`LEN-1];
reg [31:0]cache3[0:`LEN-1];

reg [2:0]state;
reg valid;

reg [1:0] tim;
reg [11:0] ADDR_DOUT;
integer i;
initial begin
	for (i = 0; i<`LEN; i=i+1) begin
		sign[i]=0;
	end
	for (i = 0; i<`LEN; i=i+1) begin
		p[i]=0;
	end
	for (i = 0; i<`LEN; i=i+1) begin
		index[i]=0;
	end

end
always @(posedge rstn) begin //todo这里补下
	stall=0;
	DOUT=32'b00;
	state=0;
	trans=0;
	MEMW=1;
	MEM_ADDR=0;
	MEM_DI=0;
	tim=0;
	for (i = 0; i<`LEN; i=i+1) begin
		cache0[i]=0;
		cache1[i]=0;
		cache2[i]=0;
		cache3[i]=0;
	end

end

reg [2:0]t;
reg [2:0]m;
reg [1:0]f;
reg [2:0]u;


always @(*) begin
	MEM_ADDR=ADDR;
	MEM_DI=DI;
	MEMW=WEN;
end
always @(*) begin
	state[1]=~WEN;
end
always @(*) begin //? 没想好有没有必要
	state=3'b0;
	tim=tim+1;
end
wire [31:0] out;
always @(*) begin
	DOUT=out;
end
always @(*) begin
	state[0]=valid;
end
MUX4 mux(
	.clk(clk),
	.rstn(rstn),
	.CON(ADDR[3:2]),
	.in0(cache0[ADDR[11:9]]),
	.in1(cache1[ADDR[11:9]]),
	.in2(cache2[ADDR[11:9]]),
	.in3(cache3[ADDR[11:9]]),
	.DOUT(out)
);


always @(*) begin
	if (~WEN&&s[31:2]>0&&s[1:0]==00) begin
		MEMW=0;
		trans=0;
		sign[ADDR[11:9]]=ADDR[8:4];
		if (ADDR[3:2]==2'b0) begin
			cache0[ADDR[11:9]]=DI;
		end
		if (ADDR[3:2]==2'b1) begin
			cache1[ADDR[11:9]]=DI;
		end
		if (ADDR[3:2]==2'b10) begin
			cache2[ADDR[11:9]]=DI;
		end
		if (ADDR[3:2]==2'b11) begin
			cache3[ADDR[11:9]]=DI;
		end
		p[ADDR[11:9]][ADDR[3:2]]=1;
		//save
	end
	if (state==3'b01&&s[31:2]>0&&s[1:0]==11) begin
		MEMW=1;
		trans=0;
	end
	if (state==3'b00&&s[31:2]>0&&s[1:0]==11) begin
		MEMW=1;
		trans=1;
	end
end
always @(*) begin//! 没回来
	if (BA_trans==1) begin
		//load
		sign[BA_MEM_ADDR[11:9]]=BA_MEM_ADDR[8:4];
		if (BA_MEM_ADDR[3:2]==2'b0) begin
			cache0[BA_MEM_ADDR[11:9]]=MEM_DOUT;
		end
		if (BA_MEM_ADDR[3:2]==2'b1) begin
			cache1[BA_MEM_ADDR[11:9]]=MEM_DOUT;
		end
		if (BA_MEM_ADDR[3:2]==2'b10) begin
			cache2[BA_MEM_ADDR[11:9]]=MEM_DOUT;
		end
		if (BA_MEM_ADDR[3:2]==2'b11) begin
			cache3[BA_MEM_ADDR[11:9]]=MEM_DOUT;
		end
		p[BA_MEM_ADDR[11:9]][BA_MEM_ADDR[3:2]]=1;
	end
end
reg va;
always @(posedge clk) begin
	va=(~(temp_I[6:0]==7'b0100011&&temp_I[14:12]==3'b010))?((p[ADDR[11:9]][ADDR[3:2]])&(sign[ADDR[11:9]]==ADDR[8:4])):1'b1;
	t=sign[ADDR[11:9]]==ADDR[8:4];
	m=p[ADDR[11:9]][ADDR[3:2]];
	f=s[1:0]==2'b11;
	if (s[31:2]>0&&s[1:0]==2'b11) begin
		valid=va;
	end
	else begin
		valid=1'b1;
	end
	stall=~valid;
end

endmodule //CACHE