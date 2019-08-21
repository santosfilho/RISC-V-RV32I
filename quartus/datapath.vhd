---------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
---------------------------------------------------------------------------------------------------------------------------------------
ENTITY datapath IS 
	PORT(
		clock_datapath		:	IN		STD_LOGIC;		
		pc_out				:	IN		STD_LOGIC_VECTOR(9 DOWNTO 0); -- memoria de instrucao
		w_rd_datapath		:	IN		STD_LOGIC;
		r_rs1_datapath		:  IN		STD_LOGIC;
		r_rs2_datapath		:  IN		STD_LOGIC
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
	
	
	
	
	SIGNAL rs1_alu			:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL rs2_alu			:	STD_LOGIC_VECTOR(31 DOWNTO 0);	
	SIGNAL saida_alu		:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL instrucao		:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	
	
BEGIN 
	banco_de_registradores: register_file PORT MAP(
								   clock 	=>	clock_datapath,
									rd  		=>	saida_alu,
									add_rd	=> instrucao(11 DOWNTO 7),
									w_rd	 	=>	w_rd_datapath,
									rs1	  	=>	rs1_alu,
									add_rs1	=> instrucao(19 DOWNTO 15),
									r_rs1 	=>	r_rs1_datapath,
									rs2	  	=>	rs2_alu,
									add_rs2	=> instrucao(24 DOWNTO 20),
									r_rs2		=>	r_rs2_datapath
									);
									
	ula:							alu PORT MAP(
									in1_alu => rs1_alu,
									in2_alu => rs2_alu,
									sel_alu => instrucao(30)&instrucao(14 DOWNTO 12),
									out_alu => saida_alu
									);
									
	memoria_de_programa:		progam_memory PORT MAP(
									address => pc_out,
									clock	  => clock_datapath,
									q		  => instrucao
									);
	
END ARCHITECTURE;