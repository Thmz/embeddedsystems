library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lcd_master_tb is
end;

architecture bench of lcd_master_tb is
	constant CLK_PER     : time    := 20 ns;
	constant DELAY_TESTS : integer := 3;

	-- subtype data is std_logic_vector(7 downto 0);
	signal clk_tb : std_logic := '0';
	signal rst_n_tb    : std_logic := '0';

	
			-- Avalon bus signals
	signal	AM_Address_tb         : std_logic_vector(31 downto 0);
	signal	AM_ByteEnable_tb      : std_logic_vector(3 downto 0);		
	signal	AM_Rd_tb              : std_logic;
	signal	AM_RdDataValid_tb     : std_logic;
	signal	AM_Burstcount_tb      : std_logic_vector(7 downto 0);	
	signal	AM_RdData_tb          : std_logic_vector(31 downto 0);	
	signal	AM_WaitRequest_tb     : std_logic;
		
		-- Slave signals
	signal	MS_Address_tb         : std_logic_vector(31 downto 0);
	signal	MS_Length_tb          : std_logic_vector(31 downto 0);
	signal	MS_StartDMA_tb        : std_logic;
		
		-- LCD Controller signals
	signal	ML_Busy_tb            : std_logic;
		
		-- FIFO signals
	signal	FIFO_Full_tb          : std_logic;
	signal	FIFO_Wr_tb            : std_logic;
	signal	FIFO_WrData_tb        : std_logic_vector(31 downto 0);
	signal	FIFO_Almost_Full_tb   : std_logic;	
	
	
	signal phase_id: natural := 0;
	signal done : boolean := false;

begin

	clk_tb <= not clk_tb after CLK_PER / 2 when not done;
	
--	
	DUV : entity work.lcd_master
		port map(
			clk                => clk_tb,
			rst_n              => rst_n_tb,
			AM_Address         => AM_Address_tb,
			AM_ByteEnable      => AM_ByteEnable_tb,
			AM_Rd              => AM_Rd_tb,
			AM_RdDataValid     => AM_RdDataValid_tb,
			AM_RdData          => AM_RdData_tb,
			AM_WaitRequest     => AM_WaitRequest_tb,
			MS_Address         => MS_Address_tb,
			MS_Length          => MS_Length_tb,
			MS_StartDMA        => MS_StartDMA_tb,
			ML_Busy            => ML_Busy_tb, 
			FIFO_Full          => FIFO_Full_tb,
			FIFO_Wr            => FIFO_Wr_tb,
			FIFO_WrData        => FIFO_WrData_tb,
			FIFO_Almost_Full   => FIFO_Almost_Full_tb
		);

	

	process
		procedure new_phase is
		begin
			phase_id     <= phase_id + 1;
			wait until falling_edge(clk_tb);
		end procedure new_phase;
		
		
		
		
		procedure test_start(vMS_StartDMA : in std_logic; vMS_Address : in std_logic_vector(31 downto 0); vMS_Length: in std_logic_vector(31 downto 0)) is
		begin
			MS_StartDMA_tb   <= '1';
			MS_Address_tb    <= vMS_Address;
			MS_Length_tb     <= vMS_Length;
			
			wait until falling_edge(clk_tb);
			MS_StartDMA_tb   <= '0';
			wait until falling_edge(clk_tb);
			assert(ML_Busy_tb = '1') report "assert 1";
			wait until falling_edge(clk_tb);
			
		end procedure;
		
		procedure test_burst(vAM_RdData_0: in std_logic_vector(31 downto 0)) is
		begin
		
			AM_WaitRequest_tb <= '1';			
			wait until falling_edge(clk_tb);
			AM_WaitRequest_tb <= '0';			
			wait until falling_edge(clk_tb);
			assert(AM_Burstcount_tb = "00010000") report "assert 2";
			AM_RdData_tb <= vAM_RdData_0;
			AM_RdDataValid_tb <= '1';			
			wait until falling_edge(clk_tb);
			assert(FIFO_Wr_tb = '1') report "assert 3";
			
		end procedure;
		
		procedure test_reset is
		begin
		
			wait for 2 ns;
			rst_n_tb <= '0';
			wait until falling_edge(clk_tb);
			wait for 2 ns;
			rst_n_tb <= '1';
			
		end procedure;
		

		


	begin
		report ("START TESTBENCH");
		--INIT OUT SIGNAL--
		FIFO_Almost_Full_tb <= '0';
		
		
		done <= false;
		new_phase;
		wait for 2 ns;
		rst_n_tb <= '0';
		wait until falling_edge(clk_tb);
		wait for 2 ns;
		rst_n_tb <= '1';

		new_phase;
		test_start('1', "11110000111100001111000011110000","00000000000000001001011000000000");
		new_phase;
		test_burst("11110000111100001111000011110000");
		new_phase;
		new_phase;
		new_phase;
		new_phase;		
		new_phase;
		new_phase;
		new_phase;
		new_phase;		
		new_phase;
		new_phase;
		new_phase;
		new_phase;		
		new_phase;
		new_phase;
		new_phase;
		new_phase;
		new_phase;
		new_phase;
		new_phase;
		new_phase;
		new_phase;
		new_phase;
		
		
		--test_reset;
		done <= true;
		wait;
	end process;

end architecture bench;

