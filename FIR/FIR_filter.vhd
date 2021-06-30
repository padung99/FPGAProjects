library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity FIR_filter is
generic(
			input_length: integer := 8;
			output_length: integer := 16;
			orders: integer := 11;
			orders_length: integer := 8
			);
			
port(
		Din: in std_logic_vector(input_length - 1 downto 0);
		clk: in std_logic;
		reset: in std_logic;
		Qout: out std_logic_vector(output_length -1 downto 0)
		);
end FIR_filter;

architecture arch of FIR_filter is

component N_bit_register is
generic(
			input_length, output_length: integer := 8
			);
			
port(
		D: in std_logic_vector(input_length -1  downto 0 );
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic_vector(output_length -1 downto 0)
		);
end component;

type number_orders is array(0 to orders - 1) of std_logic_vector(input_length -1 downto 0);
constant coef: number_orders :=
											( 	X"F1",  
                                    X"F3",  
                                    X"07",  
                                    X"26",  
                                    X"42",  
                                    X"4E",  
                                    X"42",  
                                    X"26",  
                                    X"07",  
                                    X"F3",  
                                    X"F1"                                     
                                     );
type reg is array(0 to orders -1 ) of std_logic_vector(input_length-1 downto 0);
signal shift_reg: reg;

type multiplier is array(0 to orders -1) of std_logic_vector(input_length + orders_length - 1 downto 0);
signal mult: multiplier;

type add is array(0 to orders -1) of std_logic_vector(input_length + orders_length - 1 downto 0);
signal adder: add;

begin
	shift_reg(0) <= Din;
	mult(0) <= shift_reg(0)*coef(0);
	adder(0) <=  mult(0);
	
	filter: for i in 0 to orders-2 generate
		shift_register: component N_bit_register
								port map(
											D => shift_reg(i),
											clk => clk,
											reset => reset,
											Q => shift_reg(i+1)
											);
		mult(i+1) <= shift_reg(i+1) * coef(i+1);
		adder(i+1) <= adder(i) + mult(i+1);
	end generate;
	
	Qout <= adder(orders -1);
end arch;


		
			