library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity instr_reg is
port(
		clk: in std_logic;
		address_in: in integer range 0 to 7;
		data_in_instr_reg: in std_logic_vector(7 downto 0);
		data_out_instr_reg: out std_logic_vector(7 downto 0)
		);
end instr_reg;

architecture arch of instr_reg is

begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			data_out_instr_reg <= data_in_instr_reg;
		end if;
	end process;
end arch;

