library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity cpu is
port(
		clk: in std_logic;
		data_in_ram: in std_logic_vector(7 downto 0);
--		data_out_cpu: out std_logic_vector(7 downto 0)
		wr_en_cpu: in std_logic;
		rd_en_cpu: in std_logic
		);
end cpu;

architecture arch of cpu is

--signal rd_en_ram: std_logic;
--signal wr_en_ram: std_logic;
signal counter: integer range 0 to 7;
--signal data_in_ram: std_logic_vector(7 downto 0);
signal data_out_ram: std_logic_vector(7 downto 0);

signal data_from_instr_reg: std_logic_vector(7 downto 0); ---in decoded --> out instr_reg
--signal rd_en1_cpu, wr_en1_cpu: std_logic;
--signal ALU_out, ALU_a, ALU_b: std_logic_vector(1 downto 0);

signal load_en,store_en  : std_logic;
signal ALU_en: std_logic := '0';
signal reset_ALU: std_logic;
--signal MUX_out1, MUX_out2 : integer;

signal data_out_reg_array1, data_out_reg_array2, data_from_instr_reg1: std_logic_vector(7 downto 0);

signal result_ALU, result_out_accum: std_logic_vector(7 downto 0);
signal address_reg_in, address_reg_out1, address_reg_out2: integer range 0 to 7;

component program_counter is
port(
		clk: in std_logic;
		address_out: out integer range 0 to 7
		);
end component;

component accumulator is
port(
		clk: in std_logic; 
		result_in: in std_logic_vector(7 downto 0);
		reset_ALU: out std_logic;
		ALU_en: in std_logic;
		result_out: out std_logic_vector(7 downto 0)
		);
end component;

component instr_reg is
port(
		clk: in std_logic;
		address_in: in integer range 0 to 7;
		data_in_instr_reg: in std_logic_vector(7 downto 0);
		data_out_instr_reg: out std_logic_vector(7 downto 0)
		);
end component;

component register_array is
generic(
			width_reg: integer := 8;
			number_of_reg: integer := 4);
port(
--		load_in_reg: in std_logic;
		load_out_reg: in std_logic;
		clk: in std_logic;
		address_reg_in: in integer range 0 to 3 ;
		address_reg_out: in integer range 0 to 3 ;
		data_in: in std_logic_vector(7 downto 0);		
		data_out: out std_logic_vector(7 downto 0)
		);
end component;

component ALU is
port(
		clk: in std_logic;
		choose_op: in std_logic_vector(1 downto 0);
		a, b: in std_logic_vector(7 downto 0);
		ALU_ena: in std_logic;
		result: out std_logic_vector(7 downto 0)
		);
end component; 

component decoded is
port(
		clk: in std_logic;
		data_from_instr_reg: in std_logic_vector(7 downto 0);
		ALU_en: out std_logic;
		reset_ALU: in std_logic;
		load_en: out std_logic;
		store_en: out std_logic
		);
end component;

component RAM is
generic( RAM_depth: integer := 8;
			length_cell: integer := 8
			);
port(
		clk: in std_logic;
		rd_en: in std_logic;
		wr_en: in std_logic;
		address: in integer range 0 to 7;
		data_in: in std_logic_vector(7 downto 0);
		data_out: out std_logic_vector(7 downto 0)
		);
end component;

--component ALU_dis is
--port(
--		clk: in std_logic;
--		delay_1clk: in std_logic;
--		ALU_off: out std_logic
----		load_en: out std_logic;
----		store_en: out std_logic
--		);
--end component;

--component delay is
--port(
--		clk: in std_logic;
--		ALU_en: in std_logic;
--		delay_1clk: out std_logic
--		);
--end component;

--component reset_delay is
--port(
--		clk: in std_logic;
--		delay_1clk : inout std_logic
--		);
--end component;

begin
	U1: component program_counter 
	port map(clk => clk, address_out => counter);
	
	U2: component instr_reg 
	port map(clk => clk,
				address_in => counter,
				data_in_instr_reg => data_out_ram,
				data_out_instr_reg => data_from_instr_reg);
	
	U3: component RAM 
	port map(clk => clk,
				rd_en => rd_en_cpu,
				wr_en => wr_en_cpu,
				address => counter,
				data_in => data_in_ram, 
				data_out => data_out_ram);
				
	U4: component decoded
	port map(clk => clk,
				data_from_instr_reg => data_from_instr_reg,
				ALU_en => ALU_en,
				reset_ALU => reset_ALU, 
				load_en => load_en,
				store_en => store_en);
												  				
				
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(data_from_instr_reg(7 downto 6) /= "01") then
				data_from_instr_reg1 <= "0000" & data_from_instr_reg(3 downto 0);	
				address_reg_in <= to_integer(unsigned(data_from_instr_reg(5 downto 4)));
			else
				address_reg_out1 <= to_integer(unsigned(data_from_instr_reg(3 downto 2)));
				address_reg_out2 <= to_integer(unsigned(data_from_instr_reg(1 downto 0)));
			end if;
		end if;
	end process;
			
	U5: component register_array 
	port map(
				load_out_reg => ALU_en,
				clk => clk,
				address_reg_in => address_reg_in,
				address_reg_out => address_reg_out1,
				data_in => data_from_instr_reg1,
				data_out => data_out_reg_array1);
	
	U6: component register_array 
	port map(
				load_out_reg => ALU_en,
				clk => clk,
				address_reg_in => address_reg_in,
				address_reg_out => address_reg_out2, 
				data_in => data_from_instr_reg1,
				data_out => data_out_reg_array2);
								
	U7: component ALU 
	port map(clk => clk,
				choose_op =>  data_from_instr_reg(5 downto 4),
				ALU_ena => ALU_en,
				a => data_out_reg_array1,
				b => data_out_reg_array2,
				result => result_ALU); 
				
	U8 : component accumulator 
	port map(clk => clk,
				result_in => result_ALU,
				reset_ALU => reset_ALU,
				ALU_en => ALU_en,
				result_out => result_out_accum);
				
--	U9: component ALU_dis
--	port map(clk => clk,
--				delay_1clk => delay_1clk,
--				ALU_off => ALU_off);
				
--	U10: component delay 
--	port map(clk => clk,
--				ALU_en => ALU_en,
--				delay_1clk => delay_1clk);
--				
--	U11: component reset_delay
--	port map(clk => clk,
--				delay_1clk => delay_1clk);

				
	
	
--	process(clk)
--	begin
--			if(rising_edge(clk)) then
--				if(delay_1clk = '1') then
--					delay_1clk <= '0';
--				end if;
--			end if;
--	end process;
	
				
	
	--data_in <= data_in_ram;
	
--	process(clk)
--	begin
--		if(rising_edge(clk)) then
--			if(data_out_ram(7 downto 6) = "10") then
--				wr_en_cpu <= '1';
--				rd_en_cpu <= '0';
--			else
--				wr_en_cpu <= '0';
--				rd_en_cpu <= '1';
--			end if;
--		end if;
--	end process;
	
end arch;

		

