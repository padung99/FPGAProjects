library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use work.vga_package.all;


entity vga is

port(
		clk: in std_logic;
		vga_R, vga_G, vga_B: out std_logic;
		move_left, move_right, move_up, move_down: in std_logic;
		vga_hs, vga_vs: out std_logic
		);
end vga;  

architecture arch of vga is

component sync is
port(
		clk_pixel: in std_logic;
		hsync, vsync: out std_logic;
		disp_en: out std_logic;
		move_left, move_right, move_up, move_down: in std_logic;
		column		:	OUT	INTEGER;		--horizontal pixel coordinate
		row			:	OUT	INTEGER;		--vertical pixel coordinate
		R,G,B: out std_logic
		);
end component;

component pll_vga is
	port (
		clk_in_clk  : in  std_logic := '0'; --  clk_in.clk
		clk_out_clk : out std_logic;        -- clk_out.clk
		reset_reset : in  std_logic :='0' --   reset.reset
	);
end component;

signal clk_pixel, reset: std_logic;
--signal move_left1, move_right1, move_up1, move_down1: std_logic;

begin
								
	create_pll: component pll_vga
	port map(clk_in_clk => clk, clk_out_clk => clk_pixel, reset_reset => reset);
	sy: component sync
	port map(move_left => move_left,
				move_right => move_right,
				move_up => move_up,
				move_down => move_down,
				clk_pixel => clk_pixel,
				hsync => vga_hs,
				vsync =>  vga_vs,
				R => vga_R,
				G => vga_G,
				B => vga_B); 
				
end arch;

		
		