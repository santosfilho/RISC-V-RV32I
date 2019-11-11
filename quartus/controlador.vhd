LIBRARY ieee;
LIBRARY work;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;
USE ieee.numeric_std.all;
USE work.all;

entity controlador is
port(
		clock			:	IN		STD_LOGIC;		
		reset			:	IN		STD_LOGIC;
		instrucao	: 	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		w_rd			:	OUT	STD_LOGIC;		
		enable_pc	:  OUT	STD_LOGIC;
		BSel			:	OUT	STD_LOGIC;
		MemRW			: 	OUT	STD_LOGIC;
		WBSel			: 	OUT	STD_LOGIC_VECTOR(1 DOWNTO 0);
		ALUSel		:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
		sel_bhw		: 	OUT	STD_LOGIC_VECTOR(2 DOWNTO 0);
		sel_su		:  OUT	STD_LOGIC_VECTOR(1 DOWNTO 0); -- necessario para LB, LH, LBU, LHU			
		ASel			: 	OUT	STD_LOGIC;
		BrUn			: 	OUT	STD_LOGIC;
		imm_sel		:	OUT	STD_LOGIC_VECTOR(1 DOWNTO 0);
		PCSel			: 	OUT	STD_LOGIC;
		BrEq			:	OUT	STD_LOGIC;
		BrLT			:	OUT	STD_LOGIC;
);
end controlador;

ARCHITECTURE controlador OF mux4 IS
	BEGIN
	PROCESS(clock, reset)
	BEGIN
		CASE instrucao IS
								
END controlador;
