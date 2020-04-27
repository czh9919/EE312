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
	wire isnot_PC_4;
	wire back_PC_CON;
	wire isJALR;
	wire isCout;
	wire isLUI;
	wire isLUIAUI;
	wire isJAL;
	wire is_down_s;
	wire [3:0]ALUOp;
	wire [31:0]chos_LUI_JALR;
	wire temp_WEN;
	wire ALUSrc;
	wire isSLLISRLISRAI;
	wire issw;
	wire is_sign_ex;
	wire is_down_se;
	CONTROL CONT(
		.clk(CLK),
		.rstn(RSTn),
		.I_OP(I_MEM_DI),
		.O_MemtoReg(MemtoReg),
		.O_ALUSrc(ALUSrc),
		.O_RegWrite(RF_WE),
		.O_MemWrite(temp_WEN),
		.O_MemRead(D_MEM_BE),
		.O_ALUOp(ALUOp),
		.isnot_PC_4(isnot_PC_4),
		.isJALR(isJALR),
		.isCout(isCout),
		.isJAL(isJAL),
		.is_down_se(is_down_se),
		.isLUI(isLUI),
		.isLUIAUI(isLUIAUI),
		.is_sign_ex(is_sign_ex),
		.isSLLISRLISRAI(isSLLISRLISRAI),
		.issw(issw)
	);
	assign D_MEM_WEN=~temp_WEN;
	// TODO: control
	assign RF_RA1 = I_MEM_DI[19:15];
	assign RF_RA2 = I_MEM_DI[24:20];
	assign RF_WA1=I_MEM_DI[11:7];
	// TODO:WR

	wire [11:0]PC_4_to_MUX;
	wire [11:0]Back_to_PC;
	wire [11:0]OUT_PC;
	wire [31:0]out_and;
	PC PC_TOP(
		.clk(CLK),
		.rstn(RSTn),
		.I_MEM_ADD(Back_to_PC),
		.O_MEM_ADD(OUT_PC),
		.I_MEM_CSN(I_MEM_CSN),
		.D_MEM_CSN(D_MEM_CSN)
	);
	always @(*) begin
		I_MEM_ADDR[11:0]=OUT_PC[11:0];
	end
	//TODO backTOPC connect with outPC
	wire [31:0]SIGN_EXTEND_to_MUX_ADD;
	wire [31:0]MUX_TO_ALU;

	wire [31:0]ALU_Ans;
	wire CoutAns;

	wire [31:0]SIGN_EXTEND_to_ready_MUX_ADD_0;
	wire [31:0]SIGN_EXTEND_to_ready_MUX_ADD_2;
	HALT halt(
		.I_MEM(I_MEM_DI),
		.RF_RD(RF_RD1),
		.HALT_o(HALT)
	);
	SIGN_EXTEND #(
		.I_DWIDTH(12),
		.O_DWIDTH(32)
	) Down_REG(
		.clk(CLK),
		.rstn(RSTn),
		.I_DI(I_MEM_DI[31:20]),
		.O_DI(SIGN_EXTEND_to_ready_MUX_ADD_0)
	);
	wire [31:0]SIGN_EXTEND_to_ready_MUX_ADD_1;
	SIGN_EXTEND#(
		.I_DWIDTH(20),
		.O_DWIDTH(32)
	)Down_Down_REG(
		.clk(CLK),
		.rstn(RSTn),
		.I_DI(I_MEM_DI[31:12]),
		.O_DI(SIGN_EXTEND_to_ready_MUX_ADD_1)
	);
	MUX #(
		.DWITH(32)
	)After_Down_REG(
		.clk(CLK),
		.rstn(RSTn),
		.CON(is_down_se),
		.DI(SIGN_EXTEND_to_ready_MUX_ADD_1),
		.DI1(SIGN_EXTEND_to_ready_MUX_ADD_0),
		.DOUT(SIGN_EXTEND_to_ready_MUX_ADD_2)
	);
	MUX #(
		.DWITH(32)
	) BeforeALU(
		.clk(CLK),
		.rstn(RSTn),
		.CON(ALUSrc),
		.DI(RF_RD2),
		.DI1(SIGN_EXTEND_to_MUX_ADD),
		.DOUT(MUX_TO_ALU)//!ALU out
	);

	ALU alu(
		.clk(CLK),
		.rstn(RSTn),
		.A(RF_RD1),
		.B(MUX_TO_ALU),
		.OP(ALUOp),
		.C(ALU_Ans),
		.Cout(CoutAns)
	);
	assign D_MEM_ADDR=ALU_Ans;
	assign D_MEM_DOUT=RF_RD2;
	wire [31:0] MUX_to_MUX;
	MUX #(
		.DWITH(32)//! may not 32
	)MUX_Down_MEM(
		.clk(CLK),
		.rstn(RSTn),
		.CON(MemtoReg),
		.DI(ALU_Ans),
		.DI1(chos_LUI_JALR),
		.DOUT(MUX_to_MUX)
	);
	ADD #(
		.DWIDTH(12)
	) PC_4(
		.clk(CLK),
		.rstn(RSTn),
		.DI(OUT_PC),
		.DI1(12'b0100),
		.DOUT(PC_4_to_MUX)
	);
	MUX #(
		.DWITH(32)
	) MUX_Left_WD(
		.clk(CLK),
		.rstn(RSTn),
		.CON(isJAL),//!warning  may change name
		.DI({20'b0,PC_4_to_MUX}),
		.DI1(MUX_to_MUX),
		.DOUT(RF_WD)
	);

	wire [11:0]Out_ADD;
	ADD #(
		.DWIDTH(12)
	) Up_reg_right(
		.clk(CLK),
		.rstn(RSTn),
		.DI(OUT_PC),
		.DI1(SIGN_EXTEND_to_MUX_ADD[11:0]),
		.DOUT(Out_ADD)
	);

	assign out_and=ALU_Ans^8'hfffffffe;
	wire [11:0]out_mux_to_mux;
	MUX#(
		.DWITH(12)
	) Behind_ADD(
		.clk(CLK),
		.rstn(RSTn),
		.CON(isJALR),
		.DI(out_and[11:0]),
		.DI1(Out_ADD),
		.DOUT(out_mux_to_mux)
	);
	wire [11:0]backPC1;
	MUX#(
		.DWITH(12)
	)MUXtoMUX(
		.clk(CLK),
		.rstn(RSTn),
		.CON(isnot_PC_4),
		.DI(out_mux_to_mux),
		.DI1(PC_4_to_MUX),
		.DOUT(backPC1)
	);

	wire [11:0]out_add_2;
	MUX #(
		.DWITH(12)
	) Jumpcheck(
		.clk(CLK),
		.rstn(RSTn),
		.CON(back_PC_CON),
		.DI(out_add_2),
		.DI1(backPC1),
		.DOUT(Back_to_PC)
	);

	wire [11:0]SIGN_EXTEND_to_ADD;
	SIGN_EXTEND#(
		.I_DWIDTH(7),
		.O_DWIDTH(12)
	)SIGN_EXTEND_to_add(
		.clk(CLK),
		.rstn(RSTn),
		.I_DI(I_MEM_DI[31:25]),
		.O_DI(SIGN_EXTEND_to_ADD)
	);
	wire [31:0]SIGN_EXTEND_to_SW;
	wire [31:0]SIGN_EXTEND_4;
	wire [11:0]temp_imm={I_MEM_DI[31:25],I_MEM_DI[11:7]};
	SIGN_EXTEND#(
		.I_DWIDTH(12),
		.O_DWIDTH(32)
	)SIGN_EXTEND_to_sw(
		.clk(CLK),
		.rstn(RSTn),
		.I_DI(temp_imm),
		.O_DI(SIGN_EXTEND_to_SW)
	);
	SIGN_EXTEND#(
		.I_DWIDTH(5),
		.O_DWIDTH(32)
	) SIGN_EXTEND_mod_4(
		.clk(CLK),
		.rstn(RSTn),
		.I_DI(I_MEM_DI[24:20]),
		.O_DI(SIGN_EXTEND_4)
	);
	wire [31:0]connect_SIGN_EXTEND_4to_next;
	MUX #(
		.DWITH(32)
	)MUX_4(
		.clk(CLK),
		.rstn(RSTn),
		.CON(isSLLISRLISRAI),
		.DI(SIGN_EXTEND_4),
		.DI1(connect_SIGN_EXTEND_4to_next),
		.DOUT(SIGN_EXTEND_to_MUX_ADD)
	);
	MUX #(
		.DWITH(32)
	) MUX_for_SW(
		.clk(CLK),
		.rstn(RSTn),
		.CON(is_sign_ex),
		.DI(SIGN_EXTEND_to_SW),
		.DI1(SIGN_EXTEND_to_ready_MUX_ADD_2),
		.DOUT(connect_SIGN_EXTEND_4to_next)
	);
	ADD#(
		.DWIDTH(12)
	) ADD_2(
		.clk(CLK),
		.rstn(RSTn),
		.DI(SIGN_EXTEND_to_ADD),
		.DI1(OUT_PC),
		.DOUT(out_add_2)
	);
	
	MUX #(
		.DWITH(1)
	) Afer_ALU(
		.clk(CLK),
		.rstn(RSTn),
		.CON(isCout),
		.DI(CoutAns),
		.DI1(1'b0),
		.DOUT(back_PC_CON)
	);
	wire [11:0]for_LUI_AUIPC_i;
	wire [31:0]for_LUI_AUIPC_o;
	wire [11:0]imm_12;
	assign imm_12=I_MEM_DI[31:12]<<12;
	ADD#(
		.DWIDTH(12)
	) forLUI_AUI(
		.clk(CLK),
		.rstn(RSTn),
		.DI(imm_12),
		.DI1(OUT_PC),
		.DOUT(for_LUI_AUIPC_i)
	);
	wire [31:0]gan;
	MUX #(
		.DWITH(12)
	) isLUIMUX(
		.clk(CLK),
		.rstn(RSTn),
		.CON(isLUI),
		.DI(for_LUI_AUIPC_i),
		.DI1(imm_12),
		.DOUT(for_LUI_AUIPC_o[11:0])
	);
	MUX #(
		.DWITH(32)
	) MUX_right_MEM(
		.clk(CLK),
		.rstn(RSTn),
		.CON(isLUIAUI),
		.DI(for_LUI_AUIPC_o),
		.DI1(D_MEM_DI),//! wrong
		.DOUT(gan)
	);
	MUX #(
		.DWITH(32)
	) MUX_under_MEM(
		.clk(CLK),
		.rstn(RSTn),
		.CON(issw),
		.DI(ALU_Ans),
		.DI1(gan),
		.DOUT(chos_LUI_JALR)
	);
	// TODO: to end
endmodule //
