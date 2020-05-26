module RISCV_TOP (
	//General Signals
	input wire CLK,
	input wire RSTn,

	//I-Memory Signals
	output wire I_MEM_CSN,
	input wire [31:0] I_MEM_DI,//input from IM
	output reg [11:0] I_MEM_ADDR,//in byte address

	//D-Memory Signals
	output wire D_MEM_CSN,
	input wire [31:0] D_MEM_DI,
	output wire [31:0] D_MEM_DOUT,
	output wire [11:0] D_MEM_ADDR,//in word address
	output wire D_MEM_WEN,
	output wire [3:0] D_MEM_BE,

	//RegFile Signals
	output wire RF_WE,
	output wire [4:0] RF_RA1,
	output wire [4:0] RF_RA2,
	output wire [4:0] RF_WA1,
	input wire [31:0] RF_RD1,
	input wire [31:0] RF_RD2,
	output wire [31:0] RF_WD,
	output wire HALT,                   // if set, terminate program
	output reg [31:0] NUM_INST,         // number of instruction completed
	output wire [31:0] OUTPUT_PORT      // equal RF_WD this port is used for test
	);

	assign OUTPUT_PORT = RF_WD;

	initial begin
		NUM_INST <= 0;
	end

	// Only allow for NUM_INST
	always @ (negedge CLK) begin
		if (RSTn) NUM_INST <= NUM_INST + 1;
	end


	// TODO: implement


	//控制变量
	wire PCsource;
	wire PCwrite;
	wire RegDst;
	wire [1:0]CON_sign;
	wire [3:0] ALUOP;
	wire alu_RD;

	//连接线
	wire [11:0] back_PC;
	wire [11:0] out_PC;
	wire [11:0] PC4;
	wire [11:0] PC_imm;
	wire [11:0] PC4_2;
	wire [11:0] W_BS_Sign0;
	wire [11:0] W_BS_Sign1;
	wire [11:0] A0;
	wire [11:0] PC_imm_0;

	wire [31:0] B0;
	wire [31:0] W_BS_Sign2;
	wire [31:0] SM0;
	wire [31:0] SM1;
	wire [31:0] SM2;
	wire [31:0] Inst2;
	wire [31:0] back_WD;
	wire [31:0] sign_out;
	wire [31:0] A;
	wire [31:0] B;
	wire [31:0] RB0;
	wire [31:0] ALU_ans;
	wire [31:0] out_ALUout;

	//HALT
	HALT halt(
		.I_MEM(I_MEM_DI),
		.RF_RD(RF_RD1),
		.HALT_o(HALT)
	);
	//第一周期
	PC PC_TOP(
		.clk(CLK),
		.rstn(RSTn),
		.PCwrite(PCwrite),
		.I_MEM_ADD(back_PC),
		.O_MEM_ADD(out_PC),
		.I_MEM_CSN(I_MEM_CSN),
		.D_MEM_CSN(D_MEM_CSN)
	);
	always @(*) begin
		I_MEM_ADDR=out_PC;
	end

	assign PC4=out_PC+4;
	MUX #(
		.DWIDTH(12)
	)MUX_backtoPC(
		.clk(CLK),
		.rstn(RSTn),
		.CON(PCsource),
		.in0(PC4),
		.in1(PC_imm),
		.DOUT(back_PC)
	);

	//第一周期寄存器

	REG #(
		.DWIDTH(12)
	) ID_EX0(
		.clk(CLK),
		.rstn(RSTn),
		.in(PC4),
		.DOUT(PC4_2)
	);

	REG #(
		.DWIDTH(32)
	) ID_EX1(
		.clk(CLK),
		.rstn(RSTn),
		.in(I_MEM_DI),
		.DOUT(Inst2)
	);

	//第二周期
	assign RF_RA1=Inst2[19:15];
	assign RF_RA2=Inst2[24:20];
	assign RF_WA1=Inst2[11:7];

	MUX #(
		.DWIDTH(32)
	)before_WD(
		.clk(CLK),
		.rstn(RSTn),
		.CON(RegDst),
		.in0({20'b0,PC4_2}),
		.in1(back_WD),
		.DOUT(RF_WD)
	);

	SIGN_EXTEND #(
		.I_DWIDTH(12),
		.O_DWIDTH(32)
	) sign0(
		.clk(CLK),
		.rstn(RSTn),
		.I_DI(W_BS_Sign0),
		.O_DI(SM0)
	);
	SIGN_EXTEND #(
		.I_DWIDTH(12),
		.O_DWIDTH(32)
	) sign1(
		.clk(CLK),
		.rstn(RSTn),
		.I_DI({W_BS_Sign1[11:1],1'b0}),
		.O_DI(SM1)
	);
	assign SM2=W_BS_Sign2;

	MUX3 #(
		.DWIDTH(32)
	) Aft_Sign(
		.clk(CLK),
		.rstn(RSTn),
		.CON(CON_sign),
		.in0(SM0),
		.in1(SM1),
		.in2(SM2),
		.DOUT(sign_out)
	);

	//第二周期寄存器

	REG#(
		.DWIDTH(12)
	)EX_MEM0(
		.clk(CLK),
		.rstn(RSTn),
		.in(PC4_2),
		.DOUT(A0)
	);
	REG#(
		.DWIDTH(32)
	)EX_MEM1(
		.clk(CLK),
		.rstn(RSTn),
		.in(RF_RD1),
		.DOUT(A)
	);
	REG#(
		.DWIDTH(32)
	) EX_MEM2(
		.clk(CLK),
		.rstn(RSTn),
		.in(RF_RD2),
		.DOUT(RB0)
	);
	REG#(
		.DWIDTH(32)
	)EX_MEM3(
		.clk(CLK),
		.rstn(RSTn),
		.in(sign_out),
		.DOUT(B0)
	);

	wire [31:0]temp;
	//第三周期
	//a0是12位的
	ALU ALU0(
		.A({20'b0,A0}),
		.B(B0),
		.OP(4'b0),
		.C(temp)
	);
	assign PC_imm_0=temp[11:0];
	MUX#(
		.DWIDTH(32)
	) before_B(
		.clk(CLK),
		.rstn(RSTn),
		.CON(CON_B),
		.in0(RB0),
		.in1(sign_out),
		.DOUT(B)
	);

	ALU ALU_TOP(
		.A(A),
		.B(B),
		.OP(ALUOP),
		.C(ALU_ans)
	);
	//第三周期寄存器

	REG#(
		.DWIDTH(12)
	)MEM_WB0(
		.clk(CLK),
		.rstn(RSTn),
		.in(PC_imm_0),
		.DOUT(PC_imm)
	);

	REG #(
		.DWIDTH(32)
	)MEM_WB1(
		.clk(CLK),
		.rstn(RSTn),
		.in(ALU_ans),
		.DOUT(out_ALUout)
	);

	REG #(
		.DWIDTH(32)
	) MEM_WB2(
		.clk(CLK),
		.rstn(RSTn),
		.in(RB0),
		.DOUT(D_MEM_DOUT) //第四周期的一根线
	);

	//第四周期
	assign D_MEM_ADDR=out_ALUout[11:0];
	MUX#(
		.DWIDTH(32)
	)back_DOUT(
		.clk(CLK),
		.rstn(RSTn),
		.CON(alu_RD),
		.in0(out_ALUout),
		.in1(D_MEM_DI),
		.DOUT(back_WD)
	);
endmodule //
