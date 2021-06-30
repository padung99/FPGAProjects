library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity debounce is
port(
		clk: in std_logic;
		i_button: in std_logic;
		o_button:out std_logic
		);
end debounce;

architecture arch of debounce is 

signal count : integer range 0 to 3000000:= 0;
signal r_state: std_logic;
constant delay: integer := 2600000; 

begin
	process(clk)
		begin
			if(rising_edge(clk)) then
				if(delay < 2600000 and r_state /= i_button) then
					count <= count +1;
				elsif(delay = 2600000) then
					r_state <= i_button;
					count <= 0;
				else
					count <= 0;
				end if;
			end if;
	end process;
	
	o_button <= r_state;
end arch;

					