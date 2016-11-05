library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rtc_tb is end;

architecture bench of rtc_tb is

	
	constant CLK_PER     : time := 20 ns;
	constant DELAY_TESTS : integer := 3;
	
   component rtc is
          port(
		clk : IN std_logic;
		nReset : IN std_logic;
		Address : IN std_logic_vector( 2 downto 0);
		ChipSelect : IN std_logic;
		
		Read : IN std_logic;
		Write : IN std_logic;
		
		ReadData : OUT std_logic_vector( 7 DOWNTO 0);
		WriteData : IN std_logic_vector( 7 DOWNTO 0);
		

		SelSeg           : out   std_logic_vector(7 downto 0);
		Reset_Led        : out   std_logic;
		nSelDig          : out   std_logic_vector(5 downto 0); 
		SwLed            : in    std_logic_vector(7 downto 0);
		nButton          : in    std_logic_vector(3 downto 0);
		LedButton        : out   std_logic_vector(3 downto 0)

	);
   end component rtc;
   
   subtype data is std_logic_vector(7 downto 0);
	
	signal clk_tb  : std_logic := '0';
	signal nReset_tb  : std_logic;
	signal Address_tb : std_logic_vector(2 downto 0);
	
	signal ChipSelect_tb : std_logic;
		
	signal Read_tb  :  std_logic;
	signal Write_tb :  std_logic;
	
	signal ReadData_tb  : data;
	signal WriteData_tb :  data;
	

	signal SelSeg_tb           :   data;
	signal Reset_Led_tb        :   std_logic;
	signal nSelDig_tb          :   std_logic_vector(5 downto 0); 
	signal SwLed_tb            :   data;
	signal nButton_tb          :   std_logic_vector(3 downto 0);
	signal LedButton_tb        :   std_logic_vector(3 downto 0);
	
   		
begin

   DUV : component rtc
      port map (
	clk => clk_tb,
         nReset => nReset_tb,
			Address => address_tb,
			ChipSelect => ChipSelect_tb,
			read => read_tb,
			write => write_tb,
			readdata => readdata_tb,
			writedata => writedata_tb,
			selseg => selseg_tb,
			reset_led => reset_led_tb,
			nseldig => nseldig_tb,
			swled => swled_tb,
			nbutton => nbutton_tb,
			ledbutton => ledbutton_tb);
			
			
	clk_tb <= not clk_tb after CLK_PER/2;
	
	 process

      procedure do_test ( address : in std_logic_vector(2 downto 0);
								 writedata : in std_logic_vector(7 downto 0);
								expect_data : in boolean
								) is
								variable readdata : std_logic_vector(7 downto 0);
      begin
				address_tb <= address;
				writedata_tb <= writedata;
				chipselect_tb <= '1';
				write_tb <= '1';
				wait until falling_edge(clk_tb);
				write_tb <= '0';
				
				-- read data to verify
				read_tb <= '1';
				address_tb <= address;
				wait until falling_edge(clk_tb);
				
				read_tb <= '0';
				
				if expect_data = true then
					assert readdata_tb = writedata report "assert done";
				else
					assert readdata_tb = "00000000";
				end if;
				
				wait until falling_edge(clk_tb);
      end procedure do_test;

   begin
      wait until falling_edge(clk_tb);
      wait until falling_edge(clk_tb);
      
      do_test("001", "10000101", true); -- write hundreds 85
		
		do_test("010", "01010010", true); -- write seconds 52

		do_test("011", "01100111", true); -- write minutes 67

		do_test("000", "01010010", false); -- write to no register, should return 00000000

		do_test("100", "01010010", false);

		do_test("101", "01010010", false);

		do_test("110", "01010010", false);

		do_test("111", "01010010", false);

      wait;
   end process;

	
end architecture bench;
