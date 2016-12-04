library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--TODO set default value of output
entity LCD_Slave is
	port(
		clk             : in  std_logic;
		Rst             : in  std_logic;
		
		-- Avalon bus signals
		AS_Address      : in  std_logic_vector(1 downto 0);
		AS_ChipSelect   : in  std_logic;		
		AS_Wr           : in  std_logic;
		AS_WrData       : in  std_logic_vector(31 downto 0);
		AS_Rd           : out std_logic;
		AS_RdData       : out std_logic_vector(31 downto 0);
		AS_IRQ			: out std_logic;
		AS_WaitRequest  : out std_logic;
		
		-- LT24 Controller signals
		LS_Busy         : in  std_logic;
		LS_DC_n         : out std_logic;
		LS_Wr           : out std_logic;
		LS_Rd           : out std_logic;
		LS_WrData       : out std_logic_vector(15 downto 0);
		LS_RdData       : in  std_logic_vector(15 downto 0);		
		
		-- Master signals		
		MS_Address      : out std_logic_vector(31 downto 0);
		MS_StartDMA     : out std_logic
	);
end entity LCD_Slave;

architecture RTL of LCD_Slave is
	--signal address_dma_reg : std_logic_vector(31 downto 0);
	
	
begin

	
	--Handle reset procedure and state changes
	run_process : process(clk, Rst) is
	begin
		if Rst = '1' then
			state           <= IDLE;
			next_state      <= IDLE;
		elsif rising_edge(clk) then
			state           <= next_state;
		end if;
	end process run_process;
	
	state_machine_process : process(clk, state)
	
	
	--TODO
	
	end process state_machine_process;
	
end architecture RTL;


	-- read_process : process(clk, reset_n) is
	-- begin
		-- if reset_n = '0' then
			-- read_data <= (others => '0');
		-- elsif rising_edge(clk) then
			-- if chip_select = '1' and read = '1' then
				-- case address is
					-- when "010" =>
						-- read_data <= (31 downto 1 => '0') & busy;
					-- when "100" =>
						-- read_data <= address_dma_reg;
					-- when others => null;
				-- end case;
			-- end if;
		-- end if;
	-- end process read_process;

	-- write_process : process(clk, reset_n) is
	-- begin
		-- if reset_n = '0' then
			-- start_single <= '0';
			-- data_cmd_n   <= '0';
			-- data_in      <= (others => '0');
			-- lcd_on       <= '0';
			-- lcd_reset_n  <= '1';
			-- start_dma    <= '0';
			-- address_dma  <= (others => '0');
			-- address_dma_reg <= (others => '0');
			-- len_dma      <= (others => '0');
		-- elsif rising_edge(clk) then
			-- start_single <= '0';
			-- data_cmd_n   <= '0';
			-- data_in      <= (others => '0');
			-- lcd_reset_n  <= '1';
			-- start_dma    <= '0';
			-- if chip_select = '1' and write = '1' then
				-- case address is
					-- when "000" =>
						-- start_single <= '1';
						-- data_cmd_n   <= '0';
						-- data_in      <= write_data(15 downto 0);
					-- when "001" =>
						-- start_single <= '1';
						-- data_cmd_n   <= '1';
						-- data_in      <= write_data(15 downto 0);
					-- when "011" =>
						-- lcd_on      <= write_data(0);
						-- lcd_reset_n <= write_data(1);
					-- when "100" =>
						-- address_dma <= write_data;
						-- address_dma_reg <= write_data;
					-- when "101" =>
						-- len_dma   <= write_data;
						-- start_dma <= '1';
					-- when others => null;
				-- end case;
			-- end if;
		-- end if;
	-- end process write_process;
