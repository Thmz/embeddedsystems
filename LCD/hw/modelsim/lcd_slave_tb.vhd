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
			AS_Address_tb     <= (others => '0');
			AS_ChipSelect_tb  <= '0';
			AS_Wr_tb          <= '0';
			AS_WrData_tb      <= (others => '0');
			AS_Rd_tb           <= '0';
			LS_Busy_tb        <= '0';
			LS_RdData_tb      <= (others => '0');				
		end procedure;
		
		
		procedure test_DC_Rd(vAS_Address : in std_logic_vector(1 downto 0)) is
		begin
			AS_ChipSelect_tb <= '1';
			AS_Address_tb <= vAS_Address;
			AS_Rd_tb <= '1';
			wait for 2 ns;
			assert(LS_Rd_n_tb = '0') report "slave should make a read on the lcd";
			LS_Busy_tb <= '1';
			wait until falling_edge(clk_tb);
			assert(LS_Rd_n_tb = '1') report "slave should have dessarted LS_Rd_n signal";
			AS_ChipSelect_tb <= '0';
			AS_Address_tb <= "00";
			AS_Rd_tb <= '0';
			wait for 55 ns;
			LS_RdData_tb <= "0011001100110011";					
			wait until falling_edge(clk_tb);
			assert(AS_RdData_tb = "0000000000000000"&"0011001100110011") report "slave should output the right read value";
			LS_Busy_tb <= '0';
			wait until falling_edge(clk_tb);
		end procedure;
		
		procedure test_reg_Rd(vAS_Address : in std_logic_vector(1 downto 0); vAS_RdData : in std_logic_vector(31 downto 0)) is
		begin
			AS_ChipSelect_tb <= '1';			
			AS_Rd_tb <= '1';			
			AS_Address_tb <= vAS_Address;
			wait for 2 ns;
			assert(AS_RdData_tb = vAS_RdData) report "unexpected output AS_RdData";
			wait until falling_edge(clk_tb);
			AS_ChipSelect_tb <= '0';
			AS_Rd_tb <= '0';
			AS_Address_tb <= "00";
		end procedure;
		
		
		procedure test_reg_Wr(vAS_Address : in std_logic_vector(1 downto 0); vAS_WrData : in std_logic_vector(31 downto 0)) is
		begin			
			wait until falling_edge(clk_tb);	
			AS_ChipSelect_tb <= '1';			
			AS_Wr_tb <= '1';			
			AS_Address_tb <= vAS_Address;
			AS_WrData_tb <= vAS_WrData;
			wait until falling_edge(clk_tb);
			AS_ChipSelect_tb <= '0';			
			AS_Wr_tb <= '0';			
			AS_Address_tb <= "00";
			AS_WrData_tb <= "00000000000000000000000000000000";
			--nth to assert ?
		end procedure;
		
		procedure framing is
		begin
			LS_Busy_tb <= '1';
		end procedure;



	begin
		report ("START TESTBENCH");
		done <= false;
		new_phase;
		init_inputs;
		new_phase;
		reset;
		new_phase;
		--test cmd
		test_DC_Rd("01");
		new_phase;
		--test data
		test_DC_Rd("00");
		new_phase;
		--test default value of length
		test_reg_Rd("11","00000000000000001001011000000000");
		new_phase;
		test_reg_Wr("11","11110000111100001111000011110000");
		new_phase;
		--ignoring first bit
		test_reg_Rd("11","01110000111100001111000011110000");
		new_phase;
		test_reg_Wr("10","00001111000011110000111100001111");
		new_phase;
		--read during "framing"
		framing;
		new_phase;
		test_reg_Rd("10","00001111000011110000111100001111");
		new_phase;		
		
		done <= true;
		wait;
	end process;

end architecture bench;

