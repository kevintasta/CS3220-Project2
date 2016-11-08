`timescale 1ns / 1ps
module TestALU();
	parameter ADD = 5'b00000, SUB = 5'b00001, AND = 5'b00010, OR = 5'b00011, XOR = 5'b00100, NAND = 5'b00101, NOR = 5'b00110, XNOR = 5'b00111;
	parameter MVHI = 5'b01000, F = 5'b01001, EQ = 5'b01010, LT = 5'b01011, LTE = 5'b01100, T = 5'b01101, NE = 5'b01110, GTE = 5'b01111, GT = 5'b10000;
	parameter BEQZ = 5'b10001, BLTZ = 5'b10010, BLTEZ = 5'b10011, BNEZ = 5'b10100, BGTEZ = 5'b10101, BGTZ = 5'b10110;
	reg[31:0] A, B;
	reg[4:0] opCode;
	wire[31:0] out;
	wire compare;
	ALU testerALU (A, B, opCode, out, compare);
	initial begin
		A = -32'd8;
		B = 32'd8;

		opCode = ADD;
		#10;
		opCode = SUB;
		#10;
		opCode = AND;
		#10;
		opCode = OR;
		#10;
		opCode = XOR;
		#10;
		opCode = NAND;
		#10;
		opCode = NOR;
		#10;
		opCode = XNOR;
		#10;
		opCode = MVHI;
		#10;
		
		// F ---------------
		#10;
		// A > B
		A = 32'd8;
		B = -32'd8;
		opCode = F;
		
		#10;
		// A == B
		A = 32'd8;
		B = 32'd8;
		opCode = F;
		
		#10;
		// A < B
		A = -32'd8;
		B = 32'd8;
		opCode = F;
		
		// EQ ---------------
		#10;
		// A > B
		A = 32'd8;
		B = -32'd8;
		opCode = EQ;
		
		#10;
		// A == B
		A = 32'd8;
		B = 32'd8;
		opCode = EQ;
		
		#10;
		// A < B
		A = -32'd8;
		B = 32'd8;
		opCode = EQ;
		
		// LT ---------------
		#10;
		// A > B
		A = 32'd8;
		B = -32'd8;
		opCode = LT;
		
		#10;
		// A == B
		A = 32'd8;
		B = 32'd8;
		opCode = LT;
		
		#10;
		// A < B
		A = -32'd8;
		B = 32'd8;
		opCode = LT;
		
		// LTE ---------------
		#10;
		// A > B
		A = 32'd8;
		B = -32'd8;
		opCode = LTE;
		
		#10;
		// A == B
		A = 32'd8;
		B = 32'd8;
		opCode = LTE;
		
		#10;
		// A < B
		A = -32'd8;
		B = 32'd8;
		opCode = LTE;
		
		// T ---------------
		#10;
		// A > B
		A = 32'd8;
		B = -32'd8;
		opCode = T;
		
		#10;
		// A == B
		A = 32'd8;
		B = 32'd8;
		opCode = T;
		
		#10;
		// A < B
		A = -32'd8;
		B = 32'd8;
		opCode = T;
		
		// NE ---------------
		#10;
		// A < B
		A = -32'd8;
		B = 32'd8;
		opCode = NE;
		
		#10;
		// A == B
		A = 32'd8;
		B = 32'd8;
		opCode = NE;
		
		#10;
		// A > B
		A = 32'd8;
		B = -32'd8;
		opCode = NE;
		
		// GTE ---------------
		#10;
		// A > B
		A = 32'd8;
		B = -32'd8;
		opCode = GTE;
		
		#10;
		// A == B
		A = 32'd8;
		B = 32'd8;
		opCode = GTE;
		
		#10;
		// A < B
		A = -32'd8;
		B = 32'd8;
		opCode = GTE;
		
		// GT ---------------
		#10;
		// A > B
		A = 32'd8;
		B = -32'd8;
		opCode = GT;
		
		#10;
		// A == B
		A = 32'd8;
		B = 32'd8;
		opCode = GT;
		
		#10;
		// A < B
		A = -32'd8;
		B = 32'd8;
		opCode = GT;
		
		// BEQZ ---------------
		#10;
		// A > B
		A = 32'd8;
		B = -32'd8;
		opCode = BEQZ;
		
		#10;
		// A == B
		A = 32'd8;
		B = 32'd8;
		opCode = BEQZ;
		
		#10;
		// A < B
		A = -32'd8;
		B = 32'd8;
		opCode = BEQZ;
		
		// BLTZ ---------------
		#10;
		// A > B
		A = 32'd8;
		B = -32'd8;
		opCode = BLTZ;
		
		#10;
		// A == B
		A = 32'd8;
		B = 32'd8;
		opCode = BLTZ;
		
		#10;
		// A < B
		A = -32'd8;
		B = 32'd8;
		opCode = BLTZ;
		
		// BLTEZ ---------------
		#10;
		// A > B
		A = 32'd8;
		B = -32'd8;
		opCode = BLTEZ;
		
		#10;
		// A == B
		A = 32'd8;
		B = 32'd8;
		opCode = BLTEZ;
		
		#10;
		// A < B
		A = -32'd8;
		B = 32'd8;
		opCode = BLTEZ;
		
		// BNEZ ---------------
		#10;
		// A > B
		A = 32'd8;
		B = -32'd8;
		opCode = BNEZ;
		
		#10;
		// A == B
		A = 32'd8;
		B = 32'd8;
		opCode = BNEZ;
		
		#10;
		// A < B
		A = -32'd8;
		B = 32'd8;
		opCode = BNEZ;
		
		// BGTEZ ---------------
		#10;
		// A > B
		A = 32'd8;
		B = -32'd8;
		opCode = BGTEZ;
		
		#10;
		// A == B
		A = 32'd8;
		B = 32'd8;
		opCode = BGTEZ;
		
		#10;
		// A < B
		A = -32'd8;
		B = 32'd8;
		opCode = BGTEZ;
		
		// BGTZ ---------------
		#10;
		// A > B
		A = 32'd8;
		B = -32'd8;
		opCode = BGTZ;
		
		#10;
		// A == B
		A = 32'd8;
		B = 32'd8;
		opCode = BGTZ;
		
		#10;
		// A < B
		A = -32'd8;
		B = 32'd8;
		opCode = BGTZ;
		
		#10;
		$stop;
	end
endmodule