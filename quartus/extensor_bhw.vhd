LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY extensor_bhw IS
	PORT(
		data_bhw_in			:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		sel_bhw				:	IN		STD_LOGIC_VECTOR(2 DOWNTO 0);
		ext_data_bhw		:	OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END extensor_bhw;

ARCHITECTURE comportamento OF extensor_bhw IS
	BEGIN
		WITH sel_bhw SELECT
			ext_data_bhw	 <=	"000000000000000000000000" & data_bhw_in(7 DOWNTO 0) WHEN "000",  --byte
										"0000000000000000" & data_bhw_in(15 DOWNTO 0) WHEN "001",	--half word
										data_bhw_in(31 DOWNTO 0) WHEN "010",	--word
										UNAFFECTED WHEN OTHERS;
END comportamento;