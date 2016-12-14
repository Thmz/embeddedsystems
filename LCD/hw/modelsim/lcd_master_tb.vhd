library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lcd_master_tb is
end;

architecture bench of lcd_master_tb is
	constant CLK_PER     : time    := 20 ns;
	constant DELAY_TESTS : integer := 3;

	-- subtype data is std_logic_vector(7 downto 0);
	signal clk_tb 				  : std_logic := '0';
	signal rst_n_tb    			  : std_logic := '0';

	
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
	
	DUV : entity work.lcd_master
		port map(
			clk                => clk_tb,
			rst_n              => rst_n_tb,
			AM_Address         => AM_Address_tb,
			AM_ByteEnable      => AM_ByteEnable_tb,
			AM_Rd              => AM_Rd_tb,
			AM_RdDataValid     => AM_RdDataValid_tb,
			AM_Burstcount      => AM_Burstcount_tb, 
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
		
		procedure reset is
		begin 
			wait for 5 ns;
			rst_n_tb <= '0';
			wait until falling_edge(clk_tb);
			wait for 8 ns;
			rst_n_tb <= '1';
		end procedure;
		
		
		procedure init_inputs is
		begin
			AM_RdDataValid_tb   <= '0';
			AM_RdData_tb        <= (others => '0');
			AM_WaitRequest_tb   <= '0';
			MS_Address_tb       <= (others => '0');
			MS_Length_tb        <= (others => '0');
			MS_StartDMA_tb      <= '0';
			FIFO_Full_tb 		<= '0';
			FIFO_Almost_Full_tb <= '0';			
		end procedure init_inputs;		
		
		
		procedure test_start(vMS_Address : in std_logic_vector(31 downto 0); vMS_Length: in std_logic_vector(31 downto 0)) is
		begin
			MS_StartDMA_tb   <= '1';
			MS_Address_tb    <= vMS_Address;
			MS_Length_tb     <= vMS_Length;			
			wait until falling_edge(clk_tb);			
			assert(ML_Busy_tb = '1') report "ML_Busy didn't go high after a Start_DMA arrive";
			MS_StartDMA_tb   <= '0';
			MS_Address_tb       <= (others => '0');
			MS_Length_tb        <= (others => '0');			
		end procedure;
		
		procedure start_burst(vAM_RdData_0: in std_logic_vector(31 downto 0)) is
		begin
			AM_WaitRequest_tb <= '1';	
			wait for 1 ns;
			assert(FIFO_Wr_tb = '0') report "DMA start filling up FIFO even if memory isn't ready";
			wait until falling_edge(clk_tb);
			AM_WaitRequest_tb <= '0';			
			wait for 3 ns;
			assert(AM_Burstcount_tb = "00010000") report "AM_Burstcount_tb is asking the right length of burst";
			wait until falling_edge(clk_tb);
			AM_RdData_tb <= vAM_RdData_0;
			AM_RdDataValid_tb <= '1';			
			wait for 3 ns;
			assert(FIFO_Wr_tb = '1') report "DMA isn't filling up the FIFO even if the memory 'send' data";
			assert(FIFO_WrData_tb = vAM_RdData_0) report "DMA fill the FIFO with wrong data";			
		end procedure;
		
		procedure stop_burst is
		begin
			AM_RdDataValid_tb <= '0';
			AM_RdData_tb <= (others => '0');
			wait for 3 ns;
			assert(FIFO_Wr_tb = '0') report "DMA start filling up FIFO even if memory isn't valid";
		end procedure;
		
		procedure fifo_almost_full is
		begin
			FIFO_Almost_Full_tb <= '1';
			wait for 200 ns; --at least 16 clk cycles
			assert(FIFO_Wr_tb = '0') report "DMA fill the FIFO even if it's almost full in the reading state";
			FIFO_Almost_Full_tb <='0';
			wait for 25 ns;
			assert(FIFO_Wr_tb = '1') report "DMA do not fill the FIFO even if there is place now";
		end procedure;


	begin
		report ("START TESTBENCH");
			
		done <= false;
		init_inputs;
		new_phase;
		reset;
		new_phase;		
		test_start("11110000111100001111000011110000","00000000000000001001011000000000");
		new_phase;
		start_burst("11110000111100001111000011110000");
		new_phase;
		--CHECK internal counter reg in DUV
		wait for 5555 ns; --time for a whole frame
		new_phase;
		fifo_almost_full;
		new_phase;
		wait for 150 ns;
		stop_burst;
		wait for 240 ns;
		--fifo almoset full;
		--test_reset;
		done <= true;
		wait;
	end process;

end architecture bench;

