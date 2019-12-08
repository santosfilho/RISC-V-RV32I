LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY progam_memory_0 IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		clock			: IN STD_LOGIC;
		q				: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END progam_memory_0;


ARCHITECTURE comportamento OF progam_memory_0 IS

	COMPONENT progam_memory IS
		PORT
		(
			address		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			clock			: IN STD_LOGIC  := '1';
			q				: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;
	
	BEGIN
		progam_memory_port : progam_memory PORT MAP (
				address => address(11 DOWNTO 2),
				clock => clock,
				q => q
		);
	
END comportamento;