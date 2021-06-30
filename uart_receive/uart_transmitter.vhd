library ieee;
use ieee.std_logic_1164.all;

entity uart_transmitter is
generic( clk_per_bit: integer := 434);

port(
		clk: in std_logic;
		i_tx_active: in std_logic; ----- button 
		i_tx_data: in std_logic_vector(7 downto 0);
		o_tx_serial: out std_logic;
		o_tx_active: out std_logic; -----
		o_tx_done: out std_logic ------
		);
end uart_transmitter;

architecture arch of uart_transmitter is

type states is(idle, start, trans_bit, stop, clean);
signal state: states := idle;
signal index: integer range 0 to 7 := 0;
signal byte_data : std_logic_vector(7 downto 0); 
signal count: integer range 0 to clk_per_bit  := 0;


begin
	process(clk)
	begin	
		if(rising_edge(clk)) then
				case state is 
					
					when idle =>
						o_tx_done <= '1';
						o_tx_active <= '0';
						index <= 0;
						o_tx_done <= '0';
						count <= 0;
						
								if(i_tx_active = '1') then
									state <= start;
									byte_data <= i_tx_data;
									count <= 0;
								else
									state <= idle;
								end if;
					
					when start =>
								o_tx_active <= '1';
								o_tx_serial <= '0'; --start bit detected;
								
								if(count < clk_per_bit ) then
									count <= count +1;
									state <= start;
								else
									count <= 0;
									state <= trans_bit;
								end if;
					
					when trans_bit =>				
								o_tx_serial <= byte_data(index);
									if(count < clk_per_bit ) then
										count <= count +1;
										state <= trans_bit;
									else
										count <= 0;
										if(index < 7) then
											index <= index +1;
											state <= trans_bit;
										else
											index <= 0;
											state <= stop;
										end if;
									end if;
					
					when stop =>
								o_tx_serial <= '1';
									if(count < clk_per_bit) then
										count <= count +1;
										state <= stop;
									else
										o_tx_done <= '1';
										count <= 0;
										state <= clean;
									end if;
					
					when clean =>
								state <= idle;
								o_tx_done <= '1';
								o_tx_active <= '0';
					
					when others =>
								state <= idle;
					
					end case;
				end if;
			end process;
end arch;

			
			
							
										
					
							
								