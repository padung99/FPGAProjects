library ieee;
use ieee.std_logic_1164.all;

entity tb_sync is
end tb_sync;

architecture test of tb_sync is

component sync is
generic (leng: integer:= 1920;
			H_FP: integer := 88;
			H_BP: integer := 148;
			Hsync_pulse: integer := 44;
			H_pol: std_logic := '1'; ----- 1- possitive, 0 - negative
			wid: integer := 1080;
			V_FP: integer := 4;
			V_BP: integer := 36;
			Vsync_pulse: integer := 5;
			V_pol: std_logic :='1' ----- 1- possitive, 0 - negative
			);
port(
		clk_pixel: in std_logic;
		hsync, vsync: out std_logic;
		R,G,B: out std_logic
		);
end component;

signal clk: std_logic; 
signal hsync, vsync, R,G,B: std_logic;
constant clk_per: time := 6.80 ns;


begin
	DUT: component sync
	port map(clk_pixel => clk, hsync => hsync, vsync => vsync, R => R, G => G, B => B);
	
	create_clk: process
		begin
			clk <= '0';
			wait for clk_per/2;
			
			clk <= '1';
			wait for clk_per/2;
		end process;
end test;
	
	--create_input: process
		
		