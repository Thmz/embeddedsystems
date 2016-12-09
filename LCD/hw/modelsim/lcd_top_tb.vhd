library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lcd_top_tb is
end;

architecture bench of lcd_top_tb is
	constant CLK_PER     : time    := 20 ns;
	constant DELAY_TESTS : integer := 3;

	-- subtype data is std_logic_vector(7 downto 0);
	signal clk_tb        : std_logic := '0';
	signal rst_n_tb      : std_logic := '0';

	
		-- Avalon slave bus signals
	signal AS_Address_tb          : std_logic_vector(1 downto 0);
	signal AS_ChipSelect_tb       : std_logic;		
	signal AS_Wr_tb               : std_logic;
	signal AS_WrData_tb           : std_logic_vector(31 downto 0);
	signal AS_Rd_tb               : std_logic;
	signal AS_RdData_tb           : std_logic_vector(31 downto 0);
	signal AS_IRQ_tb     	      : std_logic;
	signal AS_WaitRequest_tb      : std_logic;
	
		
		-- Avalon master bus signals
	signal AM_Address_tb          : std_logic_vector(31 downto 0);
	signal AM_ByteEnable_tb       : std_logic_vector(3 downto 0);		
	signal AM_Rd_tb               : std_logic;
	signal AM_RdDataValid_tb      : std_logic;
	signal AM_Burstcount_tb       : std_logic_vector(7 downto 0);	
	signal AM_RdData_tb           : std_logic_vector(31 downto 0);	
	signal AM_WaitRequest_tb      : std_logic;
		
		-- LCD
	signal CS_n_tb          	  : std_logic ;
	signal DC_n_tb 				  : std_logic ;
	signal Wr_n_tb 				  : std_logic ;
	signal Rd_n_tb 				  : std_logic ;
	signal D_tb    				  : std_logic_vector(15 downto 0);
	
	
	signal phase_id: natural := 0;
	signal done : boolean := false;

begin

	clk_tb <= not clk_tb after CLK_PER / 2 when not done;
	
--	
	DUV : entity work.lcd_top
		port map(
			clk                => clk_tb,
			rst_n              => rst_n_tb,
			AS_Address         => AS_Address_tb,
			AS_ChipSelect      => AS_ChipSelect_tb,
			AS_Wr              => AS_Wr_tb,
			AS_WrData          => AS_WrData_tb,
			AS_Rd              => AS_Rd_tb,
			AS_RdData          => AS_RdData_tb,
			AS_IRQ             => AS_IRQ_tb,
			AS_WaitRequest     => AS_WaitRequest_tb,
			AM_Address         => AM_Address_tb,
			AM_ByteEnable      => AM_ByteEnable_tb,
			AM_Rd              => AM_Rd_tb,
			AM_RdDataValid     => AM_RdDataValid_tb,
			AM_Burstcount      => AM_Burstcount_tb, 
			AM_RdData          => AM_RdData_tb,
			AM_WaitRequest     => AM_WaitRequest_tb,
			CS_n       		   => CS_n_tb,
			DC_n        	   => DC_n_tb,
			Wr_n        	   => Wr_n_tb,
			Rd_n        	   => Rd_n_tb,
			D           	   => D_tb
		);
	

	process
		procedure new_phase is
		begin
			phase_id     <= phase_id + 1;
			wait until falling_edge(clk_tb);
		end procedure new_phase;		
		
		
		procedure test_empty is
		begin
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			assert(rst_n_tb = '1') report "empty 1";
			wait until falling_edge(clk_tb);
			
		end procedure;
		

		procedure test_new_cmd(vAS_Address : in std_logic_vector(1 downto 0); vAS_WrData : in std_logic_vector(31 downto 0)) is
		begin
			AS_Address_tb <= vAS_Address;
			AS_WrData_tb <= vAS_WrData;


			AS_ChipSelect_tb <= '1';			
			AS_Wr_tb <= '1';

			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			AS_ChipSelect_tb <= '0';			
			AS_Wr_tb <= '0';
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			assert(AS_WaitRequest_tb = '0') report "empty 1";
			wait until falling_edge(clk_tb);			
			
			--wait until falling_edge(clk_tb) and LS_Busy_tb = '1';
			--assert(Wr_n_tb = '0') report "assert 1";
			--assert(Rd_n_tb = '1') report "assert 2";
			--assert(D_tb = vWrData) report "assert 2.1";
			
			
			--wait until falling_edge(clk_tb);
			--wait until falling_edge(clk_tb);
			--assert(Wr_n_tb = '1') report "assert 3";
		--	assert(Rd_n_tb = '1') report "assert 4";
		--	assert(D_tb = vWrData) report "assert 5";

		--	wait until falling_edge(clk_tb) and LS_Busy_tb = '0';
			
		--	wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			
		end procedure;

		procedure test_avalon_read(vAS_Address : in std_logic_vector(1 downto 0)) is
		begin
			AS_Address_tb <= vAS_Address;
			AS_ChipSelect_tb <= '1';			
			AS_Rd_tb <= '1';

			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			AS_ChipSelect_tb <= '0';			
			AS_Rd_tb <= '0';
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			assert(AS_WaitRequest_tb = '0') report "empty 1";
			wait until falling_edge(clk_tb);			
			
			--wait until falling_edge(clk_tb) and LS_Busy_tb = '1';
			--assert(Wr_n_tb = '0') report "assert 1";
			--assert(Rd_n_tb = '1') report "assert 2";
			--assert(D_tb = vWrData) report "assert 2.1";
			
			
			--wait until falling_edge(clk_tb);
			--wait until falling_edge(clk_tb);
			--assert(Wr_n_tb = '1') report "assert 3";
		--	assert(Rd_n_tb = '1') report "assert 4";
		--	assert(D_tb = vWrData) report "assert 5";

		--	wait until falling_edge(clk_tb) and LS_Busy_tb = '0';
			
		--	wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			
		end procedure;
		


	begin
		report ("START TESTBENCH");
		done <= false;
		new_phase;--1
		wait for 2 ns;
		rst_n_tb <= '0';
		wait until falling_edge(clk_tb);
		wait for 2 ns;
		rst_n_tb <= '1';

		new_phase;--2
		test_empty;

		new_phase;--3
		--random command
		test_new_cmd("00", "00000000000000001111000000000000");

		new_phase;--4
		-- new length
		test_new_cmd("11", "00000000000000001111000000000000");

		new_phase;--5
		-- read_length
		test_avalon_read("11");

		new_phase;--6
		-- new data adress
		test_new_cmd("10", "00000000000000001111000000000000");
		
		done <= true;
		wait;
	end process;

end architecture bench;

