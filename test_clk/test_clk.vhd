library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity test_clk is
port(
		clk: in std_logic;
		led: out std_logic
		);
end test_clk;

architecture arch of test_clk is

signal led_status: std_logic := '0';
signal count: std_logic_vector(30 downto 0) := (others => '0');

begin
	process(clk)
		begin
			if(rising_edge(clk)) then
				if(count = x"111FFFF") then
					count <= (others => '0');
					led_status <= not led_status;
				else
					count <= count +1;
				end if;
			end if;
		end process;
		
		led <= led_status;
end arch;
