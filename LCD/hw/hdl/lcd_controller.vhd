library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lcd_controller is
	port(
		clk         : in  std_logic;
		rst_n         : in  std_logic;

		-- LCD
		CS_n        : out std_logic := '1';
		DC_n        : out std_logic := '1';
		Wr_n        : out std_logic := '1';
		Rd_n        : out std_logic := '1';
		D           : inout std_logic_vector(15 downto 0) := (others => '0'); -- should become inout!
		LCD_ON : out std_logic := '1';
		RESET_N : out std_logic := '1';

		-- Avalon Slave
		LS_DC_n     : in  std_logic;
		LS_Wr_n       : in  std_logic;
		LS_WrData   : in  std_logic_vector(15 downto 0);
		LS_RdData   : out std_logic_vector(15 downto 0) := (others => '0');
		LS_Rd_n       : in  std_logic;
		LS_Busy     : out std_logic := '0';

		-- Master
		ML_Busy     : in  std_logic;

		-- FIFO 
		FIFO_Rd     : out std_logic := '0';
		FIFO_RdData : in  std_logic_vector(31 downto 0);
		FIFO_Empty  : in  std_logic
	);

	constant NEW_FRAME_CMD : std_logic_vector(15 downto 0) := "0000000000101100"; -- 0x2C

	signal curr_word_reg, curr_word_next : std_logic_vector(31 downto 0);
end entity lcd_controller;

architecture rtl of lcd_controller is
	type state_type is (RESET_LCD, IDLE, WRITE, READ_DUMMY, READ, NEW_FRAME, WAIT_FIFO, WRITE_PIXEL, WRITE_PIXEL_SECOND);
	signal state_reg, state_next : state_type;
	signal phase_reg, phase_next : natural;
	signal dcn_reg, dcn_next, wrn_next, wrn_reg, rdn_next, rdn_reg , csn_next, csn_reg, fiford_reg, fiford_next: std_logic;
	signal d_next, d_reg, lsrddata_reg, lsrddata_next: std_logic_vector(15 downto 0);
	signal flipper: std_logic := '0';
begin
	LS_Busy <= '0' when state_reg = IDLE else '1';
	
	--LCD_ON <= flipper;
	--RESET_N <= flipper;
	--DC_n <= flipper;
	DC_n <= dcn_reg;
	Wr_n <= wrn_reg;
	Rd_n <= rdn_reg;
	CS_n <= csn_reg;
	FIFO_Rd <= fiford_reg;
	LS_RdData <= lsrddata_reg;
	D <= d_reg;
	
	update_state : process(clk, rst_n) is
	begin
		if rst_n = '0' then
			state_reg <= IDLE;
			phase_reg <= 0;
			dcn_reg <= '1';
			dcn_reg <= '1';
			wrn_reg <= '1';
			rdn_reg <= '1';
			csn_reg <= '1';
			fiford_reg <= '0';
			lsrddata_reg <= (others => '0');
			d_reg <= (others => '0');

		elsif rising_edge(clk) then
			state_reg <= state_next;
			phase_reg <= phase_next;
			curr_word_reg <= curr_word_next;
			dcn_reg <= dcn_next;
			wrn_reg <= wrn_next;
			rdn_reg <= rdn_next;
			csn_reg <= csn_next;
			d_reg <= d_next;
			fiford_reg <= fiford_next;
			lsrddata_reg <= lsrddata_next;
			flipper <= not flipper;
		end if;
	end process;

	process(state_reg, phase_reg, LS_Wr_n, LS_Rd_n, LS_WrData, ML_Busy, FIFO_RdData, FIFO_Empty, LS_DC_n) is

		procedure do_write(vDC_n : in std_logic; vData : in std_logic_vector(15 downto 0); state_target : in state_type) is
		begin
			phase_next <= phase_reg + 1;
			case phase_reg is
				when 0 =>
					d_next <= vData;
					dcn_next <= vDC_n;
					wrn_next <= '0';
					rdn_next <= '1';
					csn_next <= '0';
				when 1 =>
					
				when 2 =>
					wrn_next <= '1';
				when 3      =>
					

				when others =>          -- when 4 or more
					csn_next <= '1';
					d_next <= (others => '0'); -- not really needed but nicer to reset all signals
					dcn_next <= '1'; 
					wrn_next <= '1';
					rdn_next <= '1';
					
					state_next <= state_target;
					phase_next <= 0;
			end case;
		end procedure;
		
		procedure do_read(vDC_n : in std_logic; state_target : in state_type) is
		begin
			phase_next <= phase_reg + 1;
			case phase_reg is
				when 0 =>
					dcn_next <= vDC_n;
					wrn_next <= '1';
					rdn_next <= '0';
					csn_next <= '0';
				when 1 =>
					
				when 2 =>
					rdn_next <= '1';
					lsrddata_next <= D;
				when 3      =>
					

				when others =>          -- when 4 or more
					csn_next <= '1';
					dcn_next <= '1'; 
					wrn_next <= '1';
					rdn_next <= '1';					
					state_next <= state_target;
					phase_next <= 0;
			end case;
		end procedure;

	begin
		-- prevent latches
		state_next <= state_reg;
		phase_next <= phase_reg;
		dcn_next <= dcn_reg;
		wrn_next <= wrn_reg;
		rdn_next <= rdn_reg;
		csn_next <= csn_reg;
		d_next <= d_reg;
		fiford_next <= fiford_reg;
		curr_word_next <= curr_word_reg;
		lsrddata_next <= lsrddata_reg;

		RESET_N <= '1';
		LS_RdData  <= (others => '0');
		
		
		case state_reg is

			-- reset LCD
			when RESET_LCD =>
				RESET_N <= '0';
				state_next <= IDLE;

			-- idle
			when IDLE =>
				if LS_Wr_n = '0' then
					state_next <= WRITE;
					do_write(LS_DC_n, LS_WrData, IDLE);
				end if;

				if LS_Rd_n = '0' then
					state_next <= READ_DUMMY;
					do_read(dcn_reg, READ);
				end if;

				if ML_Busy = '1' then
					state_next <= NEW_FRAME;
				end if;
				
				

			-- write command
			when WRITE =>
				if LS_WrData = "1000000000000000" then
					state_next <= RESET_LCD;
				else
					do_write(dcn_reg, LS_WrData, IDLE);
				end if;

			-- read command (dummy)
			when READ_DUMMY =>
				do_read(dcn_reg, READ);
				--state_next <= IDLE;

			-- read command
			when READ =>
				do_read(dcn_reg, READ);
				--state_next <= IDLE;

			-- new frame cmd
			when NEW_FRAME =>
				do_write('0', NEW_FRAME_CMD, WAIT_FIFO);

			-- wait FIFO
			when WAIT_FIFO =>
				if FIFO_Empty = '0' then -- still pixels available
					fiford_next    <= '1';
					state_next <= WRITE_PIXEL;
				end if;

				if FIFO_Empty = '1' and ML_Busy = '0' then -- whole frame is processed
					state_next <= IDLE;
				end if;

			-- Write Pixel
			when WRITE_PIXEL =>
				fiford_next   <= '0';
				curr_word_next <= FIFO_RdData;
				do_write('0', FIFO_RdData(15 downto 0), WRITE_PIXEL_SECOND);

			-- write SECOND pixel
			when WRITE_PIXEL_SECOND =>
				do_write('0', curr_word_reg(31 downto 16), WAIT_FIFO);

		end case;
	end process;
end architecture rtl;

--
--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--
--entity lcd_controller is
--	port(
--		clk         : in  std_logic;
--		rst_n         : in  std_logic;
--
--		-- LCD
--		CS_n        : out std_logic := '1';
--		DC_n        : out std_logic := '1';
--		Wr_n        : out std_logic := '1';
--		Rd_n        : out std_logic := '1';
--		D           : out std_logic_vector(15 downto 0) := (others => '0'); -- should become inout!
--		LCD_ON : out std_logic := '1';
--		RESET_N : out std_logic := '1';
--
--		-- Avalon Slave
--		LS_DC_n     : in  std_logic;
--		LS_Wr_n       : in  std_logic;
--		LS_WrData   : in  std_logic_vector(15 downto 0);
--		LS_RdData   : out std_logic_vector(15 downto 0) := (others => '0');
--		LS_Rd_n       : in  std_logic;
--		LS_Busy     : out std_logic := '0';
--
--		-- Master
--		ML_Busy     : in  std_logic;
--
--		-- FIFO 
--		FIFO_Rd     : out std_logic := '0';
--		FIFO_RdData : in  std_logic_vector(31 downto 0);
--		FIFO_Empty  : in  std_logic
--	);
--
--	constant NEW_FRAME_CMD : std_logic_vector(15 downto 0) := "0000000000101100"; -- 0x2C
--
--	signal curr_word_reg, curr_word_next : std_logic_vector(31 downto 0);
--end entity lcd_controller;
--
--architecture rtl of lcd_controller is
--	type state_type is (RESET_LCD, IDLE, WRITE_CMD, READ_CMD_DUMMY, READ_CMD, NEW_FRAME, WAIT_FIFO, WRITE_PIXEL, WRITE_PIXEL_SECOND);
--	signal state_reg, state_next : state_type;
--	signal phase_reg, phase_next : natural;
--	signal dcn_reg, dcn_next: std_logic;
--	signal flipper: std_logic := '0';
--begin
--	LS_Busy <= '0' when state_reg = IDLE else '1';
--	
--	--LCD_ON <= flipper;
--	--RESET_N <= flipper;
--	--DC_n <= flipper;
--	DC_n <= dcn_next;
--	
--	update_state : process(clk, rst_n) is
--	begin
--		if rst_n = '0' then
--			state_reg <= IDLE;
--			phase_reg <= 0;
--			dcn_reg <= '0';
--
--		elsif rising_edge(clk) then
--			state_reg <= state_next;
--			phase_reg <= phase_next;
--			curr_word_reg <= curr_word_next;
--			dcn_reg <= dcn_next;
--			flipper <= not flipper;
--		end if;
--	end process;
--
--	process(state_reg, phase_reg, LS_Wr_n, LS_Rd_n, LS_WrData, ML_Busy, FIFO_RdData, FIFO_Empty, LS_DC_n) is
--
--		procedure do_write(vData : in std_logic_vector(15 downto 0); state_target : in state_type) is
--		begin
--			phase_next <= phase_reg + 1;
--			case phase_reg is
--				when 0 =>
--					D    <= vData;
--					CS_n <= '0';
--					Wr_n <= '0';
--					Rd_n <= '1';
--				when 1 =>
--					D    <= vData;
--					CS_n <= '0';
--					Wr_n <= '0';
--					Rd_n <= '1';
--				when 2 =>
--					D    <= vData;
--					CS_n <= '0';
--					Wr_n <= '1';
--					Rd_n <= '1';
--				when 3      =>
--					D    <= vData;
--					CS_n <= '0';
--					Wr_n <= '1';
--					Rd_n <= '1';
--
--				when others =>          -- when 4 or more
--					--d          <= (others => '0');
--					CS_n       <= '1';
--					Wr_n       <= '1';
--					Rd_n       <= '1';
--					state_next <= state_target;
--					phase_next <= 0;
--			end case;
--		end procedure;
--
--	begin
--		-- prevent latches
--		state_next <= state_reg;
--		phase_next <= phase_reg;
--		dcn_next <= dcn_reg;
--		curr_word_next <= curr_word_reg;
--
--		FIFO_Rd    <= '0';
--		CS_n       <= '1';
--		Wr_n       <= '1';
--		Rd_n       <= '1';
--		RESET_N <= '1';
--		D          <= (others => '0');
--		LS_RdData  <= (others => '0');
--		
--		
--		case state_reg is
--
--			-- reset LCD
--			when RESET_LCD =>
--				RESET_N <= '0';
--				state_next <= IDLE;
--
--			-- idle
--			when IDLE =>
--				if LS_Wr_n = '0' then
--					dcn_next <= LS_DC_n;
--					state_next <= WRITE_CMD;
--				end if;
--
--				if LS_Rd_n = '0' then
--					dcn_next <= LS_DC_n;
--					state_next <= READ_CMD;
--				end if;
--
--				if ML_Busy = '1' then
--					state_next <= NEW_FRAME;
--				end if;
--				
--				
--
--			-- write command
--			when WRITE_CMD =>
--				if LS_WrData = "1000000000000000" then
--					state_next <= RESET_LCD;
--				else
--					do_write(LS_WrData, IDLE);
--				end if;
--
--			-- read command (dummy)
--			when READ_CMD_DUMMY =>
--				state_next <= IDLE;
--
--			-- read command
--			when READ_CMD =>
--				state_next <= IDLE;
--
--			-- new frame cmd
--			when NEW_FRAME =>
--				dcn_next <= '0';
--				do_write(NEW_FRAME_CMD, WAIT_FIFO);
--
--			-- wait FIFO
--			when WAIT_FIFO =>
--				if FIFO_Empty = '0' then -- still pixels available
--					FIFO_Rd    <= '1';
--					state_next <= WRITE_PIXEL;
--				end if;
--
--				if FIFO_Empty = '1' and ML_Busy = '0' then -- whole frame is processed
--					state_next <= IDLE;
--				end if;
--
--			-- Write Pixel
--			when WRITE_PIXEL =>
--				FIFO_Rd   <= '0';
--				curr_word_next <= FIFO_RdData;
--				dcn_next <= '0';
--				do_write(FIFO_RdData(15 downto 0), WRITE_PIXEL_SECOND);
--
--			-- write SECOND pixel
--			when WRITE_PIXEL_SECOND =>
--				dcn_next <= '0';
--				do_write(curr_word_reg(31 downto 16), WAIT_FIFO);
--
--		end case;
--	end process;
--end architecture rtl;

