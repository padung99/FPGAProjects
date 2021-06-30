library ieee;
use ieee.std_logic_1164.all;

--- frequency 50MHz

entity uart_receiver_tb is
generic(clk_per_bit: integer := 435);
end  uart_receiver_tb;

architecture test of uart_receiver_tb is

component led_blink is

generic(N: integer := 1500);
port(
		i_rx_test: in std_logic;
		clk: in std_logic;
		led_number: out std_logic_vector(6 downto 0);
		dig_led: out std_logic_vector(3 downto 0)
		);
end component;
--component UART_RX is
--  generic (
--    g_CLKS_PER_BIT : integer := 173     -- Needs to be set correctly
--    );
--  port (
--    i_Clk       : in  std_logic;
--    i_RX_Serial : in  std_logic;
--    o_RX_DV     : out std_logic;
--    o_RX_Byte   : out std_logic_vector(7 downto 0)
--    );
--end component;
--component uart_receiver is
--generic(clk_per_bit: integer := 173);
--port(
--		clk: in std_logic;
--		o_stop: out std_logic;
--		i_rx: in std_logic;
--		o_rx: out std_logic_vector(7 downto 0)
--		);
--end component;

constant clk_per: time := 0.050 ns;
signal clk, i_rx, o_stop: std_logic;
signal o_rx: std_logic_vector(7 downto 0);
signal o_data: std_logic_vector(7 downto 0);
signal button: std_logic;
signal led, led_num, dig_led: std_logic_vector(3 downto 0);
signal led_number: std_logic_vector(6 downto 0);

begin
create_clk: process
					begin
						clk <= '1';
						wait for clk_per/2;
						clk <= '0';
						wait for clk_per/2;
				end process;
				
create_input: process
					begin						
						i_rx <= '0';
						
						wait for (clk_per_bit)*0.050 ns;
						
						i_rx <= '1';
						wait for (clk_per_bit)*0.050 ns;
						
						i_rx <= '1';
						wait for (clk_per_bit)*0.050 ns;
						
						i_rx <= '0';
						wait for (clk_per_bit)*0.050 ns;
						
						i_rx <= '1';
						wait for (clk_per_bit)*0.050 ns;
						
						i_rx <= '1';
						wait for (clk_per_bit)*0.050 ns;
						
						i_rx <= '1';
						wait for (clk_per_bit)*0.050 ns;
						
						i_rx <= '0';
						wait for (clk_per_bit)*0.050 ns;
						
						i_rx <= '0';
						wait  for (clk_per_bit)*0.050 ns;
						
						i_rx <= '1';
						wait;
						
--						button <= '1';
--						wait for 0.05 ns;
--						button <= '0';
				end process;
	
DUT: component led_blink 
port map(i_rx_test => i_rx,
			clk => clk,
			led_number => led_number,
			dig_led => dig_led
			);
--  DUT: component UART_RX 
--  port map(i_clk => clk,
--			  i_RX_Serial => i_rx,
--			  o_RX_DV => o_stop,
--			  o_RX_Byte => o_rx);
  

--DUT: component uart_receiver
--port map( clk => clk, 
--			o_stop => o_stop,
--			i_rx => i_rx,
--			o_rx =>o_rx);
end test;


					