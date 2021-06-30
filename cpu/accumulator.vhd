library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity accumulator is
port(
		clk: in std_logic; 
		result_in: in std_logic_vector(7 downto 0);
		reset_ALU: out std_logic;
		ALU_en: in std_logic;
		result_out: out std_logic_vector(7 downto 0)
		);
end accumulator;

architecture arch of accumulator is

begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(ALU_en ='1') then
				result_out <= result_in;
				reset_ALU <= '1';
			else
				reset_ALU <= '0';
			end if;
		end if;
	end process;
end arch;

