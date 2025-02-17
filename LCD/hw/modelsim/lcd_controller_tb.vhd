library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lcd_controller_tb is
end;

architecture bench of lcd_controller_tb is
	constant CLK_PER     : time    := 20 ns;
	constant DELAY_TESTS : integer := 3;

	-- subtype data is std_logic_vector(7 downto 0);
	signal clk_tb : std_logic := '0';
	signal rst_n_tb    : std_logic := '0';

	-- LCD
	signal CS_n_tb : std_logic ;
	signal DC_n_tb : std_logic ;
	signal Wr_n_tb : std_logic ;
	signal Rd_n_tb : std_logic ;
	signal D_tb    : std_logic_vector(15 downto 0);

	-- Avalon Slave
	signal LS_DC_n_tb   : std_logic;
	signal LS_Wr_n_tb     : std_logic;
	signal LS_Rd_n_tb     : std_logic;
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
	signal done : boolean := false;

begin

	clk_tb <= not clk_tb after CLK_PER / 2 when not done;
	
--	
	DUV : entity work.lcd_controller
		port map(
			clk         => clk_tb,
			rst_n         => rst_n_tb,
			LS_DC_n     => LS_DC_n_tb,
			LS_Wr_n       => LS_Wr_n_tb,
			LS_Rd_n       => LS_Rd_n_tb,
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
			LS_Wr_n_tb     <= '0';
			LS_Rd_n_tb     <= '1';
			LS_WrData_tb <= vWrData;
			
			wait until falling_edge(clk_tb) and LS_Busy_tb = '1';
			assert(Wr_n_tb = '0') report "assert 1";
			assert(Rd_n_tb = '1') report "assert 2";
			assert(D_tb = vWrData) report "assert 2.1";
			
			LS_Wr_n_tb     <= '1';
			LS_Rd_n_tb     <= '1';
			
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
			assert( D_tb = "0000000000101100") report "assert 6.1"; -- 0x2C command
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
			
			wait until FIFO_Rd_tb = '1' and  rising_edge(clk_tb);
			FIFO_Empty_tb <= '1';
			wait until falling_edge(clk_tb);
			
			-- test first pixel
			wait until falling_edge(clk_tb);
			assert(Wr_n_tb = '0') report "assert 11";
			assert(Rd_n_tb = '1') report "assert 12";
			assert(D_tb = "1001011100101000") report "assert 12.1";		
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			assert(Wr_n_tb = '1') report "assert 13";
			assert(Rd_n_tb = '1') report "assert 14";
			assert(D_tb = "1001011100101000") report "assert 14.1";
			
			--test second pixel
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			assert(Wr_n_tb = '0') report "assert 15";
			assert(Rd_n_tb = '1') report "assert 16";
			assert(D_tb = "0011010001101001") report "assert 16.2";		
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			assert(Wr_n_tb = '1') report "assert 17";
			assert(Rd_n_tb = '1') report "assert 18";
			assert(D_tb = "0011010001101001") report "assert 18.2";
			
			
			
			
			
		end procedure;


		procedure test_read(vDC_n : in std_logic; vRdData : in std_logic_vector(15 downto 0)) is
		begin
			
			LS_DC_n_tb   <= vDC_n;
			LS_Wr_n_tb     <= '1';
			LS_Rd_n_tb     <= '0';
			D_tb <= vRdData;
			wait until falling_edge(clk_tb) and LS_Busy_tb = '1';
			assert(Wr_n_tb = '1') report "assert 1";
			assert(Rd_n_tb = '0') report "assert 2";
			
			LS_Wr_n_tb     <= '1';
			LS_Rd_n_tb     <= '1';
			--assert(D_tb = vWrData) report "assert 2.1";

			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			assert(Wr_n_tb = '1') report "assert 3";
			assert(Rd_n_tb = '1') report "assert 4";

			wait until falling_edge(clk_tb) and LS_Busy_tb = '0';
			
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);

			-- keep signal for a long time because of dummy read
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);

			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);

			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			
		end procedure;
		


	begin
		report ("START TESTBENCH");
		done <= false;
		new_phase;
		wait for 2 ns;
		rst_n_tb <= '0';
		wait until falling_edge(clk_tb);
		wait for 2 ns;
		rst_n_tb <= '1';

		--D_tb <= "1100110011001100";
		new_phase;
		test_read('0', "1100110011001100");
		--test_write('1', "1111000011110000");
		--new_phase;
		--test_write('0', "0011110000111100");
		--new_phase;
		--test_new_frame;
		--new_phase;
		--test_new_pixel;
		--test_read('0'); -- not implemented in lcd_controller yet


		wait until falling_edge(clk_tb);
		wait until falling_edge(clk_tb);
		wait until falling_edge(clk_tb);
		wait until falling_edge(clk_tb);
		done <= true;
		wait;
	end process;

end architecture bench;

