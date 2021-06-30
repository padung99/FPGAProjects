library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity N_bit_register is
generic(
			input_length, output_length: integer := 8
		--	outout_length: integer := 16;
		--orders: integer := 11;
		--	orders_length: integer := 8
			);
			
port(
		D: in std_logic_vector(input_length -1  downto 0 );
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic_vector(output_length -1 downto 0)
		);
end N_bit_register;

architecture arch of N_bit_register is

--signal
begin
	process(clk)
		begin
			if(reset= '1') then
				Q <= (others => '0');
			else
				if(rising_edge(clk)) then
					Q <= D;
				end if;
			end if;
	end process;
end arch;