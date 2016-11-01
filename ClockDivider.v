module ClockDivider (
	inclk0,
	c0,
	locked);

	input	  inclk0;
	output	  c0;
	output	  locked; // clock is paused when locked is 1

  // Implement this yourself
  // Slow down the clock to ensure the cycle is long enough for all operations to execute
  // If you don't, you might get weird errors
  parameter count = 25000000;
  parameter width = 32;
  reg[width - 1: 0] counter = 0;
  parameter divider = 25000000;
  reg clkCount = 0;
  assign clkOut = clkCount;
  always @(posedge inclk0) begin
		if (locked == 1'b0) begin
			counter <= counter + 1;
		end
		if (counter == divider) begin
			clkCount <= ~clkCount;
			counter <= 0;
		end
	end

endmodule
