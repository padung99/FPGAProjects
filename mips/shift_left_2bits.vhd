library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity shift_left_2bits is
port(
		shift_in: in std_logic_vector(25 downto 0);
		shift_out: out std_logic_vector(27 downto 0)
		);
end shift_left_2bits;

architecture arch of shift_left_2bits is

--signal sh_out: std_logic_vector(27 downto 0);

begin
		shift_out <= shift_in &"00";
	
end arch;
		