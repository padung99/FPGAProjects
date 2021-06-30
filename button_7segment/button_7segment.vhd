library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity button_7segment is
port(
		led_number: out std_logic_vector(6 downto 0);
		dig_led: out std_logic_vector(3 downto 0); 
		button: in std_logic;
		--reset: in std_logic;
		clk: in std_logic
		);
end button_7segment;

architecture arch of button_7segment is

signal BIN_LED: std_logic_vector(3 downto 0);
constant delay: std_logic_vector(19 downto 0) := x"10000";
signal count1, count2, count3, count4:  std_logic_vector(19 downto 0);
type states is (led1, led2, led3, led4);
signal state : states:= led1;
signal count: std_logic_vector(15 downto 0) := (others => '0') ;
signal o_button, r_button: std_logic;
signal tick, tmp1, tmp2, tmp3, tmp4: std_logic;


component debounce is
port(
		i_button: in std_logic;
		o_button: out std_logic;
		clk: in std_logic
		);
end component;

begin

deb: component debounce 
port map(i_button => button, clk => clk, o_button => o_button);

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
	
	process(clk)
	begin
		if(rising_edge(clk)) then
			r_button <= o_button;
			if(r_button = '0' and o_button = '1') then
				tick <= '1';
				count <= count +1;
			end if;
		end if;
	end process;
		
	process(clk)
	begin
		 if(rising_edge(clk)) then 
			count1 <= count1 +1;
		end if;
	end process;
	
	process(count1(19 downto 18))
	begin
		case count1(19 downto 18) is
			
			when "00" =>
					dig_led <= "0111";
					BIN_LED <= count(3 downto 0);
					
			when "01" =>
					dig_led <= "1011";
					BIN_LED <= count(7 downto 4);	
				
			when "10" =>
					dig_led <= "1101";
					BIN_LED <= count(11 downto 8);	
			
			when "11" =>
					dig_led <= "1110";
					BIN_LED <= count(15 downto 12);
			
			when others => null;
		end case;
	end process;
	
			
--		if(tick ='1') then			
--			count1 <= count1+1;
--			dig_led <= "0111";
--			BIN_LED <= count(3 downto 0);
--			if(count1 = x"50000") then
--				tick1 = '1';
		
--		process(clk)
--		begin
--			case state is
--				
--				when led1 => 
--						
--						if(count1 < delay) then
--							count1 <= count1+1;
--							dig_led <= "0111";
--							BIN_LED <= count(3 downto 0);
--							state <= led1;					
--						else
--							count1 <= (others => '0');
--							state <= led2;
--						end if;
--				
--				when led2 =>
--						if(count1 < delay) then
--							count1 <= count1+1;
--							dig_led <= "1011";
--							BIN_LED <= count(7 downto 4);
--							state <= led2;
--						else
--							count1 <= (others => '0');
--							state <= led3;
--						end if;
--			
--				when led3 =>
--						if(count1 < delay) then
--							count1 <= count1+1;
--							dig_led <= "1101";
--							BIN_LED <= count(11 downto 8);
--							state <= led3;
--						else
--							count1 <= (others => '0');
--							state <= led4;
--						end if;
--				
--				when led4 =>
--						if(count1 < delay) then
--							count1 <= count1+1;
--							dig_led <= "1110";
--							BIN_LED <= count(15 downto 12);
--							state <= led2;					
--						else
--							count1 <= (others => '0');
--							state <= led1;
--					end if;
--			
--				when others => state <= led1;
--			end case;
--			end process;
end arch;
			
	
	

	
	