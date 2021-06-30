library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity program_counter is
port(
		clk: in std_logic;
		in_count: in std_logic_vector(31 downto 0);
		jmp_brch_active: in std_logic;
		in_address: in std_logic_vector(31 downto 0);
		out_count: out std_logic_vector(31 downto 0)
		);
end program_counter;

architecture arch of program_counter is

signal address: std_logic_vector(31 downto 0) := x"00400000";

begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(jmp_brch_active = '1') then
				out_count <= in_address;
			else
				out_count <= in_count;
			end if;
		end if;
		
--out_count <= in_address when jmp_brch_active = '1' else
--			    in_count when jmp_brch_active = '0';

--		out_count <= address;
--		process(clk)
--		begin
--			if(rising_edge(clk)) then
--				address <= in_count;
--			end if;
--		if(reset = '1') then
--			out_count <= x"00400000";			
--		else
--			if(rising_edge(clk)) then
--				out_count <= in_count;
--			end if;
--		end if;
 end process;
end arch;

