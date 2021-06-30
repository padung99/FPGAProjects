library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MUX is
port(
		sel: in std_logic_vector(3 downto 0);
		A0,A1, A2, A3: in std_logic_vector(7 downto 0);
		MUX_out: out std_logic_vector(7 downto 0)
		);
end MUX;

architecture arch of MUX is

begin
	process(sel) 
		begin
			case sel is
				when "00" => MUX_out <= A0;
				when "01" => MUX_out <= A1;
				when "10" => MUX_out <= A2;
				when "11" => MUX_out <= A3;
			end case;
		end process;
end arch;