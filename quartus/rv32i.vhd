LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY rv32i IS
	PORT(
		clock	: 	IN		STD_LOGIC;
		reset : 	IN		STD_LOGIC;
		enable_pc : IN STD_LOGIC;
		-- SAIDAS DE TESTE
		alu_teste	: 	OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		aluA			:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0);	
		aluB			: 	OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		instrucao_teste 	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		dmem_saida_teste  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		rd_teste  	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		pc_teste  	: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		pc4_teste  	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);		
END rv32i;

ARCHITECTURE comportamento OF rv32i IS
	COMPONENT datapath IS 
		PORT(
			clock			:	IN		STD_LOGIC;		
			reset			:	IN		STD_LOGIC;
			w_rd			:	IN		STD_LOGIC;		
			enable_pc	:  IN		STD_LOGIC;
			BSel			:	IN		STD_LOGIC;
			MemRW			: 	IN		STD_LOGIC;
			WBSel			: 	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
			ALUSel		:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
			sel_bhw		: 	IN		STD_LOGIC_VECTOR(2 DOWNTO 0);
			sel_su		:  IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);	
			ASel			: 	IN		STD_LOGIC;
			BrUn			: 	IN		STD_LOGIC;
			imm_sel		:	IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
			PCSel			: 	IN		STD_LOGIC;
			BrEq			:	OUT	STD_LOGIC;
			BrLT			:	OUT	STD_LOGIC;
			instrucao 	:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			-- SAIDAS DE TESTE
			alu_teste	: 	OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			aluA			:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0);	
			aluB			: 	OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			dmem_saida_teste  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			rd_teste  	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			pc_teste  	: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
			pc4_teste  	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT controlador IS
		PORT( 
			instrucao	: 	IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
			clock			:	IN		STD_LOGIC;
			w_rd			:	OUT	STD_LOGIC;
			--enable_pc	: 	OUT	STD_LOGIC;
			BSel			:	OUT	STD_LOGIC;
			MemRW			: 	OUT	STD_LOGIC;
			WBSel			: 	OUT	STD_LOGIC_VECTOR(1 DOWNTO 0);
			ALUSel		:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
			sel_bhw		: 	OUT	STD_LOGIC_VECTOR(2 DOWNTO 0);
			sel_su		: 	OUT 	STD_LOGIC_VECTOR(1 DOWNTO 0);		
			ASel			: 	OUT	STD_LOGIC;
			BrUn			: 	OUT	STD_LOGIC;
			imm_sel		:	OUT 	STD_LOGIC_VECTOR(2 DOWNTO 0);
			PCSel			: 	OUT	STD_LOGIC;
			BrEq			:	IN		STD_LOGIC;
			BrLT			:	IN		STD_LOGIC
		);
	END COMPONENT;
	
	SIGNAL instrucao_sinal 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL w_rd_sinal	: STD_LOGIC;
	--SIGNAL enable_pc_sinal 	: STD_LOGIC;
	SIGNAL BSel_sinal	: STD_LOGIC;
	SIGNAL MemRW_sinal : STD_LOGIC;
	SIGNAL WBSel_sinal : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL ALUSel_sinal : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL sel_bhw_sinal	: STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL sel_su_sinal	: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL ASel_sinal		: STD_LOGIC;
	SIGNAL BrUn_sinal	: STD_LOGIC;
	SIGNAL imm_sel_sinal	: STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL PCSel_sinal : STD_LOGIC;
	SIGNAL BrEq_sinal	: STD_LOGIC;
	SIGNAL BrLT_sinal	: STD_LOGIC;
	
	BEGIN
		datapath_0 : datapath PORT MAP(
			clock			=> clock,
			reset			=>	reset,
			w_rd			=> w_rd_sinal,
			enable_pc	=> enable_pc,
			BSel			=> BSel_sinal,
			MemRW			=> MemRW_sinal,
			WBSel			=> WBSel_sinal,
			ALUSel		=> ALUSel_sinal,
			sel_bhw		=> sel_bhw_sinal,
			sel_su		=> sel_su_sinal,
			ASel			=> ASel_sinal,
			BrUn			=> BrUn_sinal,
			imm_sel		=> imm_sel_sinal,
			PCSel			=> PCSel_sinal,
			BrEq			=> BrEq_sinal,
			BrLT			=> BrLT_sinal,
			instrucao 	=> instrucao_sinal,
			-- SAIDAS DE TESTE
			alu_teste	=> alu_teste,
			aluA			=> aluA,
			aluB			=> aluB,
			dmem_saida_teste => dmem_saida_teste,
			rd_teste 	=> rd_teste,
			pc_teste 	=> pc_teste,
			pc4_teste	=> pc4_teste
		);
		
		controlador_0 : controlador PORT MAP (
			instrucao	=> instrucao_sinal,
			clock			=> clock,
			w_rd			=> w_rd_sinal,
			--enable_pc	=> enable_pc,
			BSel			=> BSel_sinal,
			MemRW			=> MemRW_sinal,
			WBSel			=> WBSel_sinal,
			ALUSel		=> ALUSel_sinal,
			sel_bhw		=> sel_bhw_sinal,
			sel_su		=> sel_su_sinal,
			ASel			=> ASel_sinal,
			BrUn			=> BrUn_sinal,
			imm_sel		=> imm_sel_sinal,
			PCSel			=> PCSel_sinal,
			BrEq			=> BrEq_sinal,
			BrLT			=> BrLT_sinal
		);
		
		instrucao_teste <= instrucao_sinal;
END comportamento;