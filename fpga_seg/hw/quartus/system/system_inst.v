	system u0 (
		.clk_clk                                          (<connected-to-clk_clk>),                                          //                         clk.clk
		.reset_reset_n                                    (<connected-to-reset_reset_n>),                                    //                       reset.reset_n
		.realtimeclock_0_conduit_end_readdata             (<connected-to-realtimeclock_0_conduit_end_readdata>),             // realtimeclock_0_conduit_end.readdata
		.realtimeclock_0_conduit_end_writebyteenable_n    (<connected-to-realtimeclock_0_conduit_end_writebyteenable_n>),    //                            .writebyteenable_n
		.realtimeclock_0_conduit_end_writeresponsevalid_n (<connected-to-realtimeclock_0_conduit_end_writeresponsevalid_n>)  //                            .writeresponsevalid_n
	);

