library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity seg8 is
port(
		clk: in std_logic;
		led_number: out std_logic_vector(6 downto 0); 
		digLed: out std_logic_vector(3 downto 0)
		);
		
end seg8;

architecture behavioral of seg8 is


signal reset_led: std_logic_vector(15 downto 0)  := (others => '0');
signal count_led: std_logic_vector(15 downto 0) := (others => '0');
signal BIN_LED: std_logic_vector(3 downto 0);
signal active_dig: std_logic_vector(1 downto 0);
signal clk1: std_logic;
signal count: std_logic_vector(27 downto 0) := (others => '0');



begin
create_number: process(BIN_LED)
	begin 
			case BIN_LED is
			when "0000" => led_number <= "0000001"; --0
			when "0001" => led_number <= "1001111";--1
			when "0010" => led_number <= "0010010";--2
			when "0011" => led_number <= "0000110";--3
			when "0100" => led_number <= "1001100"; --4
			when "0101" => led_number <= "0100100"; --5
			when "0110" => led_number <= "0100000"; --6
			when "0111" => led_number <= "0001111"; --7
			when "1000" => led_number <= "0000000"; --8 
			when "1001" => led_number <= "0000100"; --9
			when "1010" => led_number <= "0001000"; --A
			when "1011" => led_number <= "1100000"; --b
			when "1100" => led_number <= "0110001";--c
			when "1101" => led_number <= "1000010";--d
			when "1110" => led_number <= "0110000";--e
			when "1111" => led_number <= "0111000";--f
			when others => null;
	end case;
	end process;


	
create_count: process(clk)
		--variable count: integer range 0 to 50000000 := 0;
		
		begin			
			if(rising_edge(clk))then
				--if(count <= 16*49999999 ) then
					--count := 0;
					--reset_led <= (others => '0');
				--else 
				--	count := count +1;
					reset_led <= reset_led + 1;
				end if;
		--	end if;
		end process;

active_dig <= reset_led(15 downto 14);

create_count2: process(clk)
		
		begin			
			if(rising_edge(clk)) then
				if(count = x"1000000" ) then
					count <= (others => '0');
				else 
					count <= count +1;		
				end if;
			end if;
		end process;
clk1 <= '1' when count = x"1000000"  else '0';

count_number: process(clk)
		begin
		if(rising_edge(clk)) then
			if(clk1 = '1') then 
				count_led <= count_led +1;
			end if;
		end if;
end process;	
 	
--choose_digLed: process(count_led)	
--	begin
		--digLed <= "0000";
--		if(count_led <= "0000000000001111") then
--			digLed <= "0111";
--			BIN_LED <= count_led(3 downto 0);
--		elsif ( count_led >= "0000000000010000" and count_led <= "0000000011110000") then
--			digled <= "0011";
--			BIN_LED <= count_led(3 downto 0);
--			BIN_LED <= count_led(7 downto 4);
--		elsif(count_led >= "0000000100000000" and count_led <= "0000111100000000") then
--			digled <= "0001";
--			BIN_LED <= count_led(3 downto 0);
--			BIN_LED <= count_led(7 downto 4);
--			BIN_LED <= count_led(11 downto 8);
--		elsif (count_led >= "0001000000000000" and count_led <= "1111000000000000") then
--			digled <= "0000";
--			BIN_LED <= count_led(3 downto 0);
--			BIN_LED <= count_led(7 downto 4);
--			BIN_LED <= count_led(11 downto 8);
--			BIN_LED <= count_led(15 downto 12);
--		end if;
--	end process;
choose_digLed: process(active_dig)	
	begin	
		
		case active_dig is
			when "00" => 
				digled <= "0111"; --active led 4
				BIN_LED <= count_led(3 downto 0);
				
			when "01" =>
				digled <= "1011"; --active led 3
				BIN_LED <= count_led(7 downto 4);
				
			when "10" => 
				digled <= "1101"; --active led 2
				BIN_LED <= count_led(11 downto 8);
				
			when "11" =>
				digled <= "1110"; --active led 1
				BIN_LED <= count_led(15 downto 12);
				
			when others => null;
			end case;
		end process;
end behavioral;

				
				
				
		

			
	