library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lcd_slave_tb is
end;

architecture bench of lcd_slave_tb is
	constant CLK_PER     : time    := 20 ns;
	constant DELAY_TESTS : integer := 3;

	-- subtype data is std_logic_vector(7 downto 0);
	signal clk_tb        : std_logic := '0';
	signal rst_n_tb      : std_logic := '0';

	
		-- Avalon bus signals
	signal AS_Address_tb          : std_logic_vector(1 downto 0);
	signal AS_ChipSelect_tb       : std_logic;		
	signal AS_Wr_tb               : std_logic;
	signal AS_WrData_tb           : std_logic_vector(31 downto 0);
	signal AS_Rd_tb               : std_logic;
	signal AS_RdData_tb           : std_logic_vector(31 downto 0);
	signal AS_IRQ_tb     	      : std_logic;
	signal AS_WaitRequest_tb      : std_logic;
		
		-- Master signals
	signal MS_Address_tb          : std_logic_vector(31 downto 0);
	signal MS_Length_tb           : std_logic_vector(31 downto 0);
	signal MS_StartDMA_tb         : std_logic;
		
		-- LT24 Controller signals
	signal LS_Busy_tb             : std_logic;
	signal LS_DC_n_tb             : std_logic;
	signal LS_Wr_n_tb             : std_logic;
	signal LS_Rd_n_tb             : std_logic;
	signal LS_WrData_tb           : std_logic_vector(15 downto 0);
	signal LS_RdData_tb           : std_logic_vector(15 downto 0);
	
	
	signal phase_id: natural := 0;
	signal done : boolean := false;

begin

	clk_tb <= not clk_tb after CLK_PER / 2 when not done;
	
--	
	DUV : entity work.lcd_slave
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
			MS_Address         => MS_Address_tb, 
			MS_Length          => MS_Length_tb,
			MS_StartDMA        => MS_StartDMA_tb,
			LS_Busy            => LS_Busy_tb,
			LS_DC_n            => LS_DC_n_tb,
			LS_Wr_n            => LS_Wr_n_tb,
			LS_Rd_n            => LS_Rd_n_tb,
			LS_WrData          => LS_WrData_tb,
			LS_RdData          => LS_RdData_tb
		);
	

	process
		procedure new_phase is
		begin
			phase_id     <= phase_id + 1;
			wait until falling_edge(clk_tb);
		end procedure new_phase;		
		
		
		procedure clk_cycle is
		begin
			wait until falling_edge(clk_tb);			
		end procedure;
		
		
		procedure test_lcd_work is
		begin
			wait until falling_edge(clk_tb);
			LS_Busy_tb <= '1';
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
		end procedure;
		
		procedure test_lcd_done is
		begin
			LS_Busy_tb <= '0';
			wait until falling_edge(clk_tb);
		end procedure;
		
		procedure test_reg_write(vAddress : in std_logic_vector(1 downto 0); vWrData : in std_logic_vector(31 downto 0)) is
		begin			
			wait until falling_edge(clk_tb);	
			AS_ChipSelect_tb <= '1';			
			AS_Wr_tb <= '1';			
			AS_Address_tb <= vAddress;
			AS_WrData_tb <= vWrData;
			wait until falling_edge(clk_tb);
			AS_ChipSelect_tb <= '0';			
			AS_Wr_tb <= '0';			
			AS_Address_tb <= "00";
			AS_WrData_tb <= "00000000000000000000000000000000";
		end procedure;

		
		procedure test_reg_read(vAddress : in std_logic_vector(1 downto 0); vRdData : in std_logic_vector(31 downto 0)) is
		begin
			wait until falling_edge(clk_tb);
			AS_ChipSelect_tb <= '1';			
			AS_Rd_tb <= '1';			
			AS_Address_tb <= vAddress;
			wait for 2 ns;
			assert(AS_RdData_tb = vRdData) report "unexpected output AS_RdData";
			wait until falling_edge(clk_tb);
			AS_ChipSelect_tb <= '0';
			AS_Rd_tb <= '0';
			AS_Address_tb <= "00";
		end procedure;		


	begin
		report ("START TESTBENCH");
		done <= false;
		new_phase;
		wait for 2 ns;
		rst_n_tb <= '0';
		clk_cycle;
		wait for 2 ns;
		--ack to normal
		rst_n_tb <= '1';
		LS_Busy_tb <='0';
		clk_cycle;
		new_phase;
		
		-- test len_reg
		test_reg_write("11","11110000111100001111000011110000");		
		test_reg_read("11","11110000111100001111000011110000");
		-- test len_addr
		test_reg_write("10","00110011001100110011001100110011");
		test_lcd_work;
		test_lcd_done;
		test_reg_read("10","00110011001100110011001100110011");
		-- test cmd write
		test_reg_write("00","00000000000000001010101010101010");
		test_lcd_work;
		test_lcd_done;
		-- test data write
		test_reg_write("01","00000000000000001100110011001100");
		test_lcd_work;
		test_lcd_done;
		
		
		done <= true;
		wait;
	end process;

end architecture bench;

