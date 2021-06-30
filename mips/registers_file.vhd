library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity registers_file is
port(
		reg_write: in std_logic;
		read_reg1: in std_logic_vector(4 downto 0);
		read_reg2: in std_logic_vector(4 downto 0);
		write_reg: in std_logic_vector(4 downto 0);
		i_wr_data: in std_logic_vector(31 downto 0);
		o_read_data2: out std_logic_vector(31 downto 0);
		o_read_data1: out std_logic_vector(31 downto 0)
		);
end registers_file;

architecture arch of registers_file is

type registers_file_type is array (0 to 31) of std_logic_vector(31 downto 0); 
																												
signal reg_file: registers_file_type := (
														x"00000000",  -----------data in register --0
														x"11111111",--1
														x"12345678",--2
														x"00011223",--3
														x"00000000",--4
														x"11111111",--5
														x"12345678",--6
														x"00011223",--7
														x"00000000",--8
														x"11111111",--9
														x"12345678",--10
														x"00011223",--11
														x"00000000",--12
														x"11111111",--13
														x"12345678",--14
														x"00011223",--15
														x"00000000",--16
														x"10010000",--17   ----base memory of data memory
														x"12345678",--18
														x"00011223",--19
														x"00000000",--20
														x"11111111",--21
														x"12345678",--22
														x"00011223",--23
														x"00000000",--24
														x"11111111",--25
														x"12345678",--26
														x"00011223",--27
														x"00000000",--28
														x"11111111",--29
														x"12345678",--30
														x"00011223" );--31
																									
begin
		process(reg_write, read_reg1, read_reg2)
		begin
			-------- write to reg
			if(reg_write ='1') then
				reg_file(to_integer(unsigned(write_reg))) <= i_wr_data;
			end if;
			-------- read from reg
				o_read_data1 <= reg_file(to_integer(unsigned(read_reg1)));
				o_read_data2 <= reg_file(to_integer(unsigned(read_reg2)));
				
		end process;
end arch;