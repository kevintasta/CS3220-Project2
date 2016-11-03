`timescale 1ns / 1ps
module TestController();
	parameter width = 32, aluop_width = 5, imm_width = 16;
	reg[width - 1:0]instr;
	wire[3:0] src1_sel, src2_sel, wr_sel;
	wire[aluop_width - 1:0] alu_op;
	wire[1:0] pc_mux_sel, reg_data_in_mux, alu_src2_sel;
	wire reg_wr_en, data_wr_en;
	wire[imm_width - 1:0] imm;

	Controller control(instr, imm, src1_sel, src2_sel, wr_sel, pc_mux_sel, reg_data_in_mux, alu_src2_sel, alu_op, reg_wr_en, data_wr_en);
	initial begin
		//JAL T0,JALTARG(FP)
		instr = 32'h604d00a0;
		#10;
		//ADDI T0,FP,-1
		instr = 32'h474dffff;
		#10;
		//ADDI T1,FP,2
		instr = 32'h475d0002;
		#10;
		//ADDI A0,FP,1
		instr = 32'h470d0001;
		#10;
		//ADD A1,T0,T1
		instr = 32'hc7145000;
		#10;
		//BEQ A0,A1,ADDWORKS
		instr = 32'h26010004;
		#10;
		$stop;
	end
endmodule