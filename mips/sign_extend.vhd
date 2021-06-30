library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sign_extend is
port(
		i_16bit: in std_logic_vector(15 downto 0);
		o_32bit: out std_logic_vector(31 downto 0)
		);
end sign_extend;

architecture arch of sign_extend is

--signal o_data: std_logic_vector(31 downto 0);

begin
	o_32bit <= x"0000" & i_16bit when i_16bit(15) = '0' else
				 x"FFFF" & i_16bit when i_16bit(15) = '1';
	
	--o_32bit <= o_data;
	
end arch;
