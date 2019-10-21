---------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
---------------------------------------------------------------------------------------------------------------------------------------
ENTITY datapath IS 
	PORT(
		clock			:	IN		STD_LOGIC;		
		reset			:	IN		STD_LOGIC;
		w_rd			:	IN		STD_LOGIC;		
		enable_pc	:  IN		STD_LOGIC;
		--load_pc		:  IN		STD_LOGIC;
		BSel			:	IN		STD_LOGIC;
		MemRW			: 	IN		STD_LOGIC;
		WBSel			: 	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
		ALUSel		:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
		sel_bhw		: 	IN		STD_LOGIC_VECTOR(2 DOWNTO 0);
		sel_su		:  IN 	STD_LOGIC_VECTOR(1 DOWNTO 0); -- necessario para LB, LH, LBU, LHU			
		ASel			: 	IN		STD_LOGIC;
		BrUn			: 	IN		STD_LOGIC;
		imm_sel		:	IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
		PCSel			: 	IN		STD_LOGIC;
		BrEq			:	OUT	STD_LOGIC;
		BrLT			:	OUT	STD_LOGIC;
		--saida_teste :  OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
		--saida_teste_sel_alu : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		--saida_teste_instrucao : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		alu_teste	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		aluA			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);	
		aluB			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		instrucao_teste 	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		dmem_saida_teste  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		rd_teste  	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		pc_teste  	: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
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
		
			rs2		:	OUT		STD_LOGIC_VECTOR(31 DOWNTO 0);
			add_rs2	:	IN			STD_LOGIC_VECTOR(4 DOWNTO 0)			
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
	
	COMPONENT mux_pc_in IS
		PORT(
			in1_mux, in2_mux		:	IN		STD_LOGIC_VECTOR(11 DOWNTO 0);
			sel_mux					:	IN		STD_LOGIC;
			out_mux					:	OUT 	STD_LOGIC_VECTOR(11 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT pc IS
		PORT( 
			clock		: 	IN 	STD_LOGIC;
			reset_pc	: 	IN 	STD_LOGIC;
			enable_pc: 	IN 	STD_LOGIC;
			--load_pc	: 	IN 	STD_LOGIC;
			end8		: 	in 	STD_LOGIC_VECTOR(11 downto 0);
			pc_out	: 	out 	STD_LOGIC_VECTOR(11 downto 0) 
		);
	END COMPONENT;
	
	COMPONENT somador IS
		PORT( 
			end8		   : 	in 	STD_LOGIC_VECTOR(11 downto 0);
			somador_out	: 	out 	STD_LOGIC_VECTOR(11 downto 0)
		);
	END COMPONENT;
	
	COMPONENT geradorImm IS
		PORT(
			in_ger		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			imm_sel		:	IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
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
	
	COMPONENT extensor_bhw IS
		PORT(
			data_bhw_in			:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			sel_bhw				:	IN		STD_LOGIC_VECTOR(2 DOWNTO 0);
			ext_data_bhw		:	OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT dmem IS 
		PORT(
			clock 	:  IN 	STD_LOGIC;
			addr		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			data_w	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);			
			sel_bhw  :  IN    STD_LOGIC_VECTOR(2 DOWNTO 0);
			mem_rw	:	IN		STD_LOGIC;
			data_r	:	OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0);
			sel_su	:  IN 	STD_LOGIC_VECTOR(1 DOWNTO 0) -- necessario para LB, LH, LBU, LHU			
		);
	END COMPONENT;
	
	COMPONENT BranchComp IS
	PORT(
		A			:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		B			:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		BrUn		:	IN		STD_LOGIC;
		BrEq		:	OUT	STD_LOGIC;
		BrLT		:	OUT	STD_LOGIC
	);
	END COMPONENT;
	
	COMPONENT mux4 IS
	PORT(
		in0_mux, in1_mux, in2_mux, in3_mux		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		sel_mux											:	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
		out_mux											:	OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;
	
	SIGNAL rs1				:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL rs2				:	STD_LOGIC_VECTOR(31 DOWNTO 0);	
	SIGNAL out_alu			:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL instrucao		:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL pc_out			:  STD_LOGIC_VECTOR(11 DOWNTO 0);
	SIGNAL imm_ext			: 	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL out_mux			:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL ext_data_bhw	:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_dmem			:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL wb				:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL mux_pc_out_out:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL somador_out   :  STD_LOGIC_VECTOR(11 DOWNTO 0);
	SIGNAL out_mux_pc_sel:  STD_LOGIC_VECTOR(11 DOWNTO 0);
	
			
BEGIN 
	register_file1: 			register_file PORT MAP(
								   clock 	=>	clock,
									rd  		=>	wb,
									add_rd	=> instrucao(11 DOWNTO 7),
									w_rd	 	=>	w_rd,
									rs1	  	=>	rs1,
									add_rs1	=> instrucao(19 DOWNTO 15),									
									rs2	  	=>	rs2,
									add_rs2	=> instrucao(24 DOWNTO 20)									
									);
									
	alu1:							alu PORT MAP(
									in1_alu => mux_pc_out_out,
									in2_alu => out_mux,
									sel_alu => ALUSel,--instrucao(30)&instrucao(14 DOWNTO 12),
									out_alu => out_alu
									);
									
	program_memory1:			progam_memory PORT MAP(
									address => pc_out(11 downto 2),
									clock	  => clock,
									q		  => instrucao
									);
									
	mux_pc_in1:					mux_pc_in PORT MAP(
									in1_mux		=> somador_out,
									in2_mux		=> out_alu(11 DOWNTO 0),
									sel_mux		=> PCSel,
									out_mux		=> out_mux_pc_sel
									);
									
	
	pc1:							pc	PORT MAP(
									clock 		=> clock,
									reset_pc 	=> reset,
									enable_pc 	=> enable_pc,
									--load_pc		=> load_pc,
									end8			=> out_mux_pc_sel,
									pc_out		=> pc_out
									);
									
	somador4:					somador PORT MAP (
									end8			=> pc_out,
									somador_out => somador_out
									);
	
	geradorImm1:				geradorImm PORT MAP(
									in_ger		=>	instrucao(31 DOWNTO 0),
									imm_sel		=> imm_sel,
									out_ger		=> imm_ext
									);
	
	mux_alu_B:					mux PORT MAP(
									in1_mux		=> rs2,
									in2_mux		=> imm_ext,
									sel_mux		=> BSel,
									out_mux		=> out_mux
									);
			
	dmem1:						dmem PORT MAP(
									clock 	=> clock,
									addr		=> out_alu,
									data_w	=> rs2,
									sel_bhw  => sel_bhw,
									mem_rw	=> MemRW,
									data_r	=> q_dmem,
									sel_su	=> sel_su									
									);
											
	mux_dmem:					mux4 PORT MAP(
									in0_mux		=> q_dmem,
									in1_mux		=> out_alu,
									in2_mux		=> "00000000000000000000"&somador_out, -- PC+4
									in3_mux		=> instrucao(31 DOWNTO 12)&"000000000000", -- LUI
									sel_mux		=> WBSel,
									out_mux		=> wb
									);
	
	mux_alu_A:					mux PORT MAP(
									in1_mux		=> rs1,
									in2_mux		=> "0000000000000000000000"& pc_out(11 downto 2),
									sel_mux		=> ASel,
									out_mux		=> mux_pc_out_out
									);

	BranchComp1:				BranchComp PORT MAP(
									A		=>	rs1,
									B		=>	rs2,
									BrUn	=>	BrUn,
									BrEq	=> BrEq,
									BrLT	=> BrLT
									);
									
	

	
	--saida_teste_sel_alu <= instrucao(30)&instrucao(14 DOWNTO 12);
	--saida_teste_instrucao <= instrucao;
	dmem_saida_teste <= q_dmem;
	rd_teste <= wb;
	pc_teste <= pc_out(11 downto 2);
	alu_teste <= out_alu;
	aluA <= mux_pc_out_out;
	aluB <= out_mux;
	instrucao_teste <= instrucao;
END ARCHITECTURE;