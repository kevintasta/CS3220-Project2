module ClockDivider (
	clk_in,
	clk_out,
	locked);

	output	  locked; // clock is paused when locked is 1

  // Implement this yourself
  // Slow down the clock to ensure the cycle is long enough for all operations to execute
  // If you don't, you might get weird errors
	input clk_in;
	output clk_out;
	parameter counter = 25000000;
	reg[26:0] clk_count;
	reg clk = 0;
	always @ (posedge clk_in) begin
		if (clk_count == counter) begin
			clk <= ~clk;
			clk_count <= 0;
		end
		else begin
			clk_count <= clk_count + 1;
		end
	end
	assign clk_out = clk;

endmodule
