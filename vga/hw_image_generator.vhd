LIBRARY ieee;
USE ieee.std_logic_1164.all;
use work.vga_package.all;


ENTITY hw_image_generator IS

 PORT(
    disp_en :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
	 row      :  IN   INTEGER;    --row pixel coordinate
    column   :  IN   INTEGER;    --column pixel coordinate
	 --move_left, move_right, move_up, move_down: in std_logic;
    red      :  OUT  STD_LOGIC:= '0';  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC:= '0';  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC:='0'
	 ); --blue magnitude output to DAC
END hw_image_generator;

ARCHITECTURE behavior OF hw_image_generator IS

BEGIN
  
  PROCESS(disp_en, row, column)
  BEGIN		
		if(disp_en ='1') then 
			Square(column, row, red, green, blue);
		
			
		else
			red <= '0';
			green <=  '0';
			blue <= '0';
		end if;
		
  END PROCESS;
  
END behavior;
