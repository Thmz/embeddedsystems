
library ieee;
use ieee.std_logic_1164.all;

entity parallelport is
    port(
		Clk : IN std_logic;
		nReset : IN std_logic;
		Address : IN std_logic_vector( 2 downto 0);
		ChipSelect : IN std_logic;
		
		Read : IN std_logic;
		Write : IN std_logic;
		
		ReadData : OUT std_logic_vector( 7 DOWNTO 0);
		WriteData : IN std_logic_vector( 7 DOWNTO 0);
		
		ParPort : INOUT std_logic_vector ( 7 DOWNTO 0)
		
		);
	end parallelport;
		
	architecture comp of parallelport is
			signal iRegDir : std_logic_vector (7 DOWNTO 0);
			signal iRegPort: std_logic_vector (7 DOWNTO 0);
			signal iRegPin : std_logic_vector (7 DOWNTO 0);
			
			
		begin
		pPort: 
			process (iRegDir, iRegPort)
			begin 		
				for i in 0 to 7 loop
					if iRegDir(i) = '1' then
						ParPort(i) <= iRegPort(i);
					else
						ParPort(i) <= 'Z';
					end if;
				end loop;
			end process pPort;
			
			iRegPin <= ParPort;
			
			
		pRegWr:
			process(Clk, nReset)
			begin 
				if nReset = '0' then
					iRegDir <= (others => '0');  --   Input by default
					
					
				elsif rising_edge(Clk) then 
					if ChipSelect= '1' and Write = '1' then  --   Write cycle
						case Address (2 downto 0) is
							when "000" => iRegDir <= WriteData; 
							when "010" => iRegPort <= WriteData; 
							when "011" => iRegPort <= iRegPort OR WriteData;
							when "100" => iRegPort <= iRegPort AND  NOT WriteData; 
							when others => null;
						end case;
					end if;
				end if;
			end process pRegWr;





		-- read	 
		pRegRd: 
			process(Clk) 
			begin
				if rising_edge(Clk) then 
					ReadData <= (others => '0');
					if ChipSelect = '1' and Read = '1' then 	 	
						case Address(2 downto 0) is 
							when "000" => ReadData <= iRegDir ; 
							when "001" => ReadData <= iRegPin ;
							when "010" => ReadData <= iRegPort; 
							when others => null; 
						end case; 
					end if; 
				end if; 
			end process pRegRd; 
end architecture comp;