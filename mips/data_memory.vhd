library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity data_memory is
port(
		clk: std_logic;
		address: in std_logic_vector(31 downto 0);
		mem_read: in std_logic;
		mem_write: in std_logic;
		data_wr: in std_logic_vector(31 downto 0);
		data_rd: out std_logic_vector(31 downto 0)
		);
end data_memory;

architecture arch of data_memory is

type data_mem is array (0 to 15) of std_logic_vector(31 downto 0);
signal DM : data_mem := (
									x"65321459",    --- address of data memory begins at 0x10010000
									x"00000000",
									x"1141123A",
									x"14785236",
									x"A41B452E", --- 
									x"63214FDE",
									x"4178DEF3",
									x"41236DBA",
									x"7458695B",   
									x"4121FDAC",
									x"86AB14FE",
									x"41ACBFE5",
									x"ABCEF476",
									x"BCE1254F",
									x"EF2367AC",
									x"22222222"
									);
									
									

begin
	process(clk)
	begin
		------ 0x01001000 = 268 500 992 
		----------- read process
		if(rising_Edge(clk)) then
			if(mem_read = '1') then
				data_rd <= DM(((to_integer(unsigned(address))) - 268500992)/4); --when mem_read = '1';
			end if;
			
		----------- write process	
			if(mem_write = '1') then
				DM(((to_integer(unsigned(address))) - 268500992)/4) <= data_wr; -- when mem_write = '1'; 
			end if;
		end if;
	end process;
end arch;

