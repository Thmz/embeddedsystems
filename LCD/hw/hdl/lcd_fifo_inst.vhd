lcd_fifo_inst : lcd_fifo PORT MAP (
		clock	 => clock_sig,
		data	 => data_sig,
		rdreq	 => rdreq_sig,
		wrreq	 => wrreq_sig,
		almost_full	 => almost_full_sig,
		empty	 => empty_sig,
		full	 => full_sig,
		q	 => q_sig
	);
