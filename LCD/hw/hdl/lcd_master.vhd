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
	signal state_reg, state_next                    : state_type := IDLE;
	signal addr_reg,addr_next	    	          	: std_logic_vector(31 downto 0) := (others => '0');
	signal len_reg,len_next  			        	: std_logic_vector(31 downto 0) := (others => '0'); --:= "00000000000000001001011000000000";
	
	signal burst_counter_reg, burst_counter_next	: integer := 0; --2399 if end test
	signal word_counter_reg, word_counter_next		: integer := 0;
	
	
	--  len_reg       normally = (320/2)*240 = 38400
	signal BURST_LENGTH				                : integer := 16;	      --constant = 16
	signal BURST_COUNT		       			        : integer := 0;	      -- = len_reg / BURST_LENGTH
	
begin

	--Handle reset procedure and state_reg changes
	run_process : process(clk, rst_n) is
	begin
		if rst_n = '0' then
			state_reg <= IDLE;
			addr_reg <= (others => '0');
			len_reg <= (others => '0');
			burst_counter_reg <= 0; --2399 if test end
			word_counter_reg <= 0;			
			
		elsif rising_edge(clk) then
			state_reg <= state_next;
			addr_reg <= addr_next;	
			len_reg <= len_next;
			burst_counter_reg <= burst_counter_next;
			word_counter_reg <= word_counter_next;
			
		end if;
	end process run_process;

	-- combinatorial state machine process
	state_machine_process : process(AM_RdDataValid, AM_RdData, AM_WaitRequest, MS_Address, MS_Length, MS_StartDMA, FIFO_Full, FIFO_Almost_Full, 
									state_reg, addr_reg, len_reg, burst_counter_reg, word_counter_reg, BURST_COUNT, BURST_LENGTH) is
	begin
		-- avoid latches 
		state_next <= state_reg;
		addr_next <= addr_reg;
		len_next <= len_reg;
		burst_counter_next <= burst_counter_reg;
		word_counter_next <= word_counter_reg;	
		
		--INIT
		AM_Address <= (others => '0');
		AM_ByteEnable <= "1111";-- need all 4 words  maybe useless since we're doing only read(others => '0');
		AM_Rd <= '0';
		AM_Burstcount <= (others => '0');
		ML_Busy <= '0';
		FIFO_Wr <= '0';
		FIFO_WrData <= (others => '0');
		
		BURST_COUNT <= to_integer(unsigned(len_reg))/BURST_LENGTH;
		
		case state_reg is	
		
			-- STATE IDLE
			when IDLE =>				
				if MS_StartDMA = '1' then
					addr_next <= MS_Address;
					len_next <= MS_Length;
					--ML_Busy <= '1';
					state_next <= READING;				
				end if;	
				
			-- STATE READING
			when READING =>			
				ML_Busy <= '1';
				
				-- if all bursts done (whole frame written to FIFO)
				if (burst_counter_reg = BURST_COUNT) then					
					burst_counter_next <= 0;	
					ML_Busy <= '0'; -- will be done anyway, but a bit faster to do it there
					state_next <= IDLE;		
				
				-- frame not done yet and fifo still has place for a burst
				elsif (FIFO_Almost_Full = '0') then
					AM_Address <= addr_reg;
					AM_Burstcount <= std_logic_vector(to_unsigned(BURST_LENGTH,8));
					AM_Rd <= '1';					
					if (AM_WaitRequest = '0') then
						state_next <= RECEIVING;	
					end if;
				end if;	
				
			-- STATE RECEIVING
			when RECEIVING =>
				AM_Rd <= '0';
				ML_Busy <= '1';
				
				-- if full burst received
				if (word_counter_reg = BURST_LENGTH) then
					word_counter_next <= 0;
					burst_counter_next <= burst_counter_reg + 1;
					addr_next <= std_logic_vector(to_unsigned(to_integer(unsigned(addr_reg)) + BURST_LENGTH*4, 32));
					state_next <= READING;
					
				-- still receiving burst
				else
				
					-- give signals to FIFO
					FIFO_Wr <= AM_RdDataValid;
					FIFO_WrData <= AM_RdData;
					
					-- if this is a valid read, increment word counter
					if (AM_RdDataValid = '1') then
						word_counter_next <= word_counter_reg + 1;
					end if;
				end if;	
				
			when others => null;
		end case;	
	end process state_machine_process;
end architecture RTL;

	