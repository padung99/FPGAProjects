library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use work.vga_package.all;

entity uart_receiver is
generic(clk_per_bit: integer := 435);
port(
		clk: in std_logic;
		o_stop: out std_logic;
		i_rx: in std_logic;
		o_rx: out std_logic_vector(7 downto 0)
		);
end uart_receiver;

architecture behavioral of uart_receiver is

type states is (idle, start, start_bit, stop, clean);
signal state: states := idle;
signal r_rx1, r_rx2: std_logic := '0';
signal count : integer range 0 to clk_per_bit := 0;
signal index_data: integer range 0 to 7 := 0;
signal r_stop: std_logic := '0';
signal r_rx_data: std_logic_vector(7 downto 0) := (others => '0');


begin
	metastability: process(clk)
	begin
	if(rising_edge(clk)) then
			r_rx1 <= i_rx;
			r_rx2 <= r_rx1;
		end if;
	end process;
	
	uart: process(clk)
	begin
	if(rising_edge(clk)) then
				case state is
					when idle =>
								r_stop <= '0';
								count <= 0;
								index_data <= 0;
								
								if(r_rx2 = '0') then
									count <= 0;
									state <= start;
								end if;
							
					when start =>
							if(count < (clk_per_bit-1)/2) then
								count <= count +1;
								state <= start;
							else 
								if(r_rx2 = '0') then
									count <= 0;
									state <= start_bit;
								else 
									count <= 0;
									state <= idle;
								end if;
							end if;
							
					when start_bit =>
							if(count < clk_per_bit-1) then
								count <= count +1;
								state <= start_bit;
							else 
								count <= 0;
								r_rx_data(index_data) <= r_rx2;		
								
								if(index_data < 7) then
									index_data <= index_data +1;
									state <= start_bit;
								else
									state <= stop;
								end if;
							end if;
					
					when stop =>
							if(count < clk_per_bit-1) then
							 count <= count +1;
							 state <= stop;
							else
								count <= 0;
								r_stop <= '1';
								state <= clean;
							end if;
					
					when clean =>
							state <= idle;
							r_stop <= '0';
							
					when others => 
							state <= idle;
					end case;
				end if;
	
		
		
		end process;
		o_stop <= r_stop;
		o_rx <= r_rx_data;
		
end behavioral;	
			
		

