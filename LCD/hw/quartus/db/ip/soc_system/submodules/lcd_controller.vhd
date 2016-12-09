library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lcd_controller is
	port(
		clk         : in  std_logic;
		rst_n         : in  std_logic;

		-- LCD
		CS_n        : out std_logic;
		DC_n        : out std_logic;
		Wr_n        : out std_logic;
		Rd_n        : out std_logic;
		D           : out std_logic_vector(15 downto 0) := (others => '0'); -- should become inout!

		-- Avalon Slave
		LS_DC_n     : in  std_logic;
		LS_Wr_n       : in  std_logic;
		LS_WrData   : in  std_logic_vector(15 downto 0);
		LS_RdData   : out std_logic_vector(15 downto 0);
		LS_Rd_n       : in  std_logic;
		LS_Busy     : out std_logic;

		-- Master
		ML_Busy     : in  std_logic;

		-- FIFO 
		FIFO_Rd     : out std_logic;
		FIFO_RdData : in  std_logic_vector(31 downto 0);
		FIFO_Empty  : in  std_logic
	);

	constant NEW_FRAME_CMD : std_logic_vector(15 downto 0) := "0000000000101100"; -- 0x2C

	signal curr_word_reg, curr_word_next : std_logic_vector(31 downto 0);
end entity lcd_controller;

architecture rtl of lcd_controller is
	type state_type is (IDLE, WRITE_CMD, READ_CMD_DUMMY, READ_CMD, NEW_FRAME, WAIT_FIFO, WRITE_PIXEL, WRITE_PIXEL_SECOND);
	signal state_reg, state_next : state_type;
	signal phase_reg, phase_next : natural;

begin
	LS_Busy <= '0' when state_reg = IDLE else '1';

	update_state : process(clk, rst_n) is
	begin
		if rst_n = '0' then
			state_reg <= IDLE;
			phase_reg <= 0;

		elsif rising_edge(clk) then
			state_reg <= state_next;
			phase_reg <= phase_next;
			curr_word_reg <= curr_word_next;
		end if;
	end process;

	process(state_reg, phase_reg, LS_Wr_n, LS_Rd_n, LS_WrData, ML_Busy, FIFO_RdData, FIFO_Empty, LS_DC_n) is
		variable curr_word : std_logic_vector(31 downto 0);

		procedure do_write(vDC_n : in std_logic; vData : in std_logic_vector(15 downto 0); state_target : in state_type) is
		begin
			phase_next <= phase_reg + 1;
			case phase_reg is
				when 0 =>
					DC_n <= vDC_n;
					D    <= vData;
					CS_n <= '0';
					Wr_n <= '0';
					Rd_n <= '1';
				when 1 =>
					DC_n <= vDC_n;
					D    <= vData;
					CS_n <= '0';
					Wr_n <= '0';
					Rd_n <= '1';
				when 2 =>
					DC_n <= vDC_n;
					D    <= vData;
					CS_n <= '0';
					Wr_n <= '1';
					Rd_n <= '1';
				when 3      =>
					DC_n <= vDC_n;
					D    <= vData;
					CS_n <= '0';
					Wr_n <= '1';
					Rd_n <= '1';

				when others =>          -- when 4 or more
					--d          <= (others => '0');
					DC_n	   <= vDC_n;
					CS_n       <= '1';
					Wr_n       <= '1';
					Rd_n       <= '1';
					state_next <= state_target;
					phase_next <= 0;
			end case;
		end procedure;

	begin
		-- prevent latches
		state_next <= state_reg;
		phase_next <= phase_reg;

		FIFO_Rd    <= '0';
		CS_n       <= '0';
		DC_n       <= '0';
		Wr_n       <= '0';
		Rd_n       <= '0';
		D          <= (others => '0');
		LS_RdData  <= (others => '0');
		
		
		case state_reg is
			-- idle
			when IDLE =>
				if LS_Wr_n = '0' then
					state_next <= WRITE_CMD;
				end if;

				if LS_Rd_n = '0' then
					state_next <= READ_CMD;
				end if;

				if ML_Busy = '1' then
					state_next <= NEW_FRAME;
				end if;

			-- write command
			when WRITE_CMD =>
				do_write(LS_DC_n, LS_WrData, IDLE);

			-- read command (dummy)
			when READ_CMD_DUMMY =>
				state_next <= IDLE;

			-- read command
			when READ_CMD =>
				state_next <= IDLE;

			-- new frame cmd
			when NEW_FRAME =>
				do_write('0', NEW_FRAME_CMD, WAIT_FIFO);

			-- wait FIFO
			when WAIT_FIFO =>
				if FIFO_Empty = '0' then -- still pixels available
					FIFO_Rd    <= '1';
					state_next <= WRITE_PIXEL;
				end if;

				if FIFO_Empty = '1' and ML_Busy = '0' then -- whole frame is processed
					state_next <= IDLE;
				end if;

			-- Write Pixel
			when WRITE_PIXEL =>
				FIFO_Rd   <= '0';
				curr_word_next <= FIFO_RdData;
				do_write('0', FIFO_RdData(15 downto 0), WRITE_PIXEL_SECOND);

			-- write SECOND pixel
			when WRITE_PIXEL_SECOND =>
				do_write('0', curr_word(31 downto 16), WAIT_FIFO);

		end case;
	end process;
end architecture rtl;
