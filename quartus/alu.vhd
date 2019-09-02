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
	
	PROCESS(sel_alu)
	BEGIN
	--aritimetica--
		CASE sel_alu IS
			WHEN "0000" =>
				out_alu <= 	in1_alu + in2_alu; --ADD 	
			WHEN "1000" => 
				out_alu <= in1_alu - in2_alu;	 --SUB						
	--logica-- 
			WHEN "0100" => 
				out_alu <= in1_alu XOR in2_alu; -- XOR
			WHEN "0110" => 
				out_alu <= in1_alu OR  in2_alu; -- OR
			WHEN "0111" => 
				out_alu <= in1_alu AND in2_alu; -- AND
			WHEN OTHERS => NULL;
				
	
END comportamento;