LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mux_pc_in IS
	PORT(
		in1_mux, in2_mux		:	IN		STD_LOGIC_VECTOR(11 DOWNTO 0);
		sel_mux					:	IN		STD_LOGIC;
		out_mux					:	OUT 	STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END mux_pc_in;

ARCHITECTURE comportamento OF mux_pc_in IS
	BEGIN
		WITH sel_mux SELECT
			out_mux	 <= in1_mux WHEN '0', 
							 in2_mux+"100" WHEN '1';						
END comportamento;