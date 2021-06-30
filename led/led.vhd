library ieee;
use ieee.std_logic_1164.all;

entity led is
port(
		led: out std_logic;
		clk: in std_logic
		);
end led;

architecture project1 of led is

signal led_status: std_logic := '0';
signal count: integer range 0 to 50000000 := 0;
 

begin 

		process(clk)
		begin
		if( rising_edge(clk)) then 
		if( count = 49999999 ) then
				count <= 0;
			led_status <= not led_status;
		else 
			count <= count +1;
			end if;
			
		end if;
		
		end process;
	led <= led_status ;

	
end project1;

		