library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mips_datapath is
port(
		clk: in std_logic;
		reset: in std_logic
		);
end mips_datapath;

architecture arch of mips_datapath is

component mux is
port(
		i_data0: in std_logic_vector(31 downto 0);
		i_data1: in std_logic_vector(31 downto 0);
		sel: in std_logic;
		o_data: buffer std_logic_vector(31 downto 0)
		);
end component;

component alu is
port(
		i_operand1: in std_logic_vector(31 downto 0);
		i_operand2: in std_logic_vector(31 downto 0);
		o_result: out std_logic_vector(31 downto 0);
		zero: out std_logic;
		alu_control: in std_logic_vector(3 downto 0)
		);
end component;

component alu_control is
port(
		alu_op: in std_logic_vector(1 downto 0);
		instr: in std_logic_vector(5 downto 0);
		alu_func: out std_logic_Vector(3 downto 0)
		);
end component;

component control is
port(
		opcode: in std_logic_vector(5 downto 0);
		reg_dst: out std_logic;
		jump: out std_logic;
		branch: out std_logic;
		mem_read: out std_logic;
		mem_write: out std_logic;
		mem_to_reg: out std_logic;
		ALU_op: out std_logic_vector(1 downto 0);
		ALU_src: out std_logic;
		reg_write: out std_logic
		);
end component;

component data_memory is
port(
		clk: std_logic;
		address: in std_logic_vector(31 downto 0);
		mem_read: in std_logic;
		mem_write: in std_logic;
		data_wr: in std_logic_vector(31 downto 0);
		data_rd: out std_logic_vector(31 downto 0)
		);
end component;

component instr_mem is
port(
		address: in std_logic_vector(31 downto 0);
		reset: in std_logic;
		o_instr: out std_logic_vector(31 downto 0)
		);
end component;

component registers_file is
port(
		reg_write: in std_logic;
		read_reg1: in std_logic_vector(4 downto 0);
		read_reg2: in std_logic_vector(4 downto 0);
		write_reg: in std_logic_vector(4 downto 0);
		i_wr_data: in std_logic_vector(31 downto 0);
		o_read_data2: out std_logic_vector(31 downto 0);
		o_read_data1: out std_logic_vector(31 downto 0)
		);
end component;

component sign_extend is
port(
		i_16bit: in std_logic_vector(15 downto 0);
		o_32bit: out std_logic_vector(31 downto 0)
		);
end component;

component mux_5bits is
port(
		i_data0: in std_logic_vector(4 downto 0);
		i_data1: in std_logic_vector(4 downto 0);
		sel: in std_logic;
		o_data: out std_logic_vector(4 downto 0)
		);
end component;

component shift_left_2bits is
port(
		shift_in: in std_logic_vector(25 downto 0);
		shift_out: out std_logic_vector(27 downto 0)
		);
end component;

component program_counter is
port(
		clk: in std_logic;
		in_count: in std_logic_vector(31 downto 0);
		jmp_brch_active: in std_logic;
		in_address: in std_logic_vector(31 downto 0);
		out_count: out std_logic_vector(31 downto 0)
		);
end component;


signal out_count : std_logic_vector(31 downto 0) := x"003FFFFc";
signal out_count1 : std_logic_vector(31 downto 0) := x"003FFFFc";
signal o_instr: std_logic_vector(31 downto 0);
signal reg_dst, jump, branch,mem_read, mem_write, mem_to_reg, ALU_src, reg_write: std_logic;
signal ALU_op: std_logic_vector(1 downto 0);
signal o_data_mux1: std_logic_vector(4 downto 0);
signal o_data_mux2, o_data_mux3, o_data_mux4, o_data_mux5, i_data0_mux5: std_logic_vector(31 downto 0);
signal i_operand1, i_operand2, result_alu, o_read_data2_alu, i_operand2_alu2: std_logic_vector(31 downto 0);
signal zero, sel_mux4: std_logic;
signal o_sign_extend: std_logic_vector(31 downto 0);
signal alu_func :  std_logic_Vector(3 downto 0);
signal data_rd_data_memory: std_logic_vector(31 downto 0);
signal result_alu1, result_alu2: std_logic_vector(31 downto 0);
signal shift_out, shift_out2: std_logic_vector(27 downto 0);
signal jmp_brch_active: std_logic := '0';


begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(reset /= '1' and jmp_brch_active /= '1') then
				out_count1 <= out_count1 + 4;
			elsif(reset = '1') then
				out_count1 <=  x"003FFFFc";
			end if;
			
			if(jmp_brch_active = '1') then
				out_count1 <= i_data0_mux5 + 4 ;	
			end if;
		end if;
	end process;
	

	
	
	U11: component program_counter
	port map(clk => clk,
				in_count => out_count1 ,
				jmp_brch_active => jmp_brch_active,
				in_address => o_data_mux5,
				--reset => reset,
				out_count => out_count);
	
	U1:  component instr_mem
	port map(address => out_count, ---------
				reset => reset,
				o_instr => o_instr);
	
	U2:  component control
	port map(opcode => o_instr(31 downto 26),
				reg_dst => reg_dst,
				jump => jump,
				branch => branch,
				mem_read => mem_read,
				mem_write => mem_write,
				mem_to_reg => mem_to_reg,
				ALU_op => ALU_op,
				ALU_src => ALU_src,
				reg_write => reg_write
				);
	
	U3:  component registers_file
	port map(reg_write => reg_write,
				read_reg1 => o_instr(25 downto 21),
				read_reg2 => o_instr(20 downto 16), 
				write_reg => o_data_mux1, 
				i_wr_data => o_data_mux3, 
				o_read_data2 => o_read_data2_alu, 
				o_read_data1 => i_operand1);
	
	U4:  component mux_5bits
	port map(i_data0 => o_instr(20 downto 16), 
				i_data1 => o_instr(15 downto 11), 
				sel => reg_dst,
				o_data => o_data_mux1);
	
	U5:  component alu
	port map(i_operand1 => i_operand1,
				i_operand2 => o_data_mux2,
				o_result => result_alu,
				zero => zero,
				alu_control => alu_func);
	
	U6:  component mux
	port map(i_data0 => o_read_data2_alu, 
				i_data1 => o_sign_extend, 
				sel => ALU_src ,
				o_data => o_data_mux2);
				
	U7:  component sign_extend
	port map(i_16bit => o_instr(15 downto 0),
				o_32bit => o_sign_extend);
				
	U8:  component alu_control
	port map(alu_op => ALU_op, 
				instr => o_instr(5 downto 0),
				alu_func => alu_func);
				
	U9:  component data_memory
	port map(clk => clk,
				address => result_alu, 
				mem_read => mem_read,
				mem_write => mem_write,
				data_wr => o_read_data2_alu, 
				data_rd => data_rd_data_memory);
	
	U10:  component mux
	port map(i_data0 => result_alu, 
				i_data1 => data_rd_data_memory, 
				sel =>  mem_to_reg,
				o_data => o_data_mux3);
				
	
	jmp_brch_active <= branch or jump;
	
	U12:  component alu
	port map(i_operand1 => out_count,
				i_operand2 => x"00000004",
				o_result => result_alu1,
				zero => open,
				alu_control => "0010");
	
	U13: component shift_left_2bits
	port map(shift_in => o_instr(25 downto 0),
				shift_out => shift_out);
	
	i_data0_mux5 <= result_alu1(31 downto 28) & shift_out;
	
	U14: component mux
	port map(i_data0 => o_data_mux4, 
				i_data1 => i_data0_mux5, 
				sel => jump ,
				o_data => o_data_mux5);
	
	sel_mux4 <= branch and zero;
	
	U15:  component mux
	port map(i_data0 => result_alu1 , 
				i_data1 => result_alu2, 
				sel => sel_mux4,
				o_data => o_data_mux4);
				
	i_operand2_alu2 <= o_sign_extend(29 downto 26) & shift_out2;
	
	U16: component alu
	port map(i_operand1 => result_alu1,
				i_operand2 => i_operand2_alu2,
				o_result => result_alu2,
				zero => open,
				alu_control => "0010");
				
	U17: component shift_left_2bits
	port map(shift_in => o_sign_extend(25 downto 0),
				shift_out => shift_out2);
	

end arch;
				
	
	
	
	
	
	

	