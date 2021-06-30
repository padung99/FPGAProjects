library ieee;
use ieee.std_logic_1164.all;

entity button_led is
port(
		clk: in std_logic;
		switch: in std_logic;
		led: out std_logic
		);
end entity;

architecture arch of button_led is

component debounce is
port(
		iclk: in std_logic;
		i_switch: in std_logic;
		o_switch: out std_logic
		);
end component;


signal r_switch: std_logic;
signal led_status: std_logic := '1';
signal o_button: std_logic;
begin
	process(clk)
		begin
			if(rising_edge(clk)) then
				r_switch <= o_button;  -- create a register to save previous logic of button
				 if(r_switch = '1' and o_button = '0') then --- rising edge
					led_status <= not led_status;
				end if;
			end if;
	end process;
	
		led <= led_status;
		
	deb: component debounce
	port map(iclk => clk, i_switch => switch, o_switch => o_button);
end arch;


