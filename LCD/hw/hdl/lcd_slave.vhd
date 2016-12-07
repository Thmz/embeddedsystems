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
		AS_RdData       : out std_logic_vector(31 downto 0);
		AS_IRQ			: out std_logic;
		AS_WaitRequest  : out std_logic;
		
		-- LT24 Controller signals
		LS_Busy         : in  std_logic;
		LS_DC_n         : out std_logic;
		LS_Wr_n         : out std_logic;
		LS_Rd_n         : out std_logic;
		LS_WrData       : out std_logic_vector(15 downto 0);
		LS_RdData       : in  std_logic_vector(15 downto 0);		
		
		-- Master signals		
		MS_Address      : out std_logic_vector(31 downto 0);		
		MS_Length       : out std_logic_vector(31 downto 0);
		MS_StartDMA     : out std_logic
	);
end entity LCD_Slave;

architecture RTL of LCD_Slave is
	type state_type is (IDLE, READ, WRITE, ADDRESS, IRQ);
	signal state, next_state     : state_type := IDLE;
	signal addr_reg              : std_logic_vector(31 downto 0) := (others => '0');
	signal len_reg               : std_logic_vector(31 downto 0) := "00000000000000001001011000000000";
	
	
begin

	
	--Handle reset procedure and state changes
	run_process : process(clk, rst_n) is
	begin
		if rst_n = '0' then
			state <= IDLE;
		elsif rising_edge(clk) then
			state <= next_state;
		end if;
	end process run_process;
	
	state_machine_process : process(AS_Address, AS_ChipSelect, AS_Wr, AS_WrData, AS_Rd, LS_Busy, LS_RdData, state)
	-- avoid latches 
	next_state <= state;
	
	case state is	
		when IDLE =>
			--INIT
			AS_RdData <= (others => '0');
			AS_IRQ <= '0';
			AS_WaitRequest <= '0';
			LS_DC_n <= '1';
			LS_Wr_n <= '1';
			LS_Rd_n <= '1';
			LS_WrData <= (others => '0');
			MS_Address <= (others => '0');
			MS_Length <= (others => '0');
			MS_StartDMA <= '0';
			--END INIT
			
			if (AS_ChipSelect = '1') then
				if (AS_Rd = '1') then --read
					case AS_Address is
						when "00" => --cmd
						AS_WaitRequest <= '1';
						LS_Rd_n <= '0';
						LS_DC_n <= '0';
						next_state <= READ;
						
						when "01" => --data
						AS_WaitRequest <= '1';
						LS_Rd_n <= '0';
						LS_DC_n <= '1';
						next_state <= READ;
						
						when "10" => --addr
						AS_RdData <= addr_reg
						
						when "11" => --len	
						AS_RdData <= len_reg
						
						when others => null						
					end case;
				elsif (AS_Wr = '1') then --write
					case AS_Address is
						when "00" => --cmd
						AS_WaitRequest <= '1';
						LS_Wr_n <= '0';
						LS_DC_n <= '0';
						next_state <= WRITE;
						
						when "01" => --data
						AS_WaitRequest <= '1';
						LS_Wr_n <= '0';
						LS_DC_n <= '1';
						next_state <= WRITE;
						
						when "10" => --addr
						addr_reg <= AS_WrData;
						MS_Address <= AS_WrData;
						AS_WaitRequest <= '1';
						MS_StartDMA <= '1';
						next_state <= ADDRESS;
						
						when "11" => --len
						len_reg <= AS_WrData
						
						when others => null						
					end case;
				end if;
			end if;
		
		-- ??? DOES LS_Busy go high soon enough
		when READ =>
			if(LS_Busy = '1') then
				LS_Rd_n <= '1';
			else 
				AS_WaitRequest <= '0';
				next_state <= IDLE;
			end if;
		
		-- ??? DOES LS_Busy go high soon enough
		when WRITE =>
			if(LS_Busy = '1') then
				LS_Wr_n <= '1';
			else 
				AS_WaitRequest <= '0';
				next_state <= IDLE;
			end if;
		
		-- ??? DOES LS_Busy go high soon enough
		when ADDRESS =>
			if(LS_Busy = '1') then
				MS_StartDMA <= '0';
			else 
				AS_IRQ <= '1';
				next_state <= IRQ;
			end if;
			
		when IRQ =>		
			AS_IRQ <= '0';
			AS_WaitRequest <= '0';
			next_state <= IDLE;
		
		when others => null;
	end if;
	
	end process state_machine_process;
	
end architecture RTL;

