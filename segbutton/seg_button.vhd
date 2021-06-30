library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
 
entity seg_button is
port(
		button: in std_logic;
		led_number: out std_logic_vector(6 downto 0);
		clk: in std_logic;
		dig_led: out std_logic_vector(3 downto 0)
		);
end seg_button;

architecture behavioral of seg_button is

signal count: integer range 0 to 9999 := 0;
--signal count: std_logic_vector(13 downto 0) := (others => '0');
signal status_button: std_logic;
signal reset_led: std_logic_vector(19 downto 0) := (others => '0');
signal choose_led: std_logic_vector(1 downto 0);
--signal BIN_LED: std_logic_vector(3 downto 0);
signal a,b,c,d: integer range 0 to 9 := 0;
signal LED: integer range 0 to 9 := 0;
type states is (st1, st2, st3, st4, check);
signal state: states := check;

begin
create_number: process(LED)
	begin 
			case LED is
			when 0 => led_number <= "0000001"; --0
			when 1 => led_number <= "1001111";--1
			when 2 => led_number <= "0010010";--2
			when 3 => led_number <= "0000110";--3
			when 4 => led_number <= "1001100"; --4
			when 5 => led_number <= "0100100"; --5
			when 6 => led_number <= "0100000"; --6
			when 7 => led_number <= "0001111"; --7
			when 8 => led_number <= "0000000"; --8 
			when 9 => led_number <= "0000100"; --9
			--when "1010" => led_number <= "0001000"; --A
			--when "1011" => led_number <= "1100000"; --b
			--when "1100" => led_number <= "0110001";--c
			--when "1101" => led_number <= "1000010";--d
			--when "1110" => led_number <= "0110000";--e
			--when "1111" => led_number <= "0111000";--f
			when others => null;
	end case;
	end process;

	press_button: process(button)
	begin
		if(button = '1') then
				count <= count +1;
				--wait for 500000000 ns;			
		end if;
	end process;
	
		
	a <= count mod 1000;
	b <= (count rem 1000) mod 100;
	c <= (count rem 100) mod 10;	
	d <= count rem 10;
	
	reset: process(clk)
	begin
		if(rising_edge(clk)) then
				reset_led <= reset_led +1;
		end if;
	end process;
	
	choose_led <= reset_led(19 downto 18);
	
	process(choose_led)
	begin
		case choose_led is
			when "00" =>
				dig_led <= "0111";
				LED <= d;
			when "01" =>
				dig_led <= "1011";
				LED <= c;
			when "10" =>
				dig_led <= "1101";
				LED <= b;
			when "11" =>
				dig_led <= "1110";
				LED <= a;
			when others => null;
		end case;
	end process;
	
	
end behavioral;
			
				
	

