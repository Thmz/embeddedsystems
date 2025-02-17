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
	signal AM_Rd_tb               : std_logic := '0';
	signal AM_RdDataValid_tb      : std_logic := '0';
	signal AM_Burstcount_tb       : std_logic_vector(7 downto 0);	
	signal AM_RdData_tb           : std_logic_vector(31 downto 0);	
	signal AM_WaitRequest_tb      : std_logic := '0';
		
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
		
				
		procedure test_whole_small_frame is
		begin
		-- write small length
			AS_ChipSelect_tb <= '1';			
			AS_Wr_tb <= '1';			
			AS_Address_tb <= "11";
			AS_WrData_tb <= "00000000000000000000000000100000"; --32 so 2 burst
			wait until falling_edge(clk_tb);
			AS_ChipSelect_tb <= '0';			
			AS_Wr_tb <= '0';			
			AS_Address_tb <= "00";
			AS_WrData_tb <= "00000000000000000000000000000000";
			wait until falling_edge(clk_tb);
		-- write address start dma
			AS_ChipSelect_tb <= '1';			
			AS_Wr_tb <= '1';			
			AS_Address_tb <= "10";
			AS_WrData_tb <= "00000000000000000000000000000000"; --starting address 0x0000000 like real world :)
			wait until falling_edge(clk_tb);
			AS_ChipSelect_tb <= '0';			
			AS_Wr_tb <= '0';			
			AS_Address_tb <= "00";
			AS_WrData_tb <= "00000000000000000000000000000000";
			wait until falling_edge(clk_tb);
		--start burst
			
			AM_WaitRequest_tb <= '0';
			AM_RdDataValid_tb <= '1';	
			for i in 0 to 100 loop
				AM_RdData_tb <= "11110000000000000000111100000000";
				wait until falling_edge(clk_tb);
				AM_RdData_tb <= "00010000000000000000100000000000";
				wait until falling_edge(clk_tb);
				AM_RdData_tb <= "01010000000010000000100000000000";
				wait until falling_edge(clk_tb);
			end loop;

			
			wait for 8000 ns;		
		
		end procedure;
		
		procedure as_write (vAS_Address : in std_logic_vector(1 downto 0); vAS_WrData : in std_logic_vector(31 downto 0)) is
		begin
			AS_ChipSelect_tb <= '1';	
			AS_Rd_tb <= '0';		
			AS_Wr_tb <= '1';			
			AS_Address_tb <= vAS_Address;
			AS_WrData_tb <= vAS_WrData;
			wait until falling_edge(clk_tb);
			AS_ChipSelect_tb <= '0';			
			AS_Wr_tb <= '0';			
			AS_Address_tb <= "00";
			AS_WrData_tb <= "00000000000000000000000000000000";
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
		
		end procedure;

		procedure as_read(vAS_Address : in std_logic_vector(1 downto 0); vRdData : in std_logic_vector(15 downto 0)) is
		begin
			AS_Address_tb <= vAS_Address;
			AS_ChipSelect_tb <= '1';
			AS_Wr_tb <= '0';			
			AS_Rd_tb <= '1';
			D_tb <= vRdData;
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			AS_ChipSelect_tb <= '0';			
			AS_Rd_tb <= '0';

			-- keep signal for a long time because of dummy read
			wait for 150 ns;
			D_tb <= "ZZZZZZZZZZZZZZZZ";
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);
			wait until falling_edge(clk_tb);


		end procedure;

		
		procedure write_reg (vAS_WrData : in std_logic_vector(31 downto 0)) is
		begin
			as_write("00",vAS_WrData);
			wait for 100 ns;
		end procedure;
		
		procedure write_data(vAS_WrData : in std_logic_vector(31 downto 0)) is
		begin
			as_write("01",vAS_WrData);	
			wait for 100 ns;			
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
		wait until falling_edge(clk_tb);
		new_phase;
		write_reg("00000000000000000000000000001100");
		new_phase;--1
		as_read("00", "1110111011101110");

		new_phase;
		--as_read("01", "1110111011101110");
		--as_read("01", "1110111011101110");
		--as_read("01", "1110111011101110");
		new_phase; --2
		write_reg("00000000000000000000000000101100"); --0x002c
		new_phase;
		--sending 3 pixel  --> nios style working in real life
		write_data("00000000000000001111000000000000"); --0xf000
		write_data("00000000000000001111000000000000"); --0xf000
		write_data("00000000000000001111000000000000"); --0xf000
		new_phase;
		-- sending 2* 16 *2 pixel --> dma style not working in real life
		test_whole_small_frame;
		
		new_phase;--1
		
		done <= true;
		wait;
	end process;

end architecture bench;

