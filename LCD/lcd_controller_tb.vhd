library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lcd_controller_tb is
end;

architecture bench of lcd_controller_tb is
	constant CLK_PER     : time    := 20 ns;
	constant DELAY_TESTS : integer := 3;

--	component lcd_controller is
--		port(
--			clk         : in  std_logic;
--			rst         : in  std_logic;
--
--			-- LCD
--			CS_n        : out std_logic;
--			DC_n        : out std_logic;
--			Wr_n        : out std_logic;
--			Rd_n        : out std_logic;
--			D           : out std_logic_vector(15 downto 0);
--
--			-- Avalon Slave
--			LS_DC_n     : in  std_logic;
--			LS_Wr       : in  std_logic;
--			LS_Rd       : in  std_logic;
--			LS_WrData   : in  std_logic_vector(15 downto 0);
--			LS_RdData   : out std_logic_vector(15 downto 0);
--			LS_Busy     : out std_logic;
--
--			-- Master
--			ML_Busy     : in  std_logic;
--
--			-- FIFO 
--			FIFO_Rd     : out std_logic;
--			FIFO_RdData : in  std_logic_vector(31 downto 0);
--			FIFO_Empty  : in  std_logic
--		);
--	end component lcd_controller;

	-- subtype data is std_logic_vector(7 downto 0);
	signal clk_tb : std_logic := '0';
	signal rst_tb    : std_logic := '0';

	-- LCD
	signal CS_n_tb : std_logic ;
	signal DC_n_tb : std_logic ;
	signal Wr_n_tb : std_logic ;
	signal Rd_n_tb : std_logic ;
	signal D_tb    : std_logic_vector(15 downto 0);

	-- Avalon Slave
	signal LS_DC_n_tb   : std_logic;
	signal LS_Wr_tb     : std_logic;
	signal LS_Rd_tb     : std_logic;
	signal LS_WrData_tb : std_logic_vector(15 downto 0);
	signal LS_RdData_tb : std_logic_vector(15 downto 0);
	signal LS_Busy_tb   : std_logic;

	-- Master
	signal ML_Busy_tb : std_logic;

	-- FIFO 
	signal FIFO_Rd_tb     : std_logic;
	signal FIFO_RdData_tb : std_logic_vector(31 downto 0);
	signal FIFO_Empty_tb  : std_logic := '1';
	
	signal phase_id: natural := 0;

begin

	clk_tb <= not clk_tb after CLK_PER / 2;
	
--	
	DUV : entity work.lcd_controller
		port map(
			clk         => clk_tb,
			rst         => rst_tb,
			LS_DC_n     => LS_DC_n_tb,
			LS_Wr       => LS_Wr_tb,
			LS_Rd       => LS_Rd_tb,
			LS_WrData   => LS_WrData_tb,
			LS_RdData   => LS_RdData_tb,
			ML_Busy     => ML_Busy_tb,
			FIFO_RdData => FIFO_RdData_tb,
			FIFO_Empty  => FIFO_Empty_tb,
			CS_n        => CS_n_tb,
			DC_n        => DC_n_tb,
			Wr_n        => Wr_n_tb,
			Rd_n        => Rd_n_tb,
			D           => D_tb,
			LS_Busy     => LS_Busy_tb,
			FIFO_Rd     => FIFO_Rd_tb
		);

	

	process
		procedure new_phase is
		begin
			phase_id     <= phase_id + 1;
			wait until falling_edge(clk_tb);
		end procedure new_phase;
		
		
		
		
		procedure test_write(vDC_n : in std_logic; vWrData : in std_logic_vector(15 downto 0)) is
		begin
			LS_DC_n_tb   <= vDC_n;
			LS_Wr_tb     <= '1';
			LS_Rd_tb     <= '0';
			LS_WrData_tb <= vWrData;
			
			wait until falling_edge(clk_tb) and LS_Busy_tb = '1';
			assert(Wr_n_tb = '0') report "assert 1";
			assert(Rd_n_tb = '1') report "assert 2";
			assert(D_tb = vWrData);
			
			LS_Wr_tb     <= '0';
			LS_Rd_tb     <= '0';
			
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			assert(Wr_n_tb = '1') report "assert 3";
			assert(Rd_n_tb = '1') report "assert 4";
			assert(D_tb = vWrData) report "assert 5";

			wait until falling_edge(clk_tb) and LS_Busy_tb = '0';
			
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			
		end procedure;
		
		procedure test_new_frame is
		begin
			
			ML_Busy_tb <= '1';
			wait until falling_edge(clk_tb);
			assert(LS_Busy_tb = '1') report "assert 6";
			assert( D_tb = "0000000000101100"); -- 0x2C command
			assert(Wr_n_tb = '0') report "assert 7";
			assert(Rd_n_tb = '1') report "assert 8";
			
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			assert(Wr_n_tb = '1') report "assert 9";
			assert(Rd_n_tb = '1') report "assert 10";
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			
		end procedure;
		
		
		
		procedure test_new_pixel is
		begin
			
			-- set FIFO data
			FIFO_RdData_tb <= "00110100011010011001011100101000";
			FIFO_Empty_tb <= '0';
			
			wait until FIFO_Rd_tb = '1' and  falling_edge(clk_tb);
			FIFO_Empty_tb <= '1';
			wait until falling_edge(clk_tb);
			
			-- test first pixel
			wait until falling_edge(clk_tb);
			assert(Wr_n_tb = '0');
			assert(Rd_n_tb = '1');
			assert(D_tb = "1001011100101000");		
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			assert(Wr_n_tb = '1');
			assert(Rd_n_tb = '1');
			assert(D_tb = "1001011100101000");
			
			--test second pixel
			wait until falling_edge(clk_tb);
			assert(Wr_n_tb = '0');
			assert(Rd_n_tb = '1');
			assert(D_tb = "0011010001101001");		
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			assert(Wr_n_tb = '1');
			assert(Rd_n_tb = '1');
			assert(D_tb = "0011010001101001");
			
			
			
			
			
		end procedure;
		


	begin
		report ("START TESTBENCH");
		new_phase;
		wait for 2 ns;
		rst_tb <= '1';
		wait until falling_edge(clk_tb);
		wait for 2 ns;
		rst_tb <= '0';

		new_phase;
		test_write('1', "1111000011110000");
		new_phase;
		test_write('0', "0011110000111100");
		new_phase;
		test_new_frame;
		new_phase;
		test_new_pixel;
		--test_read('0'); -- not implemented in lcd_controller yet
		wait;
	end process;

end architecture bench;

