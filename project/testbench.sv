/* TLC - TESTBENCH
	AUSTIN H. DIAL
	MAY 08/2020

	Testing the traffic light controller design module.
	This testbench iterates through

*/
`timescale 1 ns/10 ps

module testbench;

	// Define local test signals
	logic sen1, sen2,
		clk, reset,
		red1, yellow1, green1,
		red2, yellow2, green2;

	// Instantiate the unit under test
	localparam T = 20;
	tlc uut (
		.sen1(sen1), .sen2(sen2),
		.clk(clk), .reset(reset),
		.red1(red1), .yellow1(yellow1), .green1(green1),
		.red2(red2), .yellow2(yellow2), .green2(green2)
	);

	// Divide clock manually
	always
	 begin
		 clk = 1;
			#(T/2);
			clk = 0;
			#(T/2);
		end

	// Handle reset
	initial
		begin
			reset = 1;
			#(T/2);
			reset = 0;
			#(T/2);
		end

	// Run testing
	initial
		begin

			$dumpfile("ece482_tlc.vcd"); $dumpvars;

          // Standard states
			sen1 = 0;
			sen2 = 0;
			#(T*5);

			sen1 = 1;
			sen2 = 0;
			#(T*5);

			sen1 = 0;
			sen2 = 1;
			#(T*5);

			sen1 = 1;
			sen2 = 1;
			#(T*5);

          // Additional testing states (out of order)

			sen1 = 0;
			sen2 = 0;
			#(T*5);

			sen1 = 1;
			sen2 = 0;
			#(T*5)

		 $finish;
		end
endmodule