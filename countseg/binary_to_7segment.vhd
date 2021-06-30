library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity binary_to_7segment is
port(
		bit_led: in std_logic_vector(3 downto 0);
		i_clk: in std_logic;
	 o_Segment_A  : out std_logic;
    o_Segment_B  : out std_logic;
    o_Segment_C  : out std_logic;
    o_Segment_D  : out std_logic;
    o_Segment_E  : out std_logic;
    o_Segment_F  : out std_logic;
    o_Segment_G  : out std_logic
		);
end binary_to_7segment;

architecture arch of binary_to_7segment is

signal led: std_logic_vector(7 downto 0) := (others => '0');

begin
	process(i_clk)
		begin
			if(rising_edge(i_clk)) then
			case bit_led is
			when "0000" =>
          led <= X"7E";
        when "0001" =>
          led <= X"30";
        when "0010" =>
          led <= X"6D";
        when "0011" =>
          led <= X"79";
        when "0100" =>
          led <= X"33";          
        when "0101" =>
          led <= X"5B";
        when "0110" =>
          led <= X"5F";
        when "0111" =>
          led <= X"70";
        when "1000" =>
          led <= X"7F";
        when "1001" =>
          led <= X"7B";
        when "1010" =>
          led <= X"77";
        when "1011" =>
          led <= X"1F";
        when "1100" =>
          led <= X"4E";
        when "1101" =>
          led <= X"3D";
        when "1110" =>
          led <= X"4F";
        when "1111" =>
          led <= X"47";
			when others => null;		
		end case;
		end if;
	end process;
	o_Segment_A <= led(6);
	o_Segment_B <= led(5);
	o_Segment_C <= led(4);
	o_Segment_D <= led(3);
	o_Segment_E <= led(2);
	o_Segment_F <= led(1);
	o_Segment_G <= led(0);
end arch;
		