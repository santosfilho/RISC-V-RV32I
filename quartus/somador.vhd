library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY somador IS
	PORT( 
		end8		   : 	in 	STD_LOGIC_VECTOR(11 downto 0);
		somador_out	: 	out 	STD_LOGIC_VECTOR(11 downto 0)
	);
END somador;

ARCHITECTURE comportamento OF somador IS
BEGIN
		somador_out <= end8 + "100";
end comportamento;