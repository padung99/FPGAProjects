library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity register_array is
generic(
			width_reg: integer := 8;
			number_of_reg: integer := 4);
port(
--		load_in_reg: in std_logic;
		load_out_reg: in std_logic;
		clk: in std_logic;
		address_reg_in: in integer range 0 to 3;
		address_reg_out: in integer range 0 to 3;
		data_in: in std_logic_vector(7 downto 0);		
		data_out: out std_logic_vector(7 downto 0)
		);
end register_array;

architecture arch of register_array is
 
type regs is array(0 to 3) of std_logic_vector(7 downto 0);
signal reg : regs;

begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(load_out_reg /= '1') then 
				--load_out_reg <= '0';
				reg(address_reg_in) <= data_in;			
			else
				--load_in_reg <='0';
				data_out <= reg(address_reg_out); 
			end if; 
		end if;
	end process;
end arch;

		