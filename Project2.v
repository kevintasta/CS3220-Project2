module Project2(SW,KEY,LEDR,HEX0,HEX1,HEX2,HEX3,CLOCK_50);
  input  [9:0] SW;
  input  [3:0] KEY;
  input  CLOCK_50;
  output [9:0] LEDR;
  output [6:0] HEX0,HEX1,HEX2,HEX3;
 
  parameter width = 32, aluop_width = 5, imm_width = 16;
  parameter DBITS         				 = 32;
  parameter INST_SIZE      			 = 32'd4;
  parameter INST_BIT_WIDTH				 = 32;
  parameter START_PC       			 = 32'h40;
  parameter REG_INDEX_BIT_WIDTH 		 = 4;
  parameter ADDR_KEY  					 = 32'hF0000010;
  parameter ADDR_SW   					 = 32'hF0000014;
  parameter ADDR_HEX  					 = 32'hF0000000;
  parameter ADDR_LEDR 					 = 32'hF0000004;
  
  parameter IMEM_INIT_FILE				 = "Sorter2.mif";
  parameter IMEM_ADDR_BIT_WIDTH 		 = 11;
  parameter IMEM_DATA_BIT_WIDTH 		 = INST_BIT_WIDTH;
  parameter IMEM_PC_BITS_HI     		 = IMEM_ADDR_BIT_WIDTH + 2;
  parameter IMEM_PC_BITS_LO     		 = 2;
  
  parameter DMEMADDRBITS 				 = 13;
  parameter DMEMWORDBITS				 = 2;
  parameter DMEMWORDS					 = 2048;
  
  parameter OP1_ALUR 					 = 4'b0000;
  parameter OP1_ALUI 					 = 4'b1000;
  parameter OP1_CMPR 					 = 4'b0010;
  parameter OP1_CMPI 					 = 4'b1010;
  parameter OP1_BCOND					 = 4'b0110;
  parameter OP1_SW   					 = 4'b0101;
  parameter OP1_LW   					 = 4'b1001;
  parameter OP1_JAL  					 = 4'b1011;
  
  // Add and modify parameters for various opcode and function code values
  wire clk;
  ClockDivider	clk_divider (CLOCK_50, clk, lock);
  assign LEDR[0] = clk;
  wire reset = ~lock;
  // Create PC and its logic
  wire pcWrtEn = 1'b1;
  wire[DBITS - 1: 0] pcIn; // Implement the logic that generates pcIn; you may change pcIn to reg if necessary
  wire[DBITS - 1: 0] pcOut;
  // This PC instantiation is your starting point
  //Register #(.BIT_WIDTH(DBITS), .RESET_VALUE(START_PC)) pc (clk, reset, pcWrtEn, pcIn, pcOut);
  Register pc (clk, reset, pcWrtEn, pcIn, pcOut);

  // Creat instruction memeory
  wire[IMEM_DATA_BIT_WIDTH - 1: 0] instWord;
  //InstMemory #(IMEM_INIT_FILE, IMEM_ADDR_BIT_WIDTH, IMEM_DATA_BIT_WIDTH) instMem (pcOut[IMEM_PC_BITS_HI - 1: IMEM_PC_BITS_LO], instWord);
  InstMemory instMem (pcOut[IMEM_PC_BITS_HI - 1: IMEM_PC_BITS_LO], instWord);
  
  // Define all wires here
  // PC Mux wires
  wire[DBITS - 1:0] pcmux_out;

  // PC increment adder wires
  wire[DBITS - 1:0] pcadder_out, pcadder_src1 = 32'd4;

  // Branch picker wires
  wire[DBITS - 1:0] brpick_out;

  // Branch adder wires
  wire[DBITS - 1:0] bradder_out;

  // Shifter wires
  wire[DBITS - 1:0] shift_out;

  // Register data in mux wires
  wire[DBITS - 1:0] regmux_out;

  // Sext wires
  wire[DBITS - 1:0] sext_out;

  // Alu mux wires
  wire[DBITS - 1:0] alumux_out;
  
  // Register file wires
  wire[DBITS - 1:0] regfile_src1_out, regfile_src2_out;
  
  // ALU wires
  wire[DBITS - 1:0] alu_out;
  wire alu_compare;

  //Data memory wires
  wire[DBITS - 1:0] d_out;

  // Put the code for getting opcode1, rd, rs, rt, imm, etc. here 
  
	wire[3:0] src1_sel, src2_sel, wr_sel;
	wire[aluop_width - 1:0] alu_op;
	wire[1:0] pc_mux_sel, reg_data_in_mux, alu_src2_sel;
	wire reg_wr_en, data_wr_en;
	wire[imm_width - 1:0] imm;

  Controller control(instWord, imm, src1_sel, src2_sel, wr_sel, pc_mux_sel, reg_data_in_mux, alu_src2_sel, alu_op, reg_wr_en, data_wr_en);

  // Create all of the multiplexers
  Multiplexer alumux(regfile_src2_out, sext_out, shift_out, alu_src2_sel, alumux_out);
  Multiplexer regmux(alu_out, d_out, pcadder_out, reg_data_in_mux, regmux_out);
  Multiplexer pcmux(pcadder_out, brpick_out, alu_out, pc_mux_sel, pcIn);

  // Create all of the adders
  Adder pcadder(pcadder_src1, pcOut, pcadder_out);
  Adder bradder(shift_out, pcadder_out, bradder_out);

  // Create the branch picker
  BranchPicker brpick(pcadder_out, bradder_out, alu_compare, brpick_out);

  // Create the left shift_in
  LeftShift lshift(sext_out, shift_out);

  // Create the sign extender
  SignExtension sext(imm, sext_out);

  // Create the registers
  RegFile registerFile(src1_sel, src2_sel, wr_sel, regmux_out, reg_wr_en, clk, regfile_src1_out, regfile_src2_out);
  
  // Create ALU unit
  ALU mainALU(regfile_src1_out, regmux_out, alu_op, alu_out, alu_compare);

  // Put the code for data memory and I/O here
  wire[15:0] hex;
  wire[9:0] test;
  DataMemory(clk, data_wr_en, alu_out, regfile_src2_out, SW, KEY, test, hex, d_out);
  hex2_7seg(pcadder_out[3:0], HEX0);
  hex2_7seg(pcadder_out[7:4], HEX1);
  hex2_7seg(pcadder_out[11:8], HEX2);
  hex2_7seg(pcadder_out[15:12], HEX3);
  // KEYS, SWITCHES, HEXS, and LEDS are memeory mapped IO
    
endmodule

