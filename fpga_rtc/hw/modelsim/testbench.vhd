library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rtc_tb is end;

architecture bench of rtc_tb is

	
	constant CLK_PER     : time := 20 ns;
	
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
	signal stop    : boolean := false;
	signal nReset_tb  : std_logic := '1';
	signal Address_tb : std_logic_vector(2 downto 0);
	
	signal ChipSelect_tb : std_logic := '0' ;
		
	signal Read_tb :  std_logic := '0';
	signal Write_tb :  std_logic := '0';
	
	signal ReadData_tb : data;
	signal WriteData_tb :  data;
	

	signal SelSeg_tb        :   data;
	signal Reset_Led_tb        :   std_logic;
	signal nSelDig_tb          :   std_logic_vector(5 downto 0); 
	signal SwLed_tb            :   data;
	signal nButton_tb          :   std_logic_vector(3 downto 0);
	signal LedButton_tb        :  std_logic_vector(3 downto 0);
	
   		
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
end architecture bench;
