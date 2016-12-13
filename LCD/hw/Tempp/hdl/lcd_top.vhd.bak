library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lcd_top is
	port(
		clk              : in  std_logic;
		rst_n          : in  std_logic;

		-- LCD controller signals
		CS_n : out std_logic;
		DC_n: out std_logic;
		Wr_n: out std_logic;
		Rd_n: out std_logic;
		D: out std_logic_vector(15 downto 0);

		-- Avalon slave signals
		AS_Address  : in  std_logic_vector(1 downto 0);
		AS_ChipSelect : in  std_logic;
		AS_Wr : in  std_logic;
		AS_WrData : in  std_logic_vector(31 downto 0);
		AS_Rd : in  std_logic;
		AS_RdData : out  std_logic_vector(31 downto 0);
		AS_IRQ : out  std_logic;
		AS_WaitRequest : out  std_logic;

		-- Avalon master signals
		AM_Address: out  std_logic_vector(31 downto 0);
		AM_ByteEnable: out  std_logic_vector(3 downto 0);
		AM_RdDataValid: in  std_logic;
		AM_BurstCount: out  std_logic_vector(7 downto 0);
		AM_Rd : out std_logic;
		AM_RdData: in  std_logic_vector(31 downto 0);
		AM_WaitRequest: in  std_logic

	);
end entity lcd_top;

architecture rtl of lcd_top is
	--  Slave <-> LCD controller
	signal LS_Busy : std_logic;
	signal LS_DC_n : std_logic;
	signal LS_Wr_n : std_logic;
	signal LS_Rd_n : std_logic;
	signal LS_WrData : std_logic_vector(15 downto 0);
	signal LS_RdData : std_logic_vector(15 downto 0);

	-- LCD controller <-> FIFO
	signal FIFO_Empty : std_logic;
	signal FIFO_Almost_Empty : std_logic;
	signal FIFO_Rd : std_logic;
	signal FIFO_RdData : std_logic_vector(31 downto 0);

	-- Master <-> FIFO
	signal FIFO_Full : std_logic;
	signal FIFO_Almost_Full : std_logic;
	signal FIFO_Wr : std_logic;
	signal FIFO_WrData : std_logic_vector(31 downto 0);

	-- Master <-> LCD controller
	signal ML_Busy : std_logic;

	-- Master <-> Slave
	signal MS_Address  : std_logic_vector(31 downto 0);
	signal MS_Length   : std_logic_vector(31 downto 0);
	signal MS_StartDMA : std_logic;
begin
	CTRL : entity work.lcd_controller
		port map(clk          => clk,
			     rst_n      => rst_n,

			     -- LCD
			     CS_n      => CS_n,
			     DC_n  => DC_n,
			     Wr_n         => Wr_n,
			     Rd_n        => Rd_n,
			     D    => D,

			     -- Slave
			     LS_DC_n   => LS_DC_n,
			     LS_Wr_n  => LS_Wr_n,
			     LS_WrData => LS_WrData,
			     LS_Rd_n       => LS_Rd_n,
			     LS_RdData => LS_RdData,
			     LS_Busy => LS_Busy,

			     -- Master
			     ML_Busy   => ML_Busy,

			     -- FIFO
			     FIFO_Rd      => FIFO_Rd,
			     FIFO_RdData         => FIFO_RdData,
			     FIFO_Empty    => FIFO_Empty);

	MAST : entity work.lcd_master
		port map(clk          => clk,
			     rst_n      => rst_n,
			     
			     -- Avalon slave
			     MS_Address => MS_Address,
			     MS_StartDMA => MS_StartDMA,

			     -- LCD controller
			     ML_Busy => ML_Busy,

			     -- FIFO
			     FIFO_Full => FIFO_Full,
			     FIFO_Wr => FIFO_Wr,
			     FIFO_WrData => FIFO_WrData,
			     FIFO_Almost_Full => FIFO_Almost_Full,

			    -- Avalon bus
			     AM_Address => AM_Address,
			     AM_ByteEnable => AM_ByteEnable,
			     AM_Rd => AM_Rd,
			     AM_RdDataValid => AM_RdDataValid,
			     AM_RdData => AM_RdData,
			     AM_BurstCount => AM_BurstCount,
			     AM_WaitRequest => AM_WaitRequest


			     );						
				

	SLAV : entity work.lcd_slave
		port map(clk          => clk,
			     rst_n      => rst_n,
			     
			     -- Avalon slave
			     MS_Address => MS_Address,
				 MS_Length => MS_Length,
			     MS_StartDMA => MS_StartDMA,
	
			     -- LCD controller
			     LS_DC_n   => LS_DC_n,
			     LS_Wr_n  => LS_Wr_n,
			     LS_WrData => LS_WrData,
			     LS_RdData => LS_RdData,
			     LS_Rd_n       => LS_Rd_n,
			     LS_Busy => LS_Busy,

			    --  Avalon bus
			    AS_Address => AS_Address,
			    AS_ChipSelect => AS_ChipSelect,
			    AS_Wr => AS_Wr,
			    AS_WrData => AS_WrData,
			    AS_Rd => AS_Rd,
			    AS_RdData => AS_RdData,
			    AS_IRQ => AS_IRQ,
			    AS_WaitRequest => AS_WaitRequest

			     );			


	FIFO : entity work.lcd_fifo
		port map(
			clock		=> clk ;
			data		=> FIFO_WrData;
			rdreq		=> FIFO_Rd;
			wrreq		=> FIFO_Wr;
			almost_full		=> FIFO_Almost_Full;
			empty		=> FIFO_Empty;
			full		=> FIFO_Full;
			q		=> FIFO_RdData;
		);	
				
end architecture rtl;