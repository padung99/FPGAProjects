library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mux_tb is
end mux_tb;

architecture arch of  mux_tb is

component mux is
port(
		i_data0: in std_logic_vector(31 downto 0);
		i_data1: in std_logic_vector(31 downto 0);
		sel: in std_logic;
		o_data: out std_logic_vector(31 downto 0)
		);
end component;

signal tb_i_data1, tb_i_data0, tb_o_data: std_logic_vector(31 downto 0);
signal tb_sel: std_logic;

begin	

UUT: component mux 
		port map(i_data1 => tb_i_data1, 
					i_data0 => tb_i_data1,
					sel => tb_sel,
					o_data => tb_o_data);
		

create_input: process
					begin	
						tb_i_data1 <= x"152547f5";
						tb_i_data0 <= x"100df256";
						tb_sel <= '0';
						
						tb_i_data1 <= x"152747f5";
						tb_i_data0 <= x"100df466";
						tb_sel <= '1';
						
						tb_i_data1 <= x"1726a7f5";
						tb_i_data0 <= x"42fdf256";
						tb_sel <= '0';
						
						tb_i_data1 <= x"152747f5";
						tb_i_data0 <= x"965ab466";
						tb_sel <= '1';
					end process;
					
					
end arch;