library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity control is
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
end control;

architecture arch of control is

begin
	process(opcode)
	begin
		
		reg_write <= '0';
		
		case opcode is
			when "000000" =>  ------- alu: add, sub, slt, and, or,..
					reg_dst <= '1';
					jump <= '0';
					branch <= '0';
					mem_read <= '0';
					mem_write <= '0';
					mem_to_reg <='0';
					ALU_op <= "10";
					ALU_src <='0';
					reg_write <= '1' after 0.5 ps;
			
			when "100011" =>  ------ lw: 0x23 
					reg_dst <= '0';
					jump <= '0';
					branch <= '0';
					mem_read <= '1';
					mem_write <= '0';
					mem_to_reg <='1';
					ALU_op <= "00";
					ALU_src <='1';
					reg_write <= '1' after 0.5 ps;
					
			when "101011" =>  ------ sw: 0x2b 
					reg_dst <= 'X';
					jump <= '0';
					branch <= '0';
					mem_read <= '0';
					mem_write <= '1';
					mem_to_reg <='X';
					ALU_op <= "00";
					ALU_src <='1';
					reg_write <= '0';
			
			when "000100" =>  ------ beq: 0x04 
					reg_dst <= 'X';
					jump <= '0';
					branch <= '1' after 0.5 ps;
					mem_read <= '0';
					mem_write <= '0';
					mem_to_reg <='X';
					ALU_op <= "01";
					ALU_src <='0';
					reg_write <= '0';
					
			when "000010" =>  ------ j: 0x02 
					reg_dst <= 'X';
					jump <= '1';
					branch <= '0'; 
					mem_read <= '0';
					mem_write <= '0';
					mem_to_reg <='X';
					ALU_op <= "00";
					ALU_src <='0';
					reg_write <= '0';
					
			when others => 
					reg_dst <= '0';
					jump <= '0';
					branch <= '0'; 
					mem_read <= '0';
					mem_write <= '0';
					mem_to_reg <='0';
					ALU_op <= "00";
					ALU_src <='0';
					reg_write <= '0';
			end case;
	end process;
			
end arch;	
