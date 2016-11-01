module ALU(in1, in2, control, out, compare);
	parameter ADD = 5'b00000, SUB = 5'b00001, AND = 5'b00010, OR = 5'b00011, XOR = 5'b00100, NAND = 5'b00101, NOR = 5'b00110, XNOR = 5'b00111;
	parameter MVHI = 5'b01000, F = 5'b01001, EQ = 5'b01010, LT = 5'b01011, LTE = 5'b01100, T = 5'b01101, NE = 5'b01110, GTE = 5'b01111, GT = 5'b10000;
	parameter BEQZ = 5'b10001, BLTZ = 5'b10010, BLTEZ = 5'b10011, BNEZ = 5'b10100, BGTEZ = 5'b10101, BGTZ = 5'b10110;
	parameter data_width = 32;
	input[4:0] control;
	input[data_width - 1:0] in1, in2;
	output[data_width - 1:0] out;
	output compare;
	reg[data_width - 1:0] calc;
	reg compcalc = 1'b0;
	
	always @(*) begin
		case (control)
			ADD: begin
				calc = in1 + in2;
			end
			SUB: begin
				calc = in1 - in2;
			end
			AND: begin
				calc = in1 & in2;
			end
			OR: begin
				calc = in1 | in2;
			end
			XOR: begin
				calc = in1 ^ in2;
			end
			NAND: begin
				calc = ~(in1 & in2);
			end
			NOR: begin
				calc = ~(in1 | in2);
			end
			XNOR: begin
				calc = ~(in1 ^ in2);
			end
			MVHI: begin
				calc = ((in1 & 32'h0000FFFF) << 16);
			end
			F: begin
				calc = 32'd0;
				compcalc = 1'b0;
			end
			EQ: begin
				if (in1 == in2) begin
					calc = 32'd1;
					compcalc = 1'b1;
				end else begin
					calc = 32'd0;
					compcalc = 1'b0;
				end
			end
			LT: begin
				if (in1 < in2) begin
					calc = 32'd1;
					compcalc = 1'b1;
				end else begin
					calc = 32'd0;
					compcalc = 1'b0;
				end
			end
			LTE: begin
				if (in1 <= in2) begin
					calc = 32'd1;
					compcalc = 1'b1;
				end else begin
					calc = 32'd0;
					compcalc = 1'b0;
				end
			end
			T: begin
				calc = 32'd0;
				compcalc = 1'b0;
			end
			NE: begin
				if (in1 != in2) begin
					calc = 32'd1;
					compcalc = 1'b1;
				end else begin
					calc = 32'd0;
					compcalc = 1'b0;
				end
			end
			GTE: begin
				if (in1 >= in2) begin
					calc = 32'd1;
					compcalc = 1'b1;
				end else begin
					calc = 32'd0;
					compcalc = 1'b0;
				end
			end
			GT: begin
				if (in1 > in2) begin
					calc = 32'd1;
					compcalc = 1'b1;
				end else begin
					calc = 32'd0;
					compcalc = 1'b0;
				end
			end
			BEQZ: begin
				calc = 32'd0;
				if (in1 == 32'd0) begin
					compcalc = 1'b1;
				end else begin
					compcalc = 1'b0;
				end
			end
			BLTZ: begin
				calc = 32'd0;
				if (in1[31] == 1'b1) begin
					compcalc = 1'b1;
				end else begin
					compcalc = 1'b0;
				end
			end
			BLTEZ: begin
				calc = 32'd0;
				if (in1[31] == 1'b1 || in1 == 32'd0) begin
					compcalc = 1'b1;
				end else begin
					compcalc = 1'b0;
				end
			end
			BNEZ: begin
				calc = 32'd0;
				if (in1 != 32'd0) begin
					compcalc = 1'b1;
				end else begin
					compcalc = 1'b0;
				end
			end
			BGTEZ: begin
				calc = 32'd0;
				if (in1[31] == 1'b0 || in1 == 32'd0) begin
					compcalc = 1'b1;
				end else begin
					compcalc = 1'b0;
				end
			end
			BGTZ: begin
				calc = 32'd0;
				if (in1[31] == 1'b0) begin
					compcalc = 1'b1;
				end else begin
					compcalc = 1'b0;
				end
			end
			default: begin
				calc = 32'd0;
				compcalc = 1'b0;
			end
		endcase
	end
	assign out = calc;
	assign compare = compcalc;
endmodule