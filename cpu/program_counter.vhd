library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity program_counter is
port(
		clk: in std_logic;
		address_out: out integer range 0 to 7
		);
end  program_counter;

architecture arch of program_counter is

signal count : integer range 0 to 7 := 0;
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(count /= 7) then
				count <= count +1;
			else
				count <= 0;
			end if;
		end if;
	end process;
	address_out <= count;
end arch;