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
		NUM_INST <= -3;
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
	wire  PL_A;
	wire  PL_B;

	//控制路连接线
	wire [11:0] out_control_0;//PC_source走
	wire [10:0] out_control_1;//MUX_SEX和RegWrite和Reg_MUX走
	wire [6:0] out_control_2;//ALU_op和MUX_ALU走
	wire [1:0] out_control_3;

	//数据路连接线
	wire [11:0] back_PC;
	wire [11:0] out_PC;
	wire [11:0] PC4;
	wire [11:0] PC_imm;
	wire [11:0] PC4_2;
	wire [11:0] W_BS_Sign0;
	wire [11:0] W_BS_Sign1;
	wire [11:0] A0;
	wire [11:0] PC_imm_0;

	wire [31:0] INS_0;
	wire [31:0] INS_1;
	wire [31:0] INS_2;
	wire [31:0] INS_3;

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
	wire [31:0] A_init;
	wire [31:0] B_init;

	//HALT
	HALT halt(
		.I_MEM(I_MEM_DI),
		.RF_RD(RF_RD1),
		.HALT_o(HALT)
	);
	CONTROL CONTROL_TOP(
		.clk(CLK),
		.rstn(RSTn),
		.I_OP(I_MEM_DI),
		.PC_source(out_control_0[11]),
		.RegWrite(out_control_0[10]),
		.MUX_SEXT(out_control_0[9:8]),
		.Reg_MUX(out_control_0[7]),
		.MUX_ALU(out_control_0[6]),
		.ALUOp(out_control_0[5:2]),
		.MemWrite(out_control_0[1]),
		.beq_con(out_control_0[0])
	);
	//第一周期
	assign INS_0=I_MEM_DI;
	assign PCsource=out_control_0[11];
	PC PC_TOP(
		.clk(CLK),
		.rstn(RSTn),
		.PCwrite(1'b1),
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
	REG#(
		.DWIDTH(32)
	)ID_EX_INS(
		.clk(CLK),
		.rstn(RSTn),
		.in(INS_0),
		.DOUT(INS_1)
	);
	//控制
	REG#(
		.DWIDTH(11)
	)ID_EX_CON(
		.clk(CLK),
		.rstn(RSTn),
		.in(out_control_0[10:0]),
		.DOUT(out_control_1[10:0])
	);
	//数据
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
	assign RF_WE=out_control_1[10];
	assign CON_sign=out_control_1[9:8];
	assign RegDst=out_control_1[7];

	assign W_BS_Sign1=INS_1[31:20];
	assign W_BS_Sign0={INS_1[31:25],INS_1[11:7]};
	assign W_BS_Sign2={27'b0,INS_1[24:20]};

	assign RF_RA1=INS_1[19:15];
	assign RF_RA2=INS_1[24:20];
	assign RF_WA1=INS_1[11:7];
	
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
		.I_DI(W_BS_Sign1),
		.O_DI(SM1)
	);
	SIGN_EXTEND #(
		.I_DWIDTH(12),
		.O_DWIDTH(32)
	) sign1(
		.clk(CLK),
		.rstn(RSTn),
		.I_DI({W_BS_Sign0[11:1],1'b0}),
		.O_DI(SM0)
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
		.DWIDTH(32)
	)EX_MEM_INS(
		.clk(CLK),
		.rstn(RSTn),
		.in(INS_1),
		.DOUT(INS_2)
	);
	//控制
	REG #(
		.DWIDTH(7)
	)EX_MEM_CON(
		.clk(CLK),
		.rstn(RSTn),
		.in(out_control_1[6:0]),
		.DOUT(out_control_2[6:0])
	);
	//数据
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
		.DOUT(A_init)
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
	//旁路
	UNIT UNIT_TOP(
		.rstn(RSTn),
		.I3(INS_2),
		.I4(INS_3),
		.MUXA(PL_A),
		.MUXB(PL_B)
	);
	//控制
	assign CON_B=out_control_2[6];
	assign ALUOP=out_control_2[5:2];
	//数据
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
	)PL1(
		.clk(CLK),
		.rstn(RSTn),
		.CON(PL_A),
		.in0(A_init),
		.in1(back_WD),
		.DOUT(A)
	);

	MUX #(
		.DWIDTH(32)
	)PL2(
		.clk(CLK),
		.rstn(RSTn),
		.CON(PL_B),
		.in0(B_init),
		.in1(back_WD),
		.DOUT(B)
	);

	MUX#(
		.DWIDTH(32)
	) before_B(
		.clk(CLK),
		.rstn(RSTn),
		.CON(CON_B),
		.in0(RB0),
		.in1(B0),
		.DOUT(B_init)
	);

	ALU ALU_TOP(
		.A(A),
		.B(B),
		.OP(ALUOP),
		.C(ALU_ans)
	);
	//第三周期寄存器
	REG#(
		.DWIDTH(32)
	)MEM_WB_INS(
		.clk(CLK),
		.rstn(RSTn),
		.in(INS_2),
		.DOUT(INS_3)
	);
	REG #(
		.DWIDTH(2)
	)MEM_WB_CON(
		.clk(CLK),
		.rstn(RSTn),
		.in(out_control_2[1:0]),
		.DOUT(out_control_3[1:0])
	);
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
	assign D_MEM_WEN=out_control_3[1];
	assign alu_RD=out_control_3[0];
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
