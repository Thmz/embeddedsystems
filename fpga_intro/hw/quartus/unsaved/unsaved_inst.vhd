	component unsaved is
		port (
			clk_clk                            : in    std_logic                    := 'X';             -- clk
			reset_reset_n                      : in    std_logic                    := 'X';             -- reset_n
			parallelport2_0_conduit_end_export : inout std_logic_vector(7 downto 0) := (others => 'X'); -- export
			parallelport2_1_conduit_end_export : inout std_logic_vector(7 downto 0) := (others => 'X')  -- export
		);
	end component unsaved;

	u0 : component unsaved
		port map (
			clk_clk                            => CONNECTED_TO_clk_clk,                            --                         clk.clk
			reset_reset_n                      => CONNECTED_TO_reset_reset_n,                      --                       reset.reset_n
			parallelport2_0_conduit_end_export => CONNECTED_TO_parallelport2_0_conduit_end_export, -- parallelport2_0_conduit_end.export
			parallelport2_1_conduit_end_export => CONNECTED_TO_parallelport2_1_conduit_end_export  -- parallelport2_1_conduit_end.export
		);

