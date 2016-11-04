
module system (
	clk_clk,
	realtimeclock_0_conduit_end_export,
	realtimeclock_0_conduit_end_1_export,
	realtimeclock_0_conduit_end_2_export,
	realtimeclock_0_conduit_end_3_export,
	realtimeclock_0_conduit_end_4_export,
	realtimeclock_0_conduit_end_5_export,
	reset_reset_n);	

	input		clk_clk;
	output	[3:0]	realtimeclock_0_conduit_end_export;
	output		realtimeclock_0_conduit_end_1_export;
	output	[7:0]	realtimeclock_0_conduit_end_2_export;
	input	[7:0]	realtimeclock_0_conduit_end_3_export;
	input	[3:0]	realtimeclock_0_conduit_end_4_export;
	output	[5:0]	realtimeclock_0_conduit_end_5_export;
	input		reset_reset_n;
endmodule
