LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY alu IS
	PORT( 
		in1_alu, in2_alu		: 	IN 		STD_LOGIC_VECTOR(31 DOWNTO 0);
		sel_alu					: 	IN 		STD_LOGIC_VECTOR(3 DOWNTO 0);
		out_alu					: 	OUT 		STD_LOGIC_VECTOR(31 DOWNTO 0)		
	);
END alu;

ARCHITECTURE comportamento OF alu IS
	
	BEGIN
	--aritimetica--
	WITH sel_alu (3 DOWNTO 0) SELECT
		out_alu <= 	in1_alu + in2_alu 	WHEN "0000", -- ADD
						in1_alu - in2_alu		WHEN "1000", -- SUB						
	--logica-- 
						in1_alu XOR in2_alu	WHEN "0100", -- XOR
						in1_alu OR  in2_alu 	WHEN "0110", -- OR
						in1_alu AND in2_alu	WHEN "0111", -- AND							
						UNAFFECTED 				WHEN OTHERS;
	
END comportamento;