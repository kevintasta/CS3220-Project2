module Controller(instr, cond_flag, imm, src1_sel, src2_sel, wr_sel, pc_mux_sel, reg_data_in_mux, alu_src2_sel, alu_op, reg_wr_en, data_wr_en);
	//ALU opcodes
	parameter ADD = 5'b00000, SUB = 5'b00001, AND = 5'b00010, OR = 5'b00011, XOR = 5'b00100, NAND = 5'b00101, NOR = 5'b00110, XNOR = 5'b00111;
	parameter MVHI = 5'b01000, F = 5'b01001, EQ = 5'b01010, LT = 5'b01011, LTE = 5'b01100, T = 5'b01101, NE = 5'b01110, GTE = 5'b01111, GT = 5'b10000;
	parameter BEQZ = 5'b10001, BLTZ = 5'b10010, BLTEZ = 5'b10011, BNEZ = 5'b10100, BGTEZ = 5'b10101, BGTZ = 5'b10110;
	
	
	
	parameter width = 32, aluop_width = 5, imm_width = 16;
	input[width - 1:0]instr;
	input cond_flag;
	output reg [3:0] src1_sel, src2_sel, wr_sel;
	output reg [aluop_width - 1:0] alu_op;
	output reg [1:0] pc_mux_sel, reg_data_in_mux, alu_src2_sel;
	output reg reg_wr_en, data_wr_en;
	output reg [imm_width - 1:0] imm;
	
	always @(*) begin
		case(instr[31:28])
			//alu-r
			4'b1100: begin
				pc_mux_sel = 2'b00;
				reg_data_in_mux = 2'b00;
				reg_wr_en = 1'b1;
				alu_src2_sel = 2'b00;
				data_wr_en = 1'b0;
				imm = 16'd0;
				
				//Sets registers
				wr_sel = instr[23:20];
				src1_sel = instr[19:16];
				src2_sel = instr[15:12];
				
				
				case(instr[27:23]) begin
					//ADD
					4'b0111: begin
						alu_op = ADD;
					end
					//SUB
					4'b0110: begin
						alu_op = SUB;
					end
					//AND
					4'b0000: begin
						alu_op = AND;
					end
					//OR
					4'b0001: begin
						alu_op = OR;
					end
					//XOR
					4'b0010: begin
						alu_op = XOR;
					end
					//NAND
					4'b1000: begin
						alu_op = NAND;
					end
					//NOR
					4'b1001: begin
						alu_op = NOR;
					end
					//XNOR
					4'b1010: begin
						alu_op = XNOR;
					end
					default: begin
						alu_op = ADD;
					end
				endcase			
			end
			
			//cmp-r
			4'b1101: begin
				pc_mux_sel = 2'b00;
				reg_data_in_mux = 2'b00;
				reg_wr_en = 1'b1;
				alu_src2_sel = 2'b00;
				data_wr_en = 1'b0;
				imm = 16'd0;
				
				//Sets registers
				wr_sel = instr[23:20];
				src1_sel = instr[19:16];
				src2_sel = instr[15:12];
				
				case(instr[27:23]) begin
					//F
					4'b0011: begin
						alu_op = F;
					end
					//EQ
					4'b0110: begin
						alu_op = EQ;
					end
					//LT
					4'1001: begin
						alu_op = LT;
					end
					//LTE
					4'b1100: begin
						alu_op = LTE;
					end
					//T
					4'b0000: begin
						alu_op = T;
					end
					//NE
					4'b0101: begin
						alu_op = NE;
					end
					//GTE
					4'b1010: begin
						alu_op = GTE;
					end
					//GT
					4'b1111: begin
						alu_op = GT;
					end
					default: begin
						alu_op = ADD;
					end
				endcase
			end
			
			//store
			4'b0011: begin
				pc_mux_sel = 2'b00;
				reg_data_in_mux = 2'b00;
				reg_wr_en = 1'b0;
				alu_src2_sel = 2'b01;
				data_wr_en = 1'b1;
				imm = instr[15:0];
				alu_op = ADD;
				
				//Sets registers
				wr_sel = 4'b0000;
				src1_sel = instr[23:20];
				src2_sel = instr[19:16];
			end
			
			//load
			4'b0111: begin
				pc_mux_sel = 2'b00;
				reg_data_in_mux = 2'b01;
				reg_wr_en = 1'b1;
				alu_src2_sel = 2'b01;
				data_wr_en = 1'b0;
				imm = instr[15:0];
				alu_op = ADD;
				
				//Sets registers
				wr_sel = instr[23:20];
				src1_sel = instr[19:16];
				src2_sel = 4'b0000;
			end
			
			//alu-i
			4'b0100: begin
				pc_mux_sel = 2'b00;
				reg_data_in_mux = 2'b00;
				reg_wr_en = 1'b1;
				alu_src2_sel = 2'b01;
				data_wr_en = 1'b0;
				imm = instr[15:0];
				
				//Sets registers
				wr_sel = instr[23:20];
				src1_sel = instr[19:16];
				src2_sel = 4'b0000;
				
				
				case(instr[27:23]) begin
					//ADDI
					4'b0111: begin
						alu_op = ADD;
					end
					//SUBI
					4'b0110: begin
						alu_op = SUB;
					end
					//ANDI
					4'b0000: begin
						alu_op = AND;
					end
					//ORI
					4'b0001: begin
						alu_op = OR;
					end
					//XORI
					4'b0010: begin
						alu_op = XOR;
					end
					//NANDI
					4'b1000: begin
						alu_op = NAND;
					end
					//NORI
					4'b1001: begin
						alu_op = NOR;
					end
					//XNORI
					4'b1010: begin
						alu_op = XNOR;
					end
					//MVHI
					4'b1111: begin
						alu_op = MVHI;
					end
					default: begin
						alu_op = ADD;
					end
				endcase
			end
		endcase
	end
endmodule