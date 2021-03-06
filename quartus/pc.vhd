library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY pc IS
	PORT( 
		clock		: 	IN 	STD_LOGIC;
		reset_pc	: 	IN 	STD_LOGIC;
		enable_pc: 	IN 	STD_LOGIC;
--		load_pc	: 	IN 	STD_LOGIC;
		end8		: 	in 	STD_LOGIC_VECTOR(31 downto 0);
		pc_out	: 	out 	STD_LOGIC_VECTOR(31 downto 0)
	);
END pc;

ARCHITECTURE comportamento OF pc IS
BEGIN
		PROCESS(clock,reset_pc)--,load_pc)
			VARIABLE temp	:	std_logic_vector(31 DOWNTO 0); 
		begin
			if (reset_pc='1') then
				temp := "00000000000000000000000000000000";
			elsif (clock'event and clock='1') then
				if (enable_pc='1') then
					--temp := temp + '1';
					temp := end8;
				--elsif (load_pc='1') then
				end if;
			end if;
		pc_out <= temp;
		end process;	
end comportamento;