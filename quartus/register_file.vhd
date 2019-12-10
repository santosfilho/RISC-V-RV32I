LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY register_file IS
	PORT(
		clock	: 	IN		STD_LOGIC;
		-- Porta de escrita
		rd		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		add_rd:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
		w_rd	:	IN		STD_LOGIC;
		-- Porta de leiura
		rs1		:	OUT		STD_LOGIC_VECTOR(31 DOWNTO 0);
		add_rs1	:	IN			STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		rs2		:	OUT		STD_LOGIC_VECTOR(31 DOWNTO 0);
		add_rs2	:	IN			STD_LOGIC_VECTOR(4 DOWNTO 0)	
	);		
END register_file;

ARCHITECTURE comportamento OF register_file IS
	TYPE vector_array IS ARRAY(0 TO 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	SIGNAL memory : vector_array;

BEGIN
	PROCESS(clock, w_rd) 
	BEGIN
		IF (w_rd = '1') THEN
			IF (clock'event AND clock='1') THEN
				memory(TO_INTEGER(IEEE.NUMERIC_STD.UNSIGNED(add_rd))) <= rd;
			END IF;
		END IF;
		
		IF (clock'event AND clock='1') THEN
			rs1 <= memory(TO_INTEGER(IEEE.NUMERIC_STD.UNSIGNED(add_rs1)));
		END IF;		
				
		IF (clock'event AND clock='1') THEN
			rs2 <= memory(TO_INTEGER(IEEE.NUMERIC_STD.UNSIGNED(add_rs2)));
		END IF;
	memory(0) <= conv_std_logic_vector(0,32); --x0 e sempre "00000000000000000000000000000000";
	memory(1) <= conv_std_logic_vector(6,32); 
	memory(2) <= conv_std_logic_vector(10,32);
	--memory(1) <= conv_std_logic_vector(6,32);
	--memory(1) <= "11111111111111111111111111111000";-- -8 conv_std_logic_vector(5,32);
	memory(3) <= conv_std_logic_vector(25,32);--"00000000000000000000000011111111";-- -4  conv_std_logic_vector(2,32);
	memory(4) <= "00000000000000001111111111111111";
	END PROCESS;
END comportamento;