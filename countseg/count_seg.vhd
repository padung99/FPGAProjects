library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity count_seg is
port(
		clk : in std_logic;
		--dig_led: out std_logic;
		i_button: in std_logic;
		dig_led: out std_logic_vector(3 downto 0);
		led: out std_logic_vector(6 downto 0)

		);
end count_seg;

architecture arch of count_seg is

component debounce is 
port(
		i_switch: in std_logic;
		iclk: in std_logic;
		o_switch: out std_logic
		);
end component;


signal count : integer range 0 to 9999   := 0;
signal reset_led: std_logic_vector(19 downto 0);
signal r_button: std_logic := '0';
signal led1: std_logic_vector(6 downto 0);
signal active_dig: std_logic_vector(1 downto 0);
signal bit_led: std_logic_vector(3 downto 0);

signal o_button: std_logic;
signal choose_led : std_logic := '0';
signal a,b,c,d: integer range 0 to 9;


begin
	--dig_led <= choose_led; 
	create_count: process(clk)		
		begin			
			if(rising_edge(clk))then
					reset_led <= reset_led + 1;
				end if;
		end process;

active_dig <= reset_led(19 downto 18);
deb: component debounce 
port map(i_switch => i_button, iclk => clk, o_switch => o_button);	
	
	
	create_count2: process(clk)
			begin
				if(rising_edge(clk)) then
					r_button <= o_button;
					if(r_button = '0' and o_button = '1') then
						--if(count = 9) then 
						--	count <= 0;
						--else
							count <= count +1;
					--end if;
					end if;
			end if;
			end process create_count2;
			
		process(bit_led)
		begin
			case bit_led is
			when "0000" => led <= "0000001"; --0
			when "0001" => led <= "1001111";--1
			when "0010" => led <= "0010010";--2
			when "0011" => led <= "0000110";--3
			when "0100" => led <= "1001100"; --4
			when "0101" => led <= "0100100"; --5
			when "0110" => led <= "0100000"; --6
			when "0111" => led <= "0001111"; --7
			when "1000" => led<= "0000000"; --8 
			when "1001" => led <= "0000100"; --9
			when "1010" => led <= "0001000"; --A
			when "1011" => led <= "1100000"; --b
			when "1100" => led <= "0110001";--c
			when "1101" => led <= "1000010";--d
			when "1110" => led <= "0110000";--e
			when "1111" => led <= "0111000";--f
		when others => null;		
		end case;
	end process;
	
	a <= count mod 1000;
	b <= (count mod 100) rem 10;
	c <= (count mod 10) rem 10;
	d <= count rem 10;
--------------------------------------------
		--create_count2: process(clk)
		
	--	begin			
	--		if(rising_edge(clk)) then
	--			if(count2 = x"1000000" ) then
	--				count2 <= (others => '0');
	--			else 
	--				count2 <= count2 +1;		
	--			end if;
	--		end if;
	--	end process;
--clk1 <= '1' when count2 = x"1000000"  else '0';

--count_number: process(clk)
--		begin
--		if(rising_edge(clk)) then
--			if(clk1 = '1') then 
--				count <= count +1;
--			end if;
--		end if;
--end process;
--------------------------------------------					
	
choose_digLed: process(bit_led)	
	begin	
		
		case active_dig is
			when "00" => 
			dig_led <= "0111";--active led 4
			bit_led <= conv_std_logic_vector(d, 4);
				
			when "01" =>
				dig_led <= "1011"; --active led 3
				bit_led <= conv_std_logic_vector(c, 4);
				
			when "10" => 
				dig_led <= "1101"; --active led 2
				bit_led <= conv_std_logic_vector(b, 4);
				
			when "11" =>
				dig_led <= "1110"; --active led 1
				bit_led <= conv_std_logic_vector(a, 4);
				
			when others => null;
			end case;
		end process;


end arch;
	