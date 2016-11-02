	component system is
		port (
			clk_clk                                          : in  std_logic                    := 'X';             -- clk
			reset_reset_n                                    : in  std_logic                    := 'X';             -- reset_n
			realtimeclock_0_conduit_end_readdata             : out std_logic_vector(3 downto 0);                    -- readdata
			realtimeclock_0_conduit_end_writebyteenable_n    : in  std_logic_vector(3 downto 0) := (others => 'X'); -- writebyteenable_n
			realtimeclock_0_conduit_end_writeresponsevalid_n : out std_logic                                        -- writeresponsevalid_n
		);
	end component system;

	u0 : component system
		port map (
			clk_clk                                          => CONNECTED_TO_clk_clk,                                          --                         clk.clk
			reset_reset_n                                    => CONNECTED_TO_reset_reset_n,                                    --                       reset.reset_n
			realtimeclock_0_conduit_end_readdata             => CONNECTED_TO_realtimeclock_0_conduit_end_readdata,             -- realtimeclock_0_conduit_end.readdata
			realtimeclock_0_conduit_end_writebyteenable_n    => CONNECTED_TO_realtimeclock_0_conduit_end_writebyteenable_n,    --                            .writebyteenable_n
			realtimeclock_0_conduit_end_writeresponsevalid_n => CONNECTED_TO_realtimeclock_0_conduit_end_writeresponsevalid_n  --                            .writeresponsevalid_n
		);

