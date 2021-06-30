library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use work.vga_package.all;

entity vga_uart is
generic(N: integer := 1500);
port(
		i_rx_test: in std_logic;
		clk: in std_logic;
		led_number: out std_logic_vector(6 downto 0);
		dig_led: out std_logic_vector(3 downto 0);
		----------------------------------------------------------
		vga_R, vga_G, vga_B: out std_logic;
		--move_left, move_right, move_up, move_down: in std_logic;
		vga_hs, vga_vs: out std_logic
		);
end vga_uart;

architecture arch of vga_uart is

signal o_data: std_logic_vector(7 downto 0);
signal stop: std_logic;
signal move_left, move_right, move_up, move_down: std_logic;
signal BIN_LED: std_logic_vector(3 downto 0);
signal count1, count2: std_logic_vector(17 downto 0) := (others =>'0');
signal tick: std_logic := '0';

signal clk_pixel, reset: std_logic;

component uart_receiver is
generic(clk_per_bit: integer := 435);
port(
		clk: in std_logic;
		o_stop: out std_logic;
		i_rx: in std_logic;
		o_rx: out std_logic_vector(7 downto 0)
		);
end component;

component sync is
port(
		clk_pixel: in std_logic;
		hsync, vsync: out std_logic;
		disp_en: out std_logic;
		move_left, move_right, move_up, move_down: in std_logic;
		column		:	OUT	INTEGER;		--horizontal pixel coordinate
		row			:	OUT	INTEGER;		--vertical pixel coordinate
		R,G,B: out std_logic
		);
end component;

component pll_vga is
	port (
		clk_in_clk  : in  std_logic := '0'; --  clk_in.clk
		clk_out_clk : out std_logic;        -- clk_out.clk
		reset_reset : in  std_logic :='0' --   reset.reset
	);
end component;


begin

	create_pll: component pll_vga
	port map(clk_in_clk => clk, clk_out_clk => clk_pixel, reset_reset => reset);
	sy: component sync
	port map(move_left => move_left,
				move_right => move_right,
				move_up => move_up,
				move_down => move_down,
				clk_pixel => clk_pixel,
				hsync => vga_hs,
				vsync =>  vga_vs,
				R => vga_R,
				G => vga_G,
				B => vga_B); 
	
	process(o_data)
	begin
		if(o_data = x"61" or o_data = x"44" ) then ----- ASCII code for left arrow
			move_left <= '0';
		else
			move_left <= '1';
		end if;
		
		if(o_data = x"64" or o_data = x"43") then  ----- ASCII code for right arrow
			move_right <= '0';
		else
			move_right <= '1';
		end if;
		
		if(o_data = x"77" or o_data = x"41") then  ----- ASCII code for up arrow
			move_up <= '0';
		else
			move_up <= '1';
		end if;
		
		if(o_data = x"73" or o_data = x"42") then  ----- ASCII code for down arrow
			move_down <= '0';
		else
			move_down <= '1';
		end if;
	end process;
----------------------------------------------------------------------------------------
	UART: component uart_receiver 
	port map(clk => clk, o_stop => stop, i_rx => i_rx_test, o_rx => o_data);
	
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(tick = '0') then
				count1 <= count1+ 1;
				dig_led <= "0111";
				BIN_LED <= o_data(3 downto 0);
				if(count1(17 downto 16) = "11") then
					tick <= '1';
				end if;
			
			elsif(tick = '1') then
				count2 <= count2 +1;
				dig_led <= "1011";
				BIN_LED <= o_data(7 downto 4);
				if(count2(17 downto 16) = "11") then
					tick <= '0';
				end if;
			end if;
		
		end if;
	end process;
				
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

end arch;
			
	
		