	component system is
		port (
			clk_clk                              : in  std_logic                    := 'X';             -- clk
			realtimeclock_0_conduit_end_export   : out std_logic_vector(3 downto 0);                    -- export
			realtimeclock_0_conduit_end_1_export : out std_logic;                                       -- export
			realtimeclock_0_conduit_end_2_export : out std_logic_vector(7 downto 0);                    -- export
			realtimeclock_0_conduit_end_3_export : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			realtimeclock_0_conduit_end_4_export : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			realtimeclock_0_conduit_end_5_export : out std_logic_vector(5 downto 0);                    -- export
			reset_reset_n                        : in  std_logic                    := 'X'              -- reset_n
		);
	end component system;

	u0 : component system
		port map (
			clk_clk                              => CONNECTED_TO_clk_clk,                              --                           clk.clk
			realtimeclock_0_conduit_end_export   => CONNECTED_TO_realtimeclock_0_conduit_end_export,   --   realtimeclock_0_conduit_end.export
			realtimeclock_0_conduit_end_1_export => CONNECTED_TO_realtimeclock_0_conduit_end_1_export, -- realtimeclock_0_conduit_end_1.export
			realtimeclock_0_conduit_end_2_export => CONNECTED_TO_realtimeclock_0_conduit_end_2_export, -- realtimeclock_0_conduit_end_2.export
			realtimeclock_0_conduit_end_3_export => CONNECTED_TO_realtimeclock_0_conduit_end_3_export, -- realtimeclock_0_conduit_end_3.export
			realtimeclock_0_conduit_end_4_export => CONNECTED_TO_realtimeclock_0_conduit_end_4_export, -- realtimeclock_0_conduit_end_4.export
			realtimeclock_0_conduit_end_5_export => CONNECTED_TO_realtimeclock_0_conduit_end_5_export, -- realtimeclock_0_conduit_end_5.export
			reset_reset_n                        => CONNECTED_TO_reset_reset_n                         --                         reset.reset_n
		);

