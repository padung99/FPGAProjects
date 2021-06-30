Library IEEE;  
 USE IEEE.Std_logic_1164.all;    
 USE IEEE.numeric_std.all;  
 Use STD.TEXTIO.all;  
  -- fpga4student.com: FPGA projects, VHDL projects, Verilog projects
  -- VHDL project: VHDL code for FIR filter 
  -- Testbench VHDL code for FIR Filter 
 entity FIR_filter_tb is 
 generic(
			input_length: integer := 8;
			output_length: integer := 16;
			orders: integer := 11;
			orders_length: integer := 8
			);
 end FIR_filter_tb; 
 architecture behaivioral of FIR_filter_tb is  

Component FIR_filter is
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
end Component;  

 signal Din          :      std_logic_vector(7 downto 0);  
 signal Clk          :      std_logic:='0';  
 signal reset     :      std_logic:='1';       
 signal output_ready     :      std_logic:='0';                                
 signal Dout          :      std_logic_vector(15 downto 0);  
 signal input: std_logic_vector(7 downto 0);  
 file my_input : TEXT open READ_MODE is "input101.txt";  
 file my_output : TEXT open WRITE_MODE is "output101_functional_sim.txt";  
 begin  
   -- fpga4student.com: FPGA projects, VHDL projects, Verilog projects
   FIR_int : component FIR_filter 
--           generic map(  
--           input_length  =>     8,  
--           output_length     =>     16,  
--           orders_length         =>     8,  
--           orders               =>     11);  
                          --guard               =>     0)  
           port map     (  
                          Din                    => Din,  
                          clk                    => Clk,  
                          reset               => reset,  
                          Qout               => Dout  
                );  
           process(clk)  
           begin  
           Clk          <= not Clk after 10 ns;  
           end process;  
           reset     <= '1', '1' after 100 ns, '0' after 503 ns; 
     -- fpga4student.com: FPGA projects, VHDL projects, Verilog projects 
     -- Writing output result to output file 
           process(clk)  
           variable my_input_line : LINE;  
           variable input1: integer;  
           begin  
                if reset ='1' then  
                     Din <= (others=> '0');  
                     input <= (others=> '0');  
                     output_ready <= '0'; 
                elsif rising_edge(clk) then                      
                     readline(my_input, my_input_line);  
                     read(my_input_line,input1);  
                     Din <= std_logic_vector(to_signed(input1, 8));  
                     --Din<=input(7 downto 0);  
                     output_ready <= '1';  
                end if;  
           end process;                      
           process(clk)  
           variable my_output_line : LINE;  
           variable input1: integer;  
           begin  
                if falling_edge(clk) then  
                     if output_ready ='1' then  
                          write(my_output_line, to_integer(signed(Dout)));  
                          writeline(my_output,my_output_line);  
                     end if;  
                end if;  
           end process;   
                                
 end Architecture; 