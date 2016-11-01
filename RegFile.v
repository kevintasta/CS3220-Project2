module RegFile(src1_sel, src2_sel, wr_sel, data_in, wr_en, clk, src1_out, src2_out);
	parameter index = 4, width = 32, regnumer = (1 << index);
	input wr_en, clk;
	input[3:0] src1_sel, src2_sel, wr_sel;
	input[width - 1:0] data_in; 
	output[width - 1:0] src1_out, src2_out;
	reg[width-1:0] data [0:regnumer];
	
	always @ (posedge clk) begin
		if (wr_en == 1'b1) begin
			data[wr_sel] <= data_in;
		end
	end		
	assign src1_out = data[src1_sel];
	assign src2_out = data[src2_sel];
endmodule