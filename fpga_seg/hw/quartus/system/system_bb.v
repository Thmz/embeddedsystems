
module system (
	clk_clk,
	reset_reset_n,
	realtimeclock_0_conduit_end_readdata,
	realtimeclock_0_conduit_end_writebyteenable_n,
	realtimeclock_0_conduit_end_writeresponsevalid_n);	

	input		clk_clk;
	input		reset_reset_n;
	output	[3:0]	realtimeclock_0_conduit_end_readdata;
	input	[3:0]	realtimeclock_0_conduit_end_writebyteenable_n;
	output		realtimeclock_0_conduit_end_writeresponsevalid_n;
endmodule
