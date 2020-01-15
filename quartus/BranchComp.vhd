LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY BranchComp IS
	PORT(
		A			:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		B			:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		BrUn		:	IN		STD_LOGIC;
		BrEq		:	OUT	STD_LOGIC;
		BrLT		:	OUT	STD_LOGIC
	);
END BranchComp;

ARCHITECTURE comportamento OF BranchComp IS
	BEGIN	
	
		PROCESS(A, B, BrUn)
			BEGIN
				CASE BrUn IS
					WHEN '1' =>
						IF UNSIGNED(A) = UNSIGNED(B) THEN
							BrEq <= '1';
						ELSE
							BrEq <= '0';
						END IF;
						
						IF (UNSIGNED(A) < UNSIGNED(B)) THEN
							BrLT <= '1';
						ELSE
							BrLT <= '0';
						END IF;
					
					WHEN '0' =>
						IF (A = B) THEN
							BrEq <= '1';
						ELSE
							BrEq <= '0';
						END IF;
						
						IF (A < B) THEN
							BrLT <= '1';
						ELSE
							BrLT <= '0';
						END IF;
				END CASE;
				
		END PROCESS;		
END comportamento;