LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY geradorImm IS
	PORT(
		in_ger		:	IN		STD_LOGIC_VECTOR(11 DOWNTO 0);
		out_ger		:	OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END geradorImm;

ARCHITECTURE comportamento OF geradorImm IS
	BEGIN
	PROCESS(in_ger)
	BEGIN
		IF(in_ger(11) = '0') THEN
			out_ger(31 DOWNTO 12) <= "00000000000000000000";
		ELSE 
			out_ger(31 DOWNTO 12) <= "11111111111111111111";
		END IF;
			out_ger(11 DOWNTO 0) <= in_ger(11 DOWNTO 0);
	END PROCESS;
END comportamento;