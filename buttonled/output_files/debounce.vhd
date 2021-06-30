library ieee;
use ieee.std_logic_1164.all;

entity debounce is
port(
		iclk: in std_logic;
		i_switch: in std_logic;
		o_switch: out std_logic
		);
end debounce;

architecture arch of debounce is

signal count : integer range 0 to 300000;
signal r_state: std_logic;

constant delay: integer := 260000;


begin
	process(iclk)
		begin 
			if(rising_edge(iclk)) then
				if(count < delay and r_state /= i_switch) then 
					count <= count +1;
				elsif( count = delay) then
					count <= 0;
					r_state <= i_switch;
				else
					count <= 0;
				end if;
			end if;
	end process;
	
	o_switch <= r_state;
end arch;
