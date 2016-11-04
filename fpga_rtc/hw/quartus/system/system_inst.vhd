	component system is
		port (
			clk_clk                           : in  std_logic                    := 'X';             -- clk
			reset_reset_n                     : in  std_logic                    := 'X';             -- reset_n
			rtc_module_0_conduit_end_export   : out std_logic_vector(3 downto 0);                    -- export
			rtc_module_0_conduit_end_1_export : out std_logic;                                       -- export
			rtc_module_0_conduit_end_2_export : out std_logic_vector(7 downto 0);                    -- export
			rtc_module_0_conduit_end_3_export : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			rtc_module_0_conduit_end_4_export : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			rtc_module_0_conduit_end_5_export : out std_logic_vector(5 downto 0)                     -- export
		);
	end component system;

	u0 : component system
		port map (
			clk_clk                           => CONNECTED_TO_clk_clk,                           --                        clk.clk
			reset_reset_n                     => CONNECTED_TO_reset_reset_n,                     --                      reset.reset_n
			rtc_module_0_conduit_end_export   => CONNECTED_TO_rtc_module_0_conduit_end_export,   --   rtc_module_0_conduit_end.export
			rtc_module_0_conduit_end_1_export => CONNECTED_TO_rtc_module_0_conduit_end_1_export, -- rtc_module_0_conduit_end_1.export
			rtc_module_0_conduit_end_2_export => CONNECTED_TO_rtc_module_0_conduit_end_2_export, -- rtc_module_0_conduit_end_2.export
			rtc_module_0_conduit_end_3_export => CONNECTED_TO_rtc_module_0_conduit_end_3_export, -- rtc_module_0_conduit_end_3.export
			rtc_module_0_conduit_end_4_export => CONNECTED_TO_rtc_module_0_conduit_end_4_export, -- rtc_module_0_conduit_end_4.export
			rtc_module_0_conduit_end_5_export => CONNECTED_TO_rtc_module_0_conduit_end_5_export  -- rtc_module_0_conduit_end_5.export
		);

