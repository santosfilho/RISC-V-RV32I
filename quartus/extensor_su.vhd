LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY extensor_su IS
	PORT(
		in_ext_su		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		sel_su			:	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
		out_ext_su		:	OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END extensor_su;

ARCHITECTURE comportamento OF extensor_su IS
	BEGIN
		PROCESS(sel_su)
			BEGIN
				CASE sel_su IS
					WHEN "00" => -- LB
						IF (in_ext_su(7) = '0') THEN
							out_ext_su <= in_ext_su;
						ELSE 
							out_ext_su <= "111111111111111111111111" & in_ext_su(7 DOWNTO 0);
						END IF;
						
					WHEN "01" => -- LH
						IF (in_ext_su(15) = '0') THEN
							out_ext_su <= in_ext_su;
						ELSE 
							out_ext_su <= "1111111111111111" & in_ext_su(15 DOWNTO 0);
						END IF;
						
					WHEN "10" =>  -- LBU/LHU/LW
						out_ext_su <= in_ext_su;
						
					WHEN OTHERS => NULL;
				END CASE;
			END PROCESS;
			
END comportamento;