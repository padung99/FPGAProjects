library ieee;
use ieee.std_logic_1164.all;

entity led_7segment is 
port(
		led_number: out std_logic_vector(6 downto 0);
--		iclk : in std_logic;
		i_4bit: in std_logic_vector(3 downto 0)
		--dig_led: out std_logic_vector(3 downto 0)
		);
end led_7segment;

architecture behavioral of led_7segment is

--component uart_receiver is
--generic(clk_per_bit: integer := 217);
--port(
--		clk: in std_logic;
--		o_stop: out std_logic;
--		i_rx: in std_logic;
--		o_rx: out std_logic_vector(7 downto 0)
--		);
--end component;


begin
	process(i_4bit)
	begin
			case i_4bit is
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
	
end behavioral;

	