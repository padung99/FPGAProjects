library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity delay is
port(
		clk: in std_logic;
		ALU_en: in std_logic;
		delay_1clk: out std_logic
		);
end delay;

architecture arch of delay is

begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(ALU_en ='1') then
				delay_1clk <='1';
			else
				delay_1clk <='0';
			end if;
		end if;
	end process;
end arch;