LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux4 IS
	PORT(
		in0_mux, in1_mux, in2_mux, in3_mux		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		sel_mux											:	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
		out_mux											:	OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END mux4;

ARCHITECTURE comportamento OF mux4 IS
	BEGIN
		WITH sel_mux SELECT
			out_mux	 <= in0_mux WHEN "00", 
							 in1_mux WHEN "01",						
							 in2_mux WHEN "10",						
							 in3_mux WHEN "11";						
END comportamento;