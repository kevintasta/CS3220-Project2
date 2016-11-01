module Multiplexer(src0, src1, src2, sel, out);
	parameter width = 32;
	input[width - 1:0] src0, src1, src2;
	input[1:0] sel;
	output reg[width-1:0] out;
	always @(*) begin
		case(sel)
			2'b00: begin
				out = src0;
			end
			2'b01: begin
				out = src1;
			end
			2'b10: begin
				out = src2;
			end
			default: begin
				out = src0;
			end
		endcase
	end
endmodule