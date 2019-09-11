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
		VARIABLE i : integer;
		VARIABLE alu_temp : STD_LOGIC_VECTOR(31 DOWNTO 0);
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
					
				WHEN "0001" => --SLL
				i := 0;
				alu_temp := in1_alu;
					WHILE i < TO_INTEGER(IEEE.NUMERIC_STD.UNSIGNED(in2_alu(4 DOWNTO 0))) LOOP
						alu_temp(31 DOWNTO 0) := alu_temp(30 DOWNTO 0) & '0';
						i := i + 1;
					END LOOP;
				out_alu <= alu_temp;
				
				WHEN "0101" => --SRL
				i := 0;
				alu_temp := in1_alu;
					WHILE i < TO_INTEGER(IEEE.NUMERIC_STD.UNSIGNED(in2_alu(4 DOWNTO 0))) LOOP
						alu_temp(31 DOWNTO 0) :=  '0' & alu_temp(31 DOWNTO 1);
						i := i + 1;
					END LOOP;
				out_alu <= alu_temp;
				
				WHEN "1101" => --SRA
				i := 0;
				alu_temp := in1_alu;
					WHILE i < TO_INTEGER(IEEE.NUMERIC_STD.UNSIGNED(in2_alu(4 DOWNTO 0))) LOOP
						alu_temp(31 DOWNTO 0) :=  alu_temp(31 DOWNTO 31) & alu_temp(31 DOWNTO 1);
						i := i + 1;
					END LOOP;
				out_alu <= alu_temp;
				
				WHEN "0010" => --SLT, caso rs1 seja menor que rs2 a saida da ALU deve ser 1
					alu_temp := in1_alu - in2_alu;
					out_alu <= "0000000000000000000000000000000" & alu_temp(31);
					
				WHEN "0011" => --SLTU
					--alu_temp := IEEE.NUMERIC_STD.UNSIGNED(in1_alu) - IEEE.NUMERIC_STD.UNSIGNED(in2_alu);
					IF(IEEE.NUMERIC_STD.UNSIGNED(in1_alu) < IEEE.NUMERIC_STD.UNSIGNED(in2_alu)) THEN
						out_alu <= "0000000000000000000000000000000" & '1';
					ELSE 
						out_alu <= "00000000000000000000000000000000";
					END IF;
				WHEN OTHERS => NULL;
			END CASE;
		END PROCESS;
END comportamento;
