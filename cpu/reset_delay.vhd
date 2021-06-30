library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity reset_delay is
port(
		clk: in std_logic;
		delay_1clk : inout std_logic
		);
end reset_delay;

architecture arch of reset_delay is

begin
process(clk)
begin
	if(delay_1clk ='1') then
		delay_1clk <= '0';
	end if;
end process;
end arch;