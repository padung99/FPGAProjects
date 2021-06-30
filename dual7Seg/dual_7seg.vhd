library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity dual_7seg is
port(
		dig_led: out std_logic_vector(3 downto 0);
		segment: out std_logic_vector(6 downto 0);
		--bit_in : in std_logic_vector(3 downto 0);
		clk: in std_logic
		);
end dual_7seg;

architecture arch of dual_7seg is

signal led_number: std_logic_vector(6 downto 0);
signal bin_led: std_logic_vector(3 downto 0);
signal count : std_logic_vector(19 downto 0) := (others => '0');
signal count_led: std_logic_vector(27 downto 0) := (others => '0');
signal count2: integer range 0 to 100000 := 0;
signal tick: std_logic;

begin
	show_number: process(clk)
	begin
	if(rising_edge(clk)) then
			case bin_led is
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
	end if;
	end process;
		
			choose_led: process(clk)
					begin
					if(rising_edge(clk)) then
							count <= count +1;
						end if;
--						dig_led <= "1111";
--						dig_led(count) <= '0';
				end process;
				
			process(clk)
				begin
				if(rising_edge(clk)) then
					if(count_led = x"1000000") then 
						count_led <= (others => '0');
						tick <= '1';
					else
						count_led <= count_led +1;
						tick <= '0';
				end if;
				end if;
			end process;
			
			process(clk)
				begin
				if(rising_edge(clk)) then
--					if(count = 4) then
--							count <= 0;
--						else
--							count <= count +1;
--						end if;
						
						--dig_led <= "1111";
--						dig_led(count) <= '0';	
--					end if;
					
					if(tick = '1') then
						count2 <= count2 + 1;
--						bin_led <= conv_std_logic_vector(count2, 16)(3 downto 0);
					end if;
					
					case count(19 downto 18) is
						when "00" =>
						dig_led <= "0111";
						bin_led <= conv_std_logic_vector(count2, 16)(3 downto 0);
						when "01" => 
						dig_led <= "1011";
						bin_led <= conv_std_logic_vector(count2, 16)(7 downto 4);
						when "10" => 
						dig_led <= "1101";
						bin_led <= conv_std_logic_vector(count2, 16)(11 downto 8);
						when "11" => 
						dig_led <= "1110";
						bin_led <= conv_std_logic_vector(count2, 16)(15 downto 12);
						when others => null;
					end case;
				end if;
			end process;
			
			segment <= led_number;
end arch;

					