library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity registers_file_tb is
end registers_file_tb;

architecture arch of registers_file_tb is

component registers_file is
port(
		reg_write: in std_logic;
		read_reg1: in std_logic_vector(4 downto 0);
		read_reg2: in std_logic_vector(4 downto 0);
		write_reg: in std_logic_vector(4 downto 0);
		i_wr_data: in std_logic_vector(31 downto 0);
		o_read_data2: out std_logic_vector(31 downto 0);
		o_read_data1: out std_logic_vector(31 downto 0)
		);
end component;

signal tb_reg_write:  std_logic;
signal tb_read_reg1:  std_logic_vector(4 downto 0);
signal tb_read_reg2:  std_logic_vector(4 downto 0);
signal tb_write_reg:  std_logic_vector(4 downto 0);
signal tb_i_wr_data:  std_logic_vector(31 downto 0);
signal tb_o_read_data2:  std_logic_vector(31 downto 0);
signal tb_o_read_data1:  std_logic_vector(31 downto 0);

begin

UUT: component registers_file
	  port map(reg_write => tb_reg_write,
				  read_reg1 => tb_read_reg1,
				  read_reg2 => tb_read_reg2,
				  write_reg => tb_write_reg,
				  i_wr_data => tb_i_wr_data,
				  o_read_data2 => tb_o_read_data2,
				  o_read_data1 => tb_o_read_data1);
		
		create_input: process
			begin
				tb_reg_write <= '0';
				tb_read_reg1 <= "10001";
				tb_read_reg2 <= "11100";
				wait for 0.5 ns;
				
				tb_reg_write <= '0';
				tb_read_reg1 <= "10111";
				tb_read_reg2 <= "10010";
				wait for 0.5 ns;
				
				tb_reg_write <= '1';
				tb_write_reg <= "10001";
				tb_i_wr_data <= x"14745af5";
				tb_read_reg1 <= "10111";
				tb_read_reg2 <= "11100";
				wait for 0.5 ns;
				
				tb_reg_write <= '1';
				tb_write_reg <= "10001";
				tb_i_wr_data <= x"789fab73";
				tb_read_reg1 <= "10101";
				tb_read_reg2 <= "11010";
				
				wait;
				 
			end process;

end arch;