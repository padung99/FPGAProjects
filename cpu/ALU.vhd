library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ALU is
port(
		clk: in std_logic;
		choose_op: in std_logic_vector(1 downto 0);
		a, b: in std_logic_vector(7 downto 0);
		ALU_ena: in std_logic;
		result: out std_logic_vector(7 downto 0)
		);
end ALU;

architecture arch of ALU is

begin
	
--	result <= a+b when (choose_op = "00" and ALU_ena ='1' and ALU_off /='1') else
--				 a-b when (choose_op = "01" and ALU_ena ='1' and ALU_off /='1') else
--				 a and b when (choose_op = "10" and ALU_ena ='1'and ALU_off /='1') else
--				 a or b when (choose_op = "11" and ALU_ena ='1' and ALU_off /='1');
				
	process(clk)
		begin
			if(rising_edge(clk)) then
				if(ALU_ena ='1') then
					case choose_op is
						when "00" =>
							result <= a + b; ---- add
						when "01" =>
							result <= a-b;
						when "10" =>
							result <= a and b;
						when "11" =>
							result <= a or b;
						when others => null;
					end case;
				end if;
			end if;
		end process;
end arch;
				
