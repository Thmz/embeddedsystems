library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--TODO set default value of output
entity LCD_Slave is
	port(
		clk             : in  std_logic;
		rst_n           : in  std_logic;
		
		-- Avalon bus signals
		AS_Address      : in  std_logic_vector(1 downto 0);
		AS_ChipSelect   : in  std_logic;		
		AS_Wr           : in  std_logic;
		AS_WrData       : in  std_logic_vector(31 downto 0);
		AS_Rd           : in std_logic;
		AS_RdData       : out std_logic_vector(31 downto 0) := (others => '0');
		AS_IRQ			: out std_logic := '0';
		AS_WaitRequest  : out std_logic := '0';
		
		-- LT24 Controller signals
		LS_Busy         : in  std_logic;
		LS_DC_n         : out std_logic := '1';
		LS_Wr_n         : out std_logic := '1';
		LS_Rd_n         : out std_logic := '1';
		LS_WrData       : out std_logic_vector(15 downto 0) := (others => '0');
		LS_RdData       : in  std_logic_vector(15 downto 0);		
		
		-- Master signals		
		MS_Address      : out std_logic_vector(31 downto 0) := (others => '0');		
		MS_Length       : out std_logic_vector(31 downto 0) := (others => '0');
		MS_StartDMA     : out std_logic := '0'
	);
end entity LCD_Slave;

architecture RTL of LCD_Slave is
	type state_type is (IDLE, READ, WRITE, ADDRESS, IRQ);
	signal state_reg, state_next        : state_type := IDLE;
	signal waitbusy_reg, waitbusy_next  : std_logic := '1';
	signal addr_reg, addr_next          : std_logic_vector(31 downto 0) := (others => '0');
	signal len_reg, len_next            : std_logic_vector(31 downto 0) := "00000000000000001001011000000000";	--38400 160*240
	
begin	
	
	--Handle reset procedure and state_reg changes
	run_process : process(clk, rst_n) is
	begin
		if rst_n = '0' then
			state_reg <= IDLE;
			waitbusy_reg <= '1'; 
			addr_reg <= (others => '0');
			len_reg <= "00000000000000001001011000000000";	--38400 160*240
		elsif rising_edge(clk) then
			state_reg <= state_next;
			addr_reg <= addr_next;
			len_reg <=  LS_Busy & len_next(30 downto 0);
			waitbusy_reg <= waitbusy_next;
		end if;
	end process run_process;
	

	--AS_WaitRequest <= '1' when (LS_Busy = '1') else '0';


	state_machine_process : process(AS_Address, AS_ChipSelect, AS_Wr, AS_WrData, AS_Rd, LS_Busy, LS_RdData, 
									state_reg, addr_reg, len_reg) is
	begin	
	-- avoid latches 
	state_next <= state_reg;
	waitbusy_next <= waitbusy_reg;
	addr_next <= addr_reg;
	len_next <= LS_Busy & len_reg(30 downto 0);
	
	--INIT
	AS_RdData <= (others => '0');
	AS_IRQ <= '0';
	LS_DC_n <= '1';
	LS_Wr_n <= '1';
	LS_Rd_n <= '1';
	LS_WrData <= (others => '0');
	MS_Address <= (others => '0');
	MS_Length <= (others => '0');
	MS_StartDMA <= '0';
	--END INIT	
	
	case state_reg is	
		when IDLE =>			
			if (AS_ChipSelect = '1') then
				if (AS_Rd = '1') then --read
					case AS_Address is
						when "00" => --cmd
						LS_Rd_n <= '0';
						LS_DC_n <= '0';
						state_next <= READ;
						
						when "01" => --data
						LS_Rd_n <= '0';
						LS_DC_n <= '1';
						state_next <= READ;
						
						when "10" => --addr
						AS_RdData <= addr_reg;
						
						when "11" => --len	
						AS_RdData <= len_reg;
						
						when others => null;						
					end case;
				elsif (AS_Wr = '1') then --write
					case AS_Address is
						when "00" => --cmd
						LS_Wr_n <= '0';
						LS_DC_n <= '0';
						state_next <= WRITE;
						
						when "01" => --data
						LS_Wr_n <= '0';
						LS_DC_n <= '1';
						state_next <= WRITE;
						
						when "10" => --addr
						addr_next <= AS_WrData;
						MS_Address <= AS_WrData;
						MS_StartDMA <= '1';
						state_next <= ADDRESS;
						
						when "11" => --len
						len_next <= AS_WrData;
						
						when others => null;						
					end case;
				end if;
			end if;
		
		-- ??? DOES LS_Busy go high soon enough  ->  solved with waitbusy signal ( wait that LS_Busy goes high at least once before check if it's low)
		when READ =>
			if(LS_Busy = '1') then
				waitbusy_next <= '0';
				LS_Rd_n <= '1';
			elsif (waitbusy_reg = '0') then
				state_next <= IDLE;
			end if;
		
		when WRITE =>
			if(LS_Busy = '1') then
				waitbusy_next <= '0';
				LS_Wr_n <= '1';
			elsif (waitbusy_reg = '0') then 
				state_next <= IDLE;
			end if;
		
		when ADDRESS =>
			if(LS_Busy = '1') then
				waitbusy_next <= '0';
				MS_StartDMA <= '0';
			elsif (waitbusy_reg = '0') then 
				AS_IRQ <= '1';
				state_next <= IRQ;
			end if;
			
		when IRQ =>		
			AS_IRQ <= '0';
			state_next <= IDLE;
		
		when others => null;		
		
	end case;
	
	end process state_machine_process;
	
end architecture RTL;

