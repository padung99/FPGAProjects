library ieee;
use ieee.std_logic_1164.all;
USE ieee.Numeric_BIT.all;

entity led_button is
port(
		led: out std_logic_vector(3 downto 0);
		clk: in std_logic;
		button: in std_logic
		);
end led_button;

architecture behavioral of led_button is

component debounce is
port(
		iclk: in std_logic;
		i_switch: in std_logic;
		o_switch: out std_logic
		);
end component;
 

signal count: integer range 0 to 5000000 := 0;
signal state_led: bit_vector(3 downto 0) := "1110";
signal o_button: std_logic;
signal r_button: std_logic;

begin
	process(clk)
	begin	
		if(rising_edge(clk)) then
			r_button <= o_button;
			if(r_button = '1' and o_button = '0') then
				state_led <= state_led ror 1;
			end if;
		end if;
	end process;
			led <= to_stdlogicvector(state_led);
			
	deb: component debounce
	port map(iclk => clk, i_switch => button, o_switch => o_button);
	
		
end behavioral;
			