
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rtc is
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
	end rtc;
		
	architecture comp of rtc is
	
--	begin
--	
--		SelSeg <= "01011011";
--		nSelDig <= "110111";
--		LedButton  <="1111";
--	
--	process(clk)
--		begin
--			if rising_edge(clk) then
--				Reset_led <= '1';		
--	
--			end if;
--
--		end process;
--		
	
		
		
			signal hundreds : std_logic_vector(7 DOWNTO 0) := (others => '0'); -- in BCD format
			signal seconds : std_logic_vector (7 DOWNTO 0) := (others => '0'); -- in BCD format
			signal minutes : std_logic_vector(7 DOWNTO 0) := (others => '0');-- in BCD format
			 
			signal  enable_1khz : std_logic;
			signal  enable_100hz : std_logic;
			
			
						-- bcd help
			function increment_bcd ( bcd_number: std_logic_vector(7 downto 0) ) return std_logic_vector is
					variable first_digit: unsigned(3 downto 0);
					variable second_digit : unsigned(3 downto 0);

			  begin
					first_digit := unsigned(bcd_number(7 downto 4));
					second_digit := unsigned(bcd_number(3 downto 0)) + 1;
					if second_digit >= 10 then
						first_digit := first_digit + 1;
						second_digit := (others => '0');
					end if;
					return std_logic_vector(first_digit & second_digit);
					
			end function increment_bcd;
		
		
		begin


		
		
		-- slow clock logic
		process(clk)
			variable count_1khz : natural;
			variable count_100hz : natural;
		begin
			if rising_edge(clk) then
				enable_1khz <= '0'; -- THIS CLOCK SHOULD BECOME 333 Hz because of the cycle
				count_1khz := count_1khz + 1;
				if count_1khz = 50000 then -- assuming 50 Mhz FPGA so should be 150150, but for testing purposes faster clock!
					enable_1khz <= '1';
					count_1khz := 0;
				end if;
				
				enable_100hz <= '0';
				count_100hz := count_100hz + 1;
				if count_100hz = 500000 then -- assuming 50 Mhz FPGA so should be 500000, but for testing purposes faster clock!
					enable_100hz <= '1';
					count_100hz := 0;
				end if;
			end if;
		end process;
		
	 
	 

--		-- time updater logic
		update_rtc : process(clk, enable_100hz)
			
		begin
			if rising_edge(clk) and enable_100hz = '1' then
				hundreds <= increment_bcd(hundreds);
				
				if hundreds = "10011001" then --153 then -- 153 is decimal for 10011001 which is 99 in BCD
					hundreds <= (others => '0');
					seconds <= increment_bcd(seconds);
				end if;
				
				if seconds = "01011001" and hundreds = "10011001" then -- 89 is decimal for 01011001 which is 59 in BCD
					seconds <= (others => '0');
					minutes <= increment_bcd(minutes);
				end if;
				
			end if;
		end process update_rtc;
		
		
		

		-- screen updater logic
		update_screen : process(clk, enable_1khz) -- 1khz is not correct, should be 333 hz, because we use 3 cycles for a segment refresh 
			variable count_seg : natural; -- which segment to update next
			variable cycle : natural; -- which cycle are we in: 
			-- cycle 0 clear all segments , cycle 1 load new segment, cycle 2 remove load from segmeent
			variable number_to_show : std_logic_vector(3 DOWNTO 0) := (others => '0');
		begin
			if rising_edge(clk) and enable_1khz = '1' then
				
				-- select current segment
				--nSelDig <= not ("000001"); 		
				
				

				--SelSeg <= "01011011";
				--Reset_led <= '0';
				
				if cycle = 0 then
					cycle := 1;
						-- clear all segments
					Reset_led <= '1';	
				case count_seg is
					 when 0 => nSelDig <= "111110";
					 when 1 => nSelDig <= "111101";
					 when 2 => nSelDig <= "111011";
					 when 3 => nSelDig <= "110111";
					 when 4 => nSelDig <= "101111";
					 when 5 => nSelDig <= "011111";
					 when others => nSelDig <="111111";
				  end case;					
				
				elsif cycle = 1 then
					cycle := 2;
					
					-- undo reset led
					Reset_led <= '0';
					
					-- get number to show	
					case count_seg is
					 when 0 => number_to_show := hundreds(3 downto 0);
					 when 1 => number_to_show := hundreds(7 downto 4);
					 when 2 => number_to_show := seconds(3 downto 0);
					 when 3 => number_to_show := seconds(7 downto 4);
					 when 4 => number_to_show := minutes(3 downto 0);
					 when 5 => number_to_show := minutes(7 downto 4);
					 when others => number_to_show := "0000";
					end case;
		  
							
					
			
					-- map number to nSelDig		
					case number_to_show is
					 when "0000" => SelSeg <= "00111111";-- just a placeholder TODO has to be changed to right string, according to 7-seg documentation
					 when "0001" => SelSeg <= "00000110";
					 when "0010" => SelSeg <= "01011011";
					 when "0011" => SelSeg <= "01001111";
					 when "0100" => SelSeg <= "01100110";
					 when "0101" => SelSeg <= "01101101";
					 when "0110" => SelSeg <= "01111101";
					 when "0111" => SelSeg <= "00000111";
					 when "1000" => SelSeg <= "01111111";
					 when "1001" => SelSeg <= "01101111";
					 when others =>  SelSeg <= "00000000"; -- MODIFIED BY LUKAS before nSelDir
					end case;

					
				elsif cycle = 2 then
					cycle := 3;
					
				elsif cycle = 3 then
					cycle := 4;
					
					
					
					
				elsif cycle = 4 then
					cycle := 0;
					
					
				
					
					-- take load from segment
					SelSeg <= "00000000";
					
					-- update segment counter
					count_seg := count_seg + 1;
					if count_seg = 6 then
						count_seg := 0;
					end if;
				end if;
				
			END IF; -- close rising edge if
			
		end process update_screen;
		
		
		
						  -- with .. select.. mstatement does not work for variables... ?!
		--				with count_seg select number_to_show :=
		--					 hundreds(3 downto 0) when 0,
		--					 hundreds(7 downto 4) when 1,
		--					 seconds(3 downto 0) when 2,
		--					 seconds(7 downto 4) when 3,
		--					 minutes(3 downto 0) when 4,
		--					 minutes(7 downto 3) when 5;

--		-- display_rtc
--		
--
--
--		-- below is code from parallelport
--		pPort: 
--			process (iRegDir, iRegPort)
--			begin 		
--				for i in 0 to 7 loop
--					if iRegDir(i) = '1' then
--						ParPort(i) <= iRegPort(i);
--					else
--						ParPort(i) <= 'Z';
--					end if;
--				end loop;
--			end process pPort;
--			
--			iRegPin <= ParPort;
--			
--			
--		pRegWr:
--			process(Clk, nReset)
--			begin 
--				if nReset = '0' then
--					iRegDir <= (others => '0');  --   Input by default
--					
--					
--				elsif rising_edge(Clk) then 
--					if ChipSelect= '1' and Write = '1' then  --   Write cycle
--						case Address (2 downto 0) is
--							when "000" => iRegDir <= WriteData; 
--							when "010" => iRegPort <= WriteData; 
--							when "011" => iRegPort <= iRegPort OR WriteData;
--							when "100" => iRegPort <= iRegPort AND  NOT WriteData; 
--							when others => null;
--						end case;
--					end if;
--				end if;
--			end process pRegWr;
--
--
--
--
--
--		-- read	 
--		pRegRd: 
--			process(Clk) 
--			begin
--				if rising_edge(Clk) then 
--					ReadData <= (others => '0');
--					if ChipSelect = '1' and Read = '1' then 	 	
--						case Address(2 downto 0) is 
--							when "000" => ReadData <= iRegDir ; 
--							when "001" => ReadData <= iRegPin ;
--							when "010" => ReadData <= iRegPort; 
--							when others => null; 
--						end case; 
--					end if; 
--				end if; 
--			end process pRegRd; 
end architecture comp;