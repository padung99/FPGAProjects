library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mux is
port(
		i_data0: in std_logic_vector(31 downto 0);
		i_data1: in std_logic_vector(31 downto 0);
		sel: in std_logic;
		o_data: buffer std_logic_vector(31 downto 0)
		);
end mux;

architecture arch of mux is

begin
	
o_data <=  i_data0 when sel = '0' else 
			  i_data1 when sel = '1';

			 
end arch;