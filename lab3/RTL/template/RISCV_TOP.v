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
	wire [4:0]ALUOp;
	wire [31:0]chos_LUI_JALR;
	wire ALUSrc;

	CONTROL CONT(
		.I_OP(I_MEM_DI),
		.O_MemtoReg(MemtoReg),
		.O_ALUSrc(ALUSrc),
		.O_RegWrite(RF_WE),
		.O_MemWrite(D_MEM_WEN),
		.O_MemRead(D_MEM_BE[3:0]),
		.O_ALUOp(ALUOp),
		.isnot_PC_4(isnot_PC_4),
		.isJALR(isJALR),
		.isCout(isCout),
		.isJAL(isJAL),
		.is_down_se(is_down_se),
		.isLUI(isLUI),
		.isLUIAUI(isLUIAUI)
	);
	// TODO: control
	assign RF_RA1 = I_MEM_DI[19:15];
	assign RF_RA2 = I_MEM_DI[24:20];
	assign RF_WA1=I_MEM_DI[11:7];
	// TODO:WR

	wire [31:0]PC_4_to_MUX;
	wire [11:0]Back_to_PC;
	wire [11:0]OUT_PC;
	wire [31:0]out_and;
	PC PC_TOP(
		.clk(CLK),
		.rstn(RSTn),
		.I_MEM_ADD(Back_to_PC),
		.O_MEM_ADD(OUT_PC),
		.I_MEM_CSN(I_MEM_CSN),
		.D_MEM_CSN(D_MEM_CSN),
		.PC_4_to_MUX(PC_4_to_MUX)
	);
	always @(*) begin
		I_MEM_ADDR=OUT_PC;
	end
	//TODO backTOPC connect with outPC
	wire [31:0]SIGN_EXTEND_to_MUX_ADD;
	wire [31:0]MUX_TO_ALU;
	MUX #(
		.DWITH(32)
	) BeforeALU(
		.CON(ALUSrc),
		.DI(RF_RD2),
		.DI1(SIGN_EXTEND_to_MUX_ADD),
		.DOUT(MUX_TO_ALU)//!ALU out
	);
	wire [31:0]ALU_Ans;
	wire CoutAns;
	ALU alu(
		.A(RF_RD1),
		.B(MUX_TO_ALU),
		.OP(ALUOp),
		.C(ALU_Ans),
		.Cout(CoutAns)
	);
	wire [31:0]SIGN_EXTEND_to_ready_MUX_ADD_0;
	SIGN_EXTEND #(
		.I_DWIDTH(12),
		.O_DWIDTH(32)
	) Down_REG(
		.I_DI(I_MEM_DI[31:20]),
		.O_DI(SIGN_EXTEND_to_ready_MUX_ADD_0)
	);
	wire [31:0]SIGN_EXTEND_to_ready_MUX_ADD_1;
	SIGN_EXTEND#(
		.I_DWIDTH(20),
		.O_DWIDTH(32)
	)Down_Down_REG(
		.I_DI(I_MEM_DI[31:12]),
		.O_DI(SIGN_EXTEND_to_ready_MUX_ADD_1)
	);
	MUX #(
		.DWITH(32)
	)After_Down_REG(
		.CON(is_down_se),
		.DI(SIGN_EXTEND_to_ready_MUX_ADD_1),
		.DI1(SIGN_EXTEND_to_ready_MUX_ADD_0),
		.DOUT(SIGN_EXTEND_to_MUX_ADD)
	);
	assign D_MEM_ADDR=ALU_Ans;
	assign D_MEM_DOUT=RF_RA2;
	wire [31:0] MUX_to_MUX;
	MUX #(
		.DWITH(32)//! may not 32
	)MUX_Down_MEM(
		.CON(MemtoReg),
		.DI(ALU_Ans),
		.DI1(chos_LUI_JALR),
		.DOUT(MUX_to_MUX)
	);
	wire [31:0]pc_4temp;
	ADD #(
		.DWIDTH(32)
	) PC_4(
		.clk(CLK),
		.rstn(RSTn),
		.DI({20'b0,OUT_PC}),
		.DI1(32'b0100),
		.DOUT(pc_4temp)
	);
	assign PC_4_to_MUX[11:0]=pc_4temp;
	MUX #(
		.DWITH(32)
	) MUX_Left_WD(
		.CON(isJAL),//!warning  may change name
		.DI(PC_4_to_MUX),
		.DI1(MUX_to_MUX),
		.DOUT(RF_WD)
	);

	wire [11:0]Out_ADD;
	ADD #(
		.DWIDTH(12)
	) Up_reg_right(
		.DI(OUT_PC),
		.DI1(SIGN_EXTEND_to_MUX_ADD[11:0]),
		.DOUT(Out_ADD)
	);

	assign out_and=ALU_Ans^8'hfffffffe;
	wire [11:0]out_mux_to_mux;
	MUX#(
		.DWITH(12)
	) Behind_ADD(
		.CON(isJALR),
		.DI(out_and[11:0]),
		.DI1(Out_ADD),
		.DOUT(out_mux_to_mux)
	);
	wire [11:0]backPC1;
	MUX#(
		.DWITH(12)
	)MUXtoMUX(
		.CON(isnot_PC_4),
		.DI(out_mux_to_mux),
		.DI1(PC_4_to_MUX[11:0]),
		.DOUT(backPC1)
	);

	wire [11:0]out_add_2;
	MUX #(
		.DWITH(12)
	) Jumpcheck(
		.CON(),
		.DI(out_add_2),
		.DI1(backPC1),
		.DOUT(Back_to_PC)
	);

	wire [11:0]SIGN_EXTEND_to_ADD;
	SIGN_EXTEND#(
		.I_DWIDTH(7),
		.O_DWIDTH(12)
	)SIGN_EXTEND_to_add(
		.I_DI(I_MEM_DI[31:25]),
		.O_DI(SIGN_EXTEND_to_ADD)
	);
	ADD#(
		.DWIDTH(12)
	) ADD_2(
		.DI(SIGN_EXTEND_to_ADD),
		.DI1(OUT_PC),
		.DOUT(out_add_2)
	);
	MUX #(
		.DWITH(12)
	)MUX_behind_PC(
		.CON(back_PC_CON),
		.DI(backPC1),
		.DI1(out_add_2),
		.DOUT(Back_to_PC)
	);
	
	MUX #(
		.DWITH(1)
	) Afer_ALU(
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
		.DI(imm_12),
		.DI1(OUT_PC),
		.DOUT(for_LUI_AUIPC_i)
	);

	MUX #(
		.DWITH(12)
	) isLUIMUX(
		.CON(isLUI),
		.DI(imm_12),
		.DI1(for_LUI_AUIPC_i),
		.DOUT(for_LUI_AUIPC_o[11:0])
	);
	MUX #(
		.DWITH(32)
	) MUX_right_MEM(
		.CON(isLUIAUI),
		.DI(for_LUI_AUIPC_o),
		.DI1(D_MEM_DI),//! wrong
		.DOUT(chos_LUI_JALR)
	);
	
	// TODO: to end
endmodule //
