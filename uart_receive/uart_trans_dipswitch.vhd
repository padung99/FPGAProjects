library ieee;
use ieee.std_logic_1164.all;

entity uart_trans_dipswitch is
port(
		button: in std_logic;
		i_tx_data: in std_logic_vector(3 downto 0);
		o_tx_serial: out std_logic;
		clk: in std_logic
		);
end uart_trans_dipswitch;

architecture arch of uart_trans_dipswitch is

component uart_transmitter is
generic( clk_per_bit: integer := 434);

port(
		clk: in std_logic;
		i_tx_active: in std_logic; ----- button 
		i_tx_data: in std_logic_vector(7 downto 0);
		o_tx_serial: out std_logic;
		o_tx_active: out std_logic; -----
		o_tx_done: out std_logic ------
		);
end component;

component debounce is
port(
		clk: in std_logic;
		i_button: in std_logic;
		o_button:out std_logic
		);
end component;

signal r_tx_data: std_logic_vector(7 downto 0);
signal o_tx_active, o_tx_done, button2, r_button: std_logic;
signal tick : std_logic;

begin
	
	transmitter: component uart_transmitter
	port map(clk => clk,
				i_tx_active => tick,
				i_tx_data => "0110" & not i_tx_data(3) & not i_tx_data(2) & not i_tx_data(1) & not i_tx_data(0),
				o_tx_serial => o_tx_serial,
				o_tx_active => o_tx_active,
				o_tx_done => o_tx_done); 
				
	deb: component debounce 
	port map(clk => clk, i_button => button, o_button => button2);
	
	process(clk)
	begin
		if(rising_edge(clk)) then
			r_button <= button2;
			if(r_button = '1' and button2 <= '0') then
				tick <= '1';
			else
				tick <= '0';
			end if;
		end if;
	end process;
end arch;

				
				
