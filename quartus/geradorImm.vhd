LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY geradorImm IS
	PORT(
		in_ger		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		imm_sel		:	IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
		out_ger		:	OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END geradorImm;

ARCHITECTURE comportamento OF geradorImm IS
	BEGIN
	PROCESS(imm_sel)
	BEGIN
		CASE imm_sel IS
				WHEN "00" => --tipo I
					IF(in_ger(31) = '0') THEN
						out_ger(31 DOWNTO 12) <= "00000000000000000000";
					ELSE 
						out_ger(31 DOWNTO 12) <= "11111111111111111111";
					END IF;
					out_ger(11 DOWNTO 0) <= in_ger(31 DOWNTO 20);
				
				WHEN "01" => --tipo B
					IF(in_ger(31) = '0') THEN
						out_ger(31 DOWNTO 13) <= "0000000000000000000";
					ELSE 
						out_ger(31 DOWNTO 13) <= "1111111111111111111";
					END IF;
					out_ger(12 DOWNTO 0) <= in_ger(31) 
														& in_ger(7) 
														& in_ger(30 DOWNTO 25) 
														& in_ger(11 DOWNTO 8) 
														& '0';
															
				WHEN "10" => --tipo J
					IF(in_ger(31) = '0') THEN
						out_ger(31 DOWNTO 21) <= "00000000000";
					ELSE 
						out_ger(31 DOWNTO 21) <= "11111111111";
					END IF;
					out_ger(20 DOWNTO 0) <= in_ger(31) 
														& in_ger(19 DOWNTO 12)
														& in_ger(20)
														& in_ger(30 DOWNTO 21)
														& '0';
				WHEN OTHERS => NULL;
		END CASE;		
	END PROCESS;
END comportamento;