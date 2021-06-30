library ieee;
use ieee.std_logic_1164.all;

entity debounce is
port(
		i_button: in std_logic;
		o_button: out std_logic;
		clk: in std_logic
		);
end debounce;

architecture arch of debounce is

signal count: integer range 0 to 300000 := 0;
constant delay: integer := 250000;
signal r_button: std_logic;

begin
	process(clk)
	begin
		if(rising_Edge(clk)) then
			if(count < delay and  r_button /= i_button) then
				count <= count +1;
			elsif(count = delay) then
				count <= 0;
				r_button <= i_button;
			else 
				count <= 0;
			end if;
		end if;
	end process;
	o_button <= r_button;
end arch;

		
				