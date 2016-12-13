library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LCD_Master is
	port(	
		clk                : in  std_logic;
		rst_n              : in  std_logic;
		
		-- Avalon bus signals
		AM_Address         : out std_logic_vector(31 downto 0);
		AM_ByteEnable 	   : out std_logic_vector(3 downto 0);		
		AM_Rd              : out std_logic;
		AM_RdDataValid     : in  std_logic;
		AM_Burstcount      : out std_logic_vector(7 downto 0);	
		AM_RdData          : in  std_logic_vector(31 downto 0);	
		AM_WaitRequest     : in  std_logic;
		
		-- Slave signals
		MS_Address         : in  std_logic_vector(31 downto 0);
		MS_Length          : in  std_logic_vector(31 downto 0);
		MS_StartDMA        : in  std_logic;
		
		-- LCD Controller signals
		ML_Busy            : out std_logic;
		
		-- FIFO signals
		FIFO_Full          : in  std_logic;
		FIFO_Wr            : out std_logic;
		FIFO_WrData        : out std_logic_vector(31 downto 0);
		FIFO_Almost_Full   : in  std_logic		
	);
end entity LCD_Master;

architecture RTL of LCD_Master is
	type state_type is (IDLE, READING, RECEIVING);
	signal state, next_state             	: state_type := IDLE;
	signal addr_reg	    					: std_logic_vector(31 downto 0) := (others => '0');
	signal len_reg	    					: std_logic_vector(31 downto 0) := (others => '0'); --:= "00000000000000001001011000000000";
	
	signal burst_counter 					: integer := 0;
	signal word_counter						: integer := 0;
	
	--  len_reg       normally = (320/2)*240 = 38400
	signal BURST_LENGTH				        : integer := 16;	      --constant = 16
	signal BURST_COUNT		       			: integer := 0;	      -- = len_reg / BURST_LENGTH
	
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

	state_machine : process(AM_RdDataValid, AM_RdData, AM_WaitRequest, MS_Address, MS_Length, MS_StartDMA, FIFO_Full, FIFO_Almost_Full, state) is
	begin
		-- avoid latches 
		next_state <= state;
		BURST_COUNT <= to_integer(unsigned(len_reg))/BURST_LENGTH;
		
		case state is	
			when IDLE =>
				--INIT
				AM_Address <= (others => '0');
				AM_ByteEnable <= (others => '0');
				AM_Rd <= '0';
				AM_Burstcount <= (others => '0');
				ML_Busy <= '0';
				FIFO_Wr <= '0';
				FIFO_WrData <= (others => '0');
				--END INIT
				
				if MS_StartDMA = '1' then
					addr_reg <= MS_Address;
					len_reg <= MS_Length;					
					burst_counter <= 0;
					next_state <= READING;				
				end if;	
				
			when READING =>
				ML_Busy <= '1';
				if (burst_counter = BURST_COUNT) then				
					next_state <= IDLE;					
				elsif (FIFO_Almost_Full = '0') then
					word_counter <= 0;
					AM_Address <= addr_reg;
					AM_Burstcount <= std_logic_vector(to_unsigned(BURST_LENGTH,8));
					AM_Rd <= '1';					
					if (AM_WaitRequest = '0') then
						next_state <= RECEIVING;	
					end if;
				end if;	
				
			when RECEIVING =>
				if (word_counter = BURST_LENGTH) then
					burst_counter <= burst_counter + 1;
					addr_reg <= std_logic_vector(to_unsigned(to_integer(unsigned(addr_reg)) + BURST_LENGTH, 32));
					next_state <= READING;
				else
					FIFO_Wr <= AM_RdDataValid;
					FIFO_WrData <= AM_RdData;
					if (AM_RdDataValid = '1') then
						burst_counter <= burst_counter + 1;
					end if;
				end if;	
			when others => null;
		end case;	
	end process state_machine;
end architecture RTL;

	