library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_cpu is
end tb_cpu;

architecture test of tb_cpu is

component cpu is
port(
		clk: in std_logic;
		data_in_ram: in std_logic_vector(7 downto 0);
--		data_out_cpu: out std_logic_vector(7 downto 0)
		wr_en_cpu: in std_logic;
		rd_en_cpu: in std_logic
		);
end component;

signal data_in_ram: std_logic_vector(7 downto 0);
constant clk_per: time := 0.05 ns;
signal clk, wr_en_cpu, rd_en_cpu: std_logic;

begin
	
	DUT: component cpu
	port map(clk => clk, data_in_ram => data_in_ram, wr_en_cpu => wr_en_cpu, rd_en_cpu => rd_en_cpu);
	
	create_clk: process
				begin
				clk <= '0';
				wait for clk_per/2;
				
				clk <= '1';
				wait for clk_per/2;
			end process;
			
	create_input: process
			begin
			data_in_ram <= "00001011";
			wr_en_cpu <= '1';
			rd_en_cpu <= '0';
			wait for 0.06 ns;
			
			data_in_ram <= "00011100";		
			wr_en_cpu <= '1';
			rd_en_cpu <= '0';	
			wait for 0.08 ns;
			
			data_in_ram <= "01000001";
			wr_en_cpu <= '1';
			rd_en_cpu <= '0';
			wait for 0.07 ns;
			
			data_in_ram <= "00101000";
			wr_en_cpu <= '1';
			rd_en_cpu <= '0';			
			wait for 0.04 ns;
			
			data_in_ram <= "00110011";
			wr_en_cpu <= '1';
			rd_en_cpu <= '0';
			wait for 0.03 ns;
			
			data_in_ram <= "01001011";
			wr_en_cpu <= '1';
			rd_en_cpu <= '0';
			wait for 0.06 ns;
			
			data_in_ram <= "01001001";
			wr_en_cpu <= '1';
			rd_en_cpu <= '0';
			wait for 0.045 ns;
			
			data_in_ram <= "01000111";
			wr_en_cpu <= '1';
			rd_en_cpu <= '0';
			wait for 0.04 ns;
			
			wr_en_cpu <= '0';
			rd_en_cpu <= '1';
			wait;
			
	end process;
end test;