library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu_control is
port(
		alu_op: in std_logic_vector(1 downto 0);
		instr: in std_logic_vector(5 downto 0);
		alu_func: out std_logic_Vector(3 downto 0)
		);
end alu_control;

architecture arch of alu_control is

--constant and_op: std_logic_vector(3 downto 0) := "0000";
--constant or_op: std_logic_vector(3 downto 0) := "0001";
--constant add: std_logic_vector(3 downto 0) := "0010";
--constant sub: std_logic_vector(3 downto 0) := "0110";
--constant slt: std_logic_vector(3 downto 0) := "0111";
--constant nor_op: std_logic_vector(3 downto 0) := "1100";


begin

alu_func(3) <= '0';
alu_func(2) <= alu_op(0) or( alu_op(1) and instr(1));
alu_func(1) <= not alu_op(1) or not instr(2);
alu_func(0) <= (instr(3) or instr(0)) and alu_op(1);

--	alu_func <= add when(alu_op="10" and instr="100000") else
--					sub when(alu_op="10" and instr="100010") else
--					and_op when(alu_op="10" and instr="100100") else
--					or_op when(alu_op="10" and instr="100101") else
--					slt when(alu_op="10" and instr="101010") else
--					nor_op when (alu_op = "10" and instr = "100111");

end arch;