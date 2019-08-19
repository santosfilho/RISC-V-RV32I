library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY pc IS
	PORT( 
		clock		: 	IN 	STD_LOGIC;
		reset_pc	: 	IN 	STD_LOGIC;
		enable_pc: 	IN 	STD_LOGIC;
		load_pc	: 	IN 	STD_LOGIC;
		end8		: 	in 	STD_LOGIC_VECTOR(7 downto 0);
		pc_out	: 	out 	std_logic_vector(7 downto 0) 
	);
END pc;

ARCHITECTURE comportamento OF pc IS
BEGIN
		PROCESS(clock,reset)
			VARIABLE temp	:	std_logic_vector(7 DOWNTO 0); 
		begin
			if (rst='1') then
				temp := "00000000";
			elsif (clk'event and clk='1') then
				if (en_cnt='1') then
					temp := temp + '1';
				elsif (ld_pc='1') then
					temp := end8;			
				end if;
			end if;
		pc <= temp;	
		end process;	
end comportamento;