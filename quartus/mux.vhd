LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux IS
	PORT(
		in1_mux, in2_mux		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		sel_mux					:	IN		STD_LOGIC;
		out_mux					:	OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END mux;

ARCHITECTURE comportamento OF mux IS
	BEGIN
		WITH sel_mux SELECT
			out_mux	 <= in1_mux WHEN '0', 
							 in2_mux WHEN '1';						
END comportamento;