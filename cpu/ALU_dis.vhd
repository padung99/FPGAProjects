library ieee;
use ieee.std_logic_1164.all;

entity ALU_dis is
port(
		clk: in std_logic;
		delay_1clk: in std_logic;
		ALU_off: out std_logic
--		load_en: out std_logic;
--		store_en: out std_logic
		);
end ALU_dis;

architecture arch of ALU_dis is

begin
	process(clk)
	begin	
		if(rising_edge(clk)) then
			if(delay_1clk ='1') then
				ALU_off <= '1';
--				load_en <= '0';
--				store_en <= '0';
			else
				ALU_off <= '0';
			end if;
		end if;
	end process;
end arch;