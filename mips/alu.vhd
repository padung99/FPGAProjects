library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu is
port(
		i_operand1: in std_logic_vector(31 downto 0);
		i_operand2: in std_logic_vector(31 downto 0);
		o_result: out std_logic_vector(31 downto 0);
		zero: out std_logic;
		alu_control: in std_logic_vector(3 downto 0)
		);
end alu;

architecture arch of alu is

signal result_alu: std_logic_vector(31 downto 0); 

begin

zero <= '1' when result_Alu = x"00000000" else '0';

	process(i_operand1, i_operand2, alu_control)
	begin
		case alu_Control is
			when "0000" =>  --- bitwise and
				result_Alu <= i_operand1 and i_operand2;
			
			when "0001" =>  --- bitwise or
				result_Alu <= i_operand1 or i_operand2;
			
			when "0010" =>  --- add
				result_Alu <= i_operand1 + i_operand2;
				
			when "0110" =>  --- sub
				result_Alu <= i_operand1 - i_operand2;
			
			when "0111" =>  --- slt
				if(i_operand1 < i_operand2) then 
					result_Alu <= x"00000001";
				else 
					result_Alu <= x"00000000";
				end if;
			
			when "1100" =>  --- bitwise nor
				result_Alu <= i_operand1 nor i_operand2;
			
			when others =>  -- nothing
				null;
			end case;
			
		end process;
	
	o_result <= result_alu;

end arch;
			