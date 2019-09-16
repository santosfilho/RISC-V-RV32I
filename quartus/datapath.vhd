---------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
---------------------------------------------------------------------------------------------------------------------------------------
ENTITY datapath IS 
	PORT(
		clock			:	IN		STD_LOGIC;		
		reset			:	IN		STD_LOGIC;
		w_rd			:	IN		STD_LOGIC;
		r_rs1			:  IN		STD_LOGIC;
		r_rs2			:  IN		STD_LOGIC;
		enable_pc	:  IN		STD_LOGIC;
		load_pc		:  IN		STD_LOGIC;
		BSel			:	IN		STD_LOGIC;
		saida_teste :  OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
		saida_teste_sel_alu : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		saida_teste_instrucao : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END datapath;
---------------------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE comportamento OF datapath IS
	COMPONENT register_file IS
		PORT(
			clock	: 	IN		STD_LOGIC;
			-- Porta de escrita
			rd		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			add_rd:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
			w_rd	:	IN		STD_LOGIC;
			-- Porta de leiura
			rs1		:	OUT		STD_LOGIC_VECTOR(31 DOWNTO 0);
			add_rs1	:	IN			STD_LOGIC_VECTOR(4 DOWNTO 0);
			r_rs1		:  IN			STD_LOGIC;
		
			rs2		:	OUT		STD_LOGIC_VECTOR(31 DOWNTO 0);
			add_rs2	:	IN			STD_LOGIC_VECTOR(4 DOWNTO 0);
			r_rs2		:  IN			STD_LOGIC
		);		
	END COMPONENT;
	
	COMPONENT alu IS
		PORT( 
			in1_alu, in2_alu		: 	IN 		STD_LOGIC_VECTOR(31 DOWNTO 0);
			sel_alu					: 	IN 		STD_LOGIC_VECTOR(3 DOWNTO 0);
			out_alu					: 	OUT 		STD_LOGIC_VECTOR(31 DOWNTO 0)		
		);
	END COMPONENT;
	
	COMPONENT progam_memory IS
		PORT(
			address		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			clock			: IN STD_LOGIC  := '1';
			q				: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT pc IS
		PORT( 
			clock		: 	IN 	STD_LOGIC;
			reset_pc	: 	IN 	STD_LOGIC;
			enable_pc: 	IN 	STD_LOGIC;
			load_pc	: 	IN 	STD_LOGIC;
			--end8		: 	in 	STD_LOGIC_VECTOR(9 downto 0);
			pc_out	: 	out 	STD_LOGIC_VECTOR(11 downto 0) 
		);
	END COMPONENT;
	
	COMPONENT geradorImm IS
		PORT(
			in_ger		:	IN		STD_LOGIC_VECTOR(11 DOWNTO 0);
			out_ger		:	OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT mux IS
		PORT(
			in1_mux, in2_mux		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			sel_mux					:	IN		STD_LOGIC;
			out_mux					:	OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	SIGNAL rs1				:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL rs2				:	STD_LOGIC_VECTOR(31 DOWNTO 0);	
	SIGNAL out_alu			:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL instrucao		:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL pc_out			:  STD_LOGIC_VECTOR(11 DOWNTO 0);
	SIGNAL imm_ext			: 	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL out_mux			:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	
BEGIN 
	register_file1: 			register_file PORT MAP(
								   clock 	=>	clock,
									rd  		=>	out_alu,
									add_rd	=> instrucao(11 DOWNTO 7),
									w_rd	 	=>	w_rd,
									rs1	  	=>	rs1,
									add_rs1	=> instrucao(19 DOWNTO 15),
									r_rs1 	=>	r_rs1,
									rs2	  	=>	rs2,
									add_rs2	=> instrucao(24 DOWNTO 20),
									r_rs2		=>	r_rs2
									);
									
	alu1:							alu PORT MAP(
									in1_alu => rs1,
									in2_alu => out_mux,
									sel_alu => instrucao(30)&instrucao(14 DOWNTO 12),
									out_alu => out_alu
									);
									
	program_memory1:			progam_memory PORT MAP(
									address => pc_out(11 downto 2),
									clock	  => clock,
									q		  => instrucao
									);
	
	pc1:							pc	PORT MAP(
									clock 		=> clock,
									reset_pc 	=> reset,
									enable_pc 	=> enable_pc,
									load_pc		=> load_pc,
									pc_out		=> pc_out
									);
									
	geradorImm1:				geradorImm PORT MAP(
									in_ger		=>	instrucao(31 DOWNTO 20),
									out_ger		=> imm_ext
									);
	
	mux1:							mux PORT MAP(
									in1_mux		=> rs2,
									in2_mux		=> imm_ext,
									sel_mux		=> BSel,
									out_mux		=> out_mux
									);
	
	
	saida_teste <= out_alu;
	saida_teste_sel_alu <= instrucao(30)&instrucao(14 DOWNTO 12);
	saida_teste_instrucao <= instrucao;
END ARCHITECTURE;