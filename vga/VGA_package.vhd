library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

package vga_package is 

------------------------------------------------------
constant	leng: integer:= 1920;
constant H_FP: integer := 88;
constant	H_BP: integer := 148;
constant	Hsync_pulse: integer := 44;
constant	H_pol: std_logic := '1'; ----- 1- possitive, 0 - negative
constant	wid: integer := 1080;
constant	V_FP: integer := 4;
constant	V_BP: integer := 36;
constant	Vsync_pulse: integer := 5;
constant	V_pol: std_logic :='1';

constant Hspecific_timing: integer := leng + H_FP + H_BP + Hsync_pulse;
constant Vspecific_timing: integer := wid +V_FP + V_BP + Vsync_pulse;
constant Hblanking: integer := H_FP + Hsync_pulse + H_BP;
constant Vblanking: integer := V_FP + Vsync_pulse + V_BP;
constant H_middle: integer := Hblanking + leng/2;
constant V_middle: integer := Vblanking + wid/2;
--------------------------------------------------------
signal pixels_x : integer:= 600;
signal pixels_y : integer:= 478;
constant edge_square: integer := 25;
--------------------------------------------------------
procedure square(signal Xcur, Ycur:in integer;
					  signal red, green, blue:  out std_logic);

end vga_package;

package body vga_package is


---------------------------------------------------------
procedure square(signal Xcur, Ycur:in integer; signal red, green, blue:  out std_logic) is
				begin
					if(Xcur > pixels_x and Xcur < pixels_x + edge_square and Ycur > pixels_y and Ycur < pixels_y + edge_square) then
						 red <= '1';
						 green <= '0';
						 blue <= '0';
					else
						 red <= '1';
						 green  <= '1';
					    blue <=  '0';
					end if;
				end Square;
				
					
----------------------------------------------------------

end vga_package;
