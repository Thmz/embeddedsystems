library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rtc is
	port(
		clk        : IN  std_logic;
		nReset     : IN  std_logic;
		Address    : IN  std_logic_vector(2 downto 0);
		ChipSelect : IN  std_logic;
		Read       : IN  std_logic;
		Write      : IN  std_logic;
		ReadData   : OUT std_logic_vector(7 DOWNTO 0) := (others => '0');
		WriteData  : IN  std_logic_vector(7 DOWNTO 0);
		SelSeg     : out std_logic_vector(7 downto 0) := (others => '0');
		Reset_Led  : out std_logic := '0';
		nSelDig    : out std_logic_vector(5 downto 0) := (others => '1');
		SwLed      : in  std_logic_vector(7 downto 0);
		nButton    : in  std_logic_vector(3 downto 0);
		LedButton  : out std_logic_vector(3 downto 0) := (others => '0')
	);
end rtc;

architecture comp of rtc is
	signal RegHundreds : std_logic_vector(7 DOWNTO 0) := (others => '0'); -- in BCD format
	signal RegSeconds  : std_logic_vector(7 DOWNTO 0) := (others => '0'); -- in BCD format
	signal RegMinutes  : std_logic_vector(7 DOWNTO 0) := (others => '0'); -- in BCD format

	signal enable_100khz  : std_logic;
	signal enable_100hz : std_logic;

	
	-- bcd incrementer function
	function increment_bcd(bcd_number : std_logic_vector(7 downto 0)) return std_logic_vector is
		variable first_digit  : unsigned(3 downto 0);
		variable second_digit : unsigned(3 downto 0);

	begin
		first_digit  := unsigned(bcd_number(7 downto 4));
		second_digit := unsigned(bcd_number(3 downto 0)) + 1;
		if second_digit >= 10 then
			first_digit  := first_digit + 1;
			second_digit := (others => '0');
		end if;
		return std_logic_vector(first_digit & second_digit);

	end function increment_bcd;

begin

	-- slow clock logic
	process(clk)
		variable count_100khz  : natural;
		variable count_100hz : natural;
	begin
		if rising_edge(clk) then
			enable_100khz <= '0';         
			count_100khz  := count_100khz + 1;
			if count_100khz = 500 then   -- assuming 50 Mhz FPGA
				enable_100khz <= '1';
				count_100khz  := 1;		  -- starting at 1, because we compare to 500, and not 499
			end if;

			enable_100hz <= '0';
			count_100hz  := count_100hz + 1;
			if count_100hz = 500000 then -- assuming 50 Mhz FPGA 
				enable_100hz <= '1';
				count_100hz  := 1;
			end if;
		end if;
	end process;

	
	
	-- read	 
	pTimeRd : process(Clk)
	begin
		if rising_edge(Clk) then
			ReadData <= (others => '0'); -- default value of ReadData line 
			if ChipSelect = '1' and Read = '1' then
				case Address(2 downto 0) is
					when "001"  => ReadData <= RegHundreds;
					when "010"  => ReadData <= RegSeconds;
					when "011"  => ReadData <= RegMinutes;
					when others => null;
				end case;
			end if;
		end if;
	end process pTimeRd;

	
	
	-- write + time updater logic
	update_rtc : process(clk, enable_100hz, nReset)
	begin	
			-- reset is checked first
		if nReset = '0' then
			RegHundreds <= (others => '0'); --   Input by default
			RegSeconds  <= (others => '0'); --   Input by default
			RegMinutes  <= (others => '0'); --   Input by default

		elsif rising_edge(clk) then
		
			-- write request is checked just after reset
			if ChipSelect = '1' and Write = '1' then --   Write cycle
				case Address(2 downto 0) is
					when "001"  => RegHundreds <= WriteData;
					when "010"  => RegSeconds <= WriteData;
					when "011"  => RegMinutes <= WriteData;
					when others => null;
				end case;
				
			--If no write request update the clock
			else
			
				if enable_100hz = '1' then
					RegHundreds <= increment_bcd(RegHundreds);
				end if;
				
				if RegMinutes = "10011001" and RegSeconds = "01011001" and RegHundreds = "10011001" then -- 59, 59 and 99 in BCD
					RegHundreds <= (others => '0');
					RegSeconds  <= (others => '0');
					RegMinutes  <= (others => '0');
					
				elsif RegSeconds = "01011001" and RegHundreds = "10011001" then -- 59 and 99 in BCD
					RegSeconds <= (others => '0');
					RegMinutes <= increment_bcd(RegMinutes);
					
				elsif RegHundreds = "10011001" then -- 99 in BCD
					RegHundreds <= (others => '0');
					RegSeconds  <= increment_bcd(RegSeconds);
				end if;
				
			end if;
		end if;
	end process update_rtc;

	
	
	
	-- screen updater logic
	update_screen : process(clk, enable_100khz)
		variable count_seg      : natural; -- which segment to update next
		variable show_dot			: std_logic := '0';
		variable cycle          : natural;
		variable number_to_show : std_logic_vector(3 DOWNTO 0) := (others => '0');
		
	 
		--cycle 0 clear all segments
		--cycle 1 load new segment, 
		--cycle 2-14 hold it (accumulating), 
		--cycle 15 remove load from segment and go to next segment
		
	begin
		if rising_edge(clk) and enable_100khz = '1' then

			if cycle = 0 then
				cycle     := 1;
				
				-- clear all segments
				Reset_led <= '1';
				
				-- activate segment
				case count_seg is
					when 0      => nSelDig <= "111110";
					when 1      => nSelDig <= "111101";
					when 2      => nSelDig <= "111011";
					when 3      => nSelDig <= "110111";
					when 4      => nSelDig <= "101111";
					when 5      => nSelDig <= "011111";
					when others => nSelDig <= "111111";
				end case;

			elsif cycle = 1 then
				cycle := 2;

				-- undo reset
				Reset_led <= '0';

				-- get number to show	
				case count_seg is
					when 0      => number_to_show := RegHundreds(3 downto 0);
										show_dot := '0';
					when 1      => number_to_show := RegHundreds(7 downto 4);
										show_dot := '0';
					when 2      => number_to_show := RegSeconds(3 downto 0);
										show_dot := '1';
					when 3      => number_to_show := RegSeconds(7 downto 4);
										show_dot := '0';
					when 4      => number_to_show := RegMinutes(3 downto 0);
										show_dot := '1';
					when 5      => number_to_show := RegMinutes(7 downto 4);
										show_dot := '0';
					when others => number_to_show := "0000";
				end case;

				-- map number to nSelDig		
				case number_to_show is
					when "0000" => SelSeg <= show_dot & "0111111";
					when "0001" => SelSeg <= show_dot & "0000110";
					when "0010" => SelSeg <= show_dot & "1011011";
					when "0011" => SelSeg <= show_dot & "1001111";
					when "0100" => SelSeg <= show_dot & "1100110";
					when "0101" => SelSeg <= show_dot & "1101101";
					when "0110" => SelSeg <= show_dot & "1111101";
					when "0111" => SelSeg <= show_dot & "0000111";
					when "1000" => SelSeg <= show_dot & "1111111";
					when "1001" => SelSeg <= show_dot & "1101111";
					when others => SelSeg <= show_dot & "0000000"; 
				end case;

			elsif cycle >= 2 and cycle <= 14 then
				cycle := cycle + 1;

			elsif cycle = 15 then
				cycle := 0;

				-- take load from segment
				SelSeg <= "00000000";

				-- update segment counter
				count_seg := count_seg + 1;
				if count_seg = 6 then
					count_seg := 0;
				end if;
			end if;
		end if;                         

	end process update_screen;

end architecture comp;