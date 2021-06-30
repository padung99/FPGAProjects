library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use work.vga_package.all;

entity sync is
port(
		clk_pixel: in std_logic;
		hsync, vsync: out std_logic;
		disp_en: out std_logic;
		move_left, move_right, move_up, move_down: in std_logic;
		column		:	OUT	INTEGER;		--horizontal pixel coordinate
		row			:	OUT	INTEGER;		--vertical pixel coordinate
		R,G,B: out std_logic
		);
end sync;

architecture arch of sync is

component hw_image_generator IS
  PORT(
    disp_en :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
	 row      :  IN   INTEGER;    --row pixel coordinate
    column   :  IN   INTEGER;    --column pixel coordinate
	 --move_left, move_right, move_up, move_down: in std_logic;
    red      :  OUT  STD_LOGIC:= '0';  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC:= '0';  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC:='0'
	 ); --blue magnitude output to DAC
END component;


signal hpos: integer range 0 to Hspecific_timing := 0;
signal vpos: integer range 0 to Vspecific_timing := 0;
signal disp_en1, R1, B1, G1: std_logic;
signal row1, column1: integer; 

begin
	U1: component hw_image_generator 
	
	port map(
				disp_en => disp_en1,
				row => row1,
				column => column1,
				red => R1,
				green => G1,
				blue => B1);
	
	process(clk_pixel)
		begin	
			if(rising_edge(clk_pixel)) then
				--increasing coordinate x and y
				--------------------------------------------------------
				if(hpos < Hspecific_timing) then 
					hpos <= hpos +1;
				else
					hpos <= 0;
					if(vpos < Vspecific_timing) then
						vpos <= vpos +1;
					else
					----------------------------------------------
					if(move_left = '0') then
						pixels_x <= pixels_x -3;
					end if;
					if(move_right = '0') then
						pixels_x <= pixels_x +3;
					end if;
					if(move_up = '0') then
						pixels_y <= pixels_y -3;
					end if;
					if(move_down = '0') then
						pixels_y <= pixels_y +3;
					end if;
					-----------------------------------------------
						vpos <= 0;
					end if;
				end if;
			-----------------------------------------------------------
			--detected sync_pulse 
			if((hpos < H_FP + leng) or (hpos > (H_FP + leng + Hsync_pulse))) then
				hsync <= not H_pol;
			else
				hsync <= H_pol;
			end if;
			
			if((vpos < V_FP + wid) or (vpos > (V_FP + wid+ Vsync_pulse))) then
				vsync <= not V_pol;
			else
				vsync <=  V_pol;
			end if;
			-------------------------------------------------------------	
			if((hpos < leng) and (vpos < wid)) then
				disp_en1 <= '1';
			else
				disp_en1 <='0';
			end if;
			
			IF(hpos < leng) THEN  	--horiztonal display time
				column1 <= hpos;			--set horiztonal pixel coordinate
			END IF;
			IF(vpos < wid) THEN	--vertical display time
				row1 <= vpos;				--set vertical pixel coordinate
			END IF;
			-------------------------------------------------------------
--			--if(disp_en1 ='1') then
--				if((hpos = H_middle) or (vpos = V_middle)) then
--						R1 <= '0';
--						G1 <= '1';
--						B1 <= '0';
--					else 
--						R1 <= '0';
--						G1 <= '0';
--						B1 <= '1';
--					end if;
--			--end if;
			
--			if(((hpos >0) and (hpos < Hblanking)) or ((vpos > 0) and (vpos < Vblanking))) then
--				R1 <= '0';
--				G1 <= '0';
--				B1 <= '1';
--			end if;
		end if;
	end process;
	
	column <= column1;
	row <= row1;
	disp_en <= disp_en1;
	R <= R1;
	G <= G1;
	B <= B1;
	
end arch;
