library ieee;
use ieee.std_logic_1164.all;

entity RAM is
generic( RAM_depth: integer := 8;
			length_cell: integer := 8
			);
port(
		clk: in std_logic;
		rd_en: in std_logic;
		wr_en: in std_logic;
		address: in integer range 0 to 7;
		data_in: in std_logic_vector(7 downto 0);
		data_out: out std_logic_vector(7 downto 0)
		);
end RAM;

architecture arch of RAM is
 
type RAMs is array (0 to 7) of std_logic_vector(7 downto 0);

signal RAM_memory: RAMs;

begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(wr_en = '1') then
				RAM_memory(address) <= data_in;
			end if;
		end if;
	end process;
			
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(rd_en = '1') then
				data_out <= RAM_memory(address);
			end if;
		end if;
	end process;
	
end arch;
				
