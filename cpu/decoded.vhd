library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity decoded is
port(
		clk: in std_logic;
		data_from_instr_reg: in std_logic_vector(7 downto 0);
		ALU_en: out std_logic;
		reset_ALU: in std_logic;
		load_en: out std_logic;
		store_en: out std_logic
		);
end decoded;

architecture arch of decoded is 

begin

--	ALU_en <= '1'  when  (data_from_instr_reg(7 downto 6) = "01") else
--				 '0'  when  (data_from_instr_reg(7 downto 6) = "00") else
--				 '0' when  (data_from_instr_reg(7 downto 6) = "10");
--	
--	load_en <= '0'  when  (data_from_instr_reg(7 downto 6) = "01") else
--				  '1'  when  (data_from_instr_reg(7 downto 6) = "00") else
--				  '0' when  (data_from_instr_reg(7 downto 6) = "10");
--				  
--	store_en <= '0'  when  (data_from_instr_reg(7 downto 6) = "01") else
--				   '0'  when  (data_from_instr_reg(7 downto 6) = "00") else
--				   '1' when  (data_from_instr_reg(7 downto 6) = "10");
--	
		process(clk)
		begin
			if(rising_edge(clk)) then
				if(reset_ALU /='1') then
					if(data_from_instr_reg(7 downto 6) = "01") then
						ALU_en <= '1';
						load_en <= '0';
						store_en <= '0';
					elsif(data_from_instr_reg(7 downto 6) = "00") then
						ALU_en <= '0';
						load_en <= '1';
						store_en <= '0';
					elsif(data_from_instr_reg(7 downto 6) = "10") then
						ALU_en <= '0';
						load_en <= '0';
						store_en <= '1';
					end if;
				else
						ALU_en <= '0';
						load_en <= '0';
						store_en <= '0';
				end if;
			end if;
		end process;		
end arch;
