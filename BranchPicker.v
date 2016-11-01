module BranchPicker(src0, src1, sel, out);
	parameter width = 32;
	input[width - 1:0] src0, src1;
	input sel;
	output reg [width - 1:0] out;
	always @(*) begin
		if (sel == 1'b0) begin
			out = src0;
		end
		else if (sel == 1'b1) begin
			out = src1;
		end
	end
endmodule