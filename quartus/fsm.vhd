---------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------
ENTITY fsm IS
	PORT(
			exect_inst			:  IN    STD_LOGIC;
			clock 				:	IN 	STD_LOGIC;			
			reset 				:	IN 	STD_LOGIC;			
			IR_out				:  IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
			inst_exect			:	OUT	STD_LOGIC;			
			IR_ld, IR_clr		:	OUT	STD_LOGIC;	-- sinais de controle do registrador IR.			
			R0_ld, R0_clr		:	OUT	STD_LOGIC;	-- sinais de controle do registrador R0.
			R1_ld, R1_clr		:	OUT	STD_LOGIC;	-- sinais de controle do registrador R1.
			R2_ld, R2_clr		:	OUT	STD_LOGIC;	-- sinais de controle do registrador R2.
			R3_ld, R3_clr		:	OUT	STD_LOGIC;	-- sinais de controle do registrador R3.			
			Rout_ld,Rout_clr	:	OUT	STD_LOGIC;	-- sinais de controle do registrador Rout.
			Raux_ld,Raux_clr	:	OUT	STD_LOGIC;	-- sinais de controle do registrador Raux.
			sel0, ALU_sel		:  OUT	STD_LOGIC_VECTOR(2 DOWNTO 0);
		   sel1, sel2			:  OUT	STD_LOGIC_VECTOR(1 DOWNTO 0);
			--------------------------- PARTE 2 ------------------------------------------------
			pc_rst								:  out 	std_logic;
			pc_cnt								:	out	std_logic;
			pc_ld									:	out	std_logic;
			data_memory_wren					:  out	std_logic;
			flag_jz								: 	in		std_logic;
			r_status_clr, r_status_ld		:	out	std_logic;
			rin_ld								: 	out   std_logic;
			rin_clr								: 	out   std_logic
	);
END fsm;
--------------------------------------------
ARCHITECTURE comportamento OF fsm IS
	
	TYPE estado IS (INICIO, BUSCAR, DECODIFICAR, ADD, SUB, E, OU, NAO, NOP, MOV, MVI, ENTRADA, SAIDA, LD, ST, JMP, JZ, DEC, FIM);
	SIGNAL estado_atual: estado;
	
	
BEGIN
	maquina : PROCESS(clock, reset)-- CAMINHO DE CADA ESTADO--
	BEGIN
		IF( NOT reset = '1') THEN -- pushbutton solto vale '1'
			estado_atual <= INICIO;
		ELSIF(clock'EVENT AND clock = '1') THEN
			CASE estado_atual IS
				WHEN INICIO =>
					estado_atual <= BUSCAR;
				WHEN BUSCAR =>
					if(exect_inst = '1') THEN
					estado_atual <= DECODIFICAR;
					ELSE
					estado_atual <= BUSCAR;
					END IF;
				WHEN DECODIFICAR =>
					CASE IR_out(7 downto 4) IS
						WHEN "0000" =>
							estado_atual <= ADD;
						WHEN "0001" =>
							estado_atual <= SUB;
						WHEN "0010" =>
							estado_atual <= E;
						WHEN "0011" =>
							estado_atual <= OU;
						WHEN "0100" =>
							estado_atual <= NAO;
						WHEN "0101" =>
							estado_atual <= NOP;
						WHEN "0110" =>
							estado_atual <= MOV;
						WHEN "0111" =>
							estado_atual <= MVI;
						WHEN "1000" =>
							estado_atual <= ENTRADA;
						WHEN "1001" =>
							estado_atual <= SAIDA;
						WHEN "1010" =>
							estado_atual <= LD;
						WHEN "1011" =>
							estado_atual <= ST;
						WHEN "1100" =>
							estado_atual <= JMP;
						WHEN "1101" =>
							estado_atual <= JZ;
						WHEN "1110" =>
							estado_atual <= DEC;
						WHEN "1111" =>
							estado_atual <= FIM;							
						END CASE;
			WHEN ADD =>
					estado_atual <= BUSCAR;
			WHEN SUB =>
					estado_atual <= BUSCAR;
			WHEN E =>
					estado_atual <= BUSCAR;
			WHEN OU =>
					estado_atual <= BUSCAR;
			WHEN NAO =>
					estado_atual <= BUSCAR;
			WHEN NOP =>
					estado_atual <= BUSCAR;
			WHEN MOV =>
					estado_atual <= BUSCAR;
			WHEN MVI =>
					estado_atual <= BUSCAR;
			WHEN ENTRADA =>
					estado_atual <= BUSCAR;
			WHEN SAIDA =>
					estado_atual <= BUSCAR;
			WHEN LD =>
					estado_atual <= BUSCAR;
			WHEN ST =>
					estado_atual <= BUSCAR;
			WHEN JMP =>
					estado_atual <= NOP;
			WHEN JZ =>
					estado_atual <= NOP;
			WHEN DEC =>
					estado_atual <= BUSCAR;
			WHEN FIM =>
					estado_atual <= FIM;
			END CASE;
		END IF;
	END PROCESS;
	
	sinais_ativos : PROCESS(estado_atual, IR_out, flag_jz)-- PROCESSO DE CADA ESTADO--
	BEGIN
		CASE estado_atual IS
			WHEN INICIO =>				
				IR_ld		<= '0';
				IR_clr	<= '1';				
				R0_ld		<= '0';
				R0_clr	<= '1';
				R1_ld		<= '0';
				R1_clr	<= '1';	
				R2_ld		<= '0';
				R2_clr	<= '1';	
				R3_ld		<= '0';
				R3_clr	<= '1';				
				Rout_ld	<= '0';
				Rout_clr	<= '1';
				Raux_ld	<= '0';
				Raux_clr	<= '1';
				sel0		<= "000";
				ALU_sel	<= "000";
				sel1 		<= "00";
				sel2 		<= "00";
				inst_exect <= '0';
				-------- PARTE 2 ---------
				pc_rst   <= '1';
				pc_cnt	<=	'0';		
				pc_ld		<=	'0';		
				data_memory_wren	<= '0';
				r_status_clr <= '1';
				r_status_ld  <= '0';
				rin_ld		 <= '0'; 
				rin_clr		 <= '1';
				
			WHEN BUSCAR =>				
				IR_ld		<= '1';
				IR_clr	<= '0';				
				R0_ld		<= '0';
				R0_clr	<= '0';
				R1_ld		<= '0';
				R1_clr	<= '0';	
				R2_ld		<= '0';
				R2_clr	<= '0';	
				R3_ld		<= '0';
				R3_clr	<= '0';				
				Rout_ld	<= '0';
				Rout_clr	<= '0';
				Raux_ld	<= '1';
				Raux_clr	<= '0';
				sel0		<= "000";
				ALU_sel	<= "000";
				sel1 		<= "00";
				sel2 		<= "00";
				inst_exect <= '0';
				------- PARTE 2 ---------
				pc_rst   <= '0';
				pc_cnt	<=	'1';		
				pc_ld		<=	'0';		
				data_memory_wren	<= '0';
				r_status_clr <= '0';
				r_status_ld  <= '0';
				rin_ld		 <= '0'; 
				rin_clr		 <= '0';	
				
			WHEN DECODIFICAR =>				
				IR_ld		<= '0';
				IR_clr	<= '0';			
				R0_ld		<= '0';
				R0_clr	<= '0';
				R1_ld		<= '0';
				R1_clr	<= '0';	
				R2_ld		<= '0';
				R2_clr	<= '0';	
				R3_ld		<= '0';
				R3_clr	<= '0';					
				Rout_ld	<= '0';
				Rout_clr	<= '0';
				Raux_ld	<= '0'; -- sempre carrego o valor de raux, para no mvi so precisar carregar o valor no registrador 
				Raux_clr	<= '0';
				sel0		<= "000";
				ALU_sel	<= "000";
				sel1 		<= "00";
				sel2 		<= "00";
				inst_exect <= '0';
				------- PARTE 2 ---------
				pc_rst   <= '0';
				pc_cnt	<=	'0';		
				pc_ld		<=	'0';		
				data_memory_wren	<= '0';
				r_status_clr <= '0';
				r_status_ld  <= '0';
				rin_ld		 <= '0'; 
				rin_clr		 <= '0';		
								
			WHEN ADD => 
				CASE IR_out(1 downto 0) IS
					WHEN "00" =>																		
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '1';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "000";
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';	
									r_status_clr <= '0';
									r_status_ld  <= '1';	
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';
									
					WHEN "01" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '1';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "000";
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';	
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';	
					
					WHEN "10" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '1';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "000";
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';		
					
					WHEN "11" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '1';
									R3_clr	<= '0';								
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "000";
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';		
				END CASE;
			WHEN SUB =>
				CASE IR_out(1 downto 0) IS
					WHEN "00" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';								
									R0_ld		<= '1';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "001";
									sel1 		<= IR_out(1 DOWNTO 0);
									sel2 		<= IR_out(3 DOWNTO 2);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';		
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';
									
					WHEN "01"=>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '1';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "001";
									sel1 		<= IR_out(1 DOWNTO 0);
									sel2 		<= IR_out(3 DOWNTO 2);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';		
					
					WHEN "10"=>
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '1';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "001";
									sel1 		<= IR_out(1 DOWNTO 0);
									sel2 		<= IR_out(3 DOWNTO 2);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';		
					
					WHEN "11"=>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '1';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "001";
									sel1 		<= IR_out(1 DOWNTO 0);
									sel2 		<= IR_out(3 DOWNTO 2);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';		
				END CASE;			
			WHEN E =>
				CASE IR_out(1 downto 0) IS
					WHEN "00" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '1';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "010";
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';	
									
					WHEN "01"=>									
									IR_ld		<= '0';
									IR_clr	<= '0';								
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '1';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "010";
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';		
					
					WHEN "10"=>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '1';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "010";
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';		
					
					WHEN "11"=>
									IR_ld		<= '0';
									IR_clr	<= '0';								
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '1';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "010";
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';		
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';
									
				END CASE;
			WHEN OU =>
				CASE IR_out(1 downto 0) IS
					WHEN "00" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '1';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "011";
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';		
									
					WHEN "01"=>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '1';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "011";
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';		
					
					WHEN "10"=>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '1';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "011";
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';		
					
					WHEN "11"=>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '1';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "011";
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';				
									r_status_clr <= '0';
									r_status_ld  <= '1';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';		
				END CASE;
			WHEN NAO => 
				CASE IR_out(1 downto 0) IS
					WHEN "00" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '1';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "100";
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';		
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';
									
					WHEN "01" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '1';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "100";
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';		
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';
									
					WHEN "10" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '1';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "100";
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';		
					
					WHEN "11" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '1';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "100";
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr <= '0';
									r_status_ld  <= '1';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';		
				END CASE;
				
			WHEN NOP =>				
				IR_ld		<= '0';
				IR_clr	<= '0';				
				R0_ld		<= '0';
				R0_clr	<= '0';
				R1_ld		<= '0';
				R1_clr	<= '0';	
				R2_ld		<= '0';
				R2_clr	<= '0';	
				R3_ld		<= '0';
				R3_clr	<= '0';				
				Rout_ld	<= '0';
				Rout_clr	<= '0';
				Raux_ld	<= '0';
				Raux_clr	<= '0';
				sel0		<= "000";
				ALU_sel	<= "101";
				sel1 		<= IR_out(3 DOWNTO 2);
				sel2 		<= IR_out(1 DOWNTO 0);
				inst_exect <= '1';
				------- PARTE 2 ---------
				pc_rst   <= '0';
				pc_cnt	<=	'0';		
				pc_ld		<=	'0';		
				data_memory_wren	<= '0';
				rin_ld		 		<= '0'; 
				rin_clr		 		<= '0';
				r_status_clr		<= '0'; 
				r_status_ld			<= '0';
				
			WHEN MOV =>
				CASE IR_out(1 downto 0) IS
					WHEN "00" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '1';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "000";
									ALU_sel	<= "000"; -- tanto faz, esta operacao nao e feita na alu
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '0';
					
					WHEN "01" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '1';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "000";
									ALU_sel	<= "000"; -- tanto faz, esta operacao nao e feita na alu
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '0';
					
					WHEN "10" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '1';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "000";
									ALU_sel	<= "100"; -- tanto faz, esta operacao nao e feita na alu
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '0';
					
					WHEN "11" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '1';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "000";
									ALU_sel	<= "100"; -- tanto faz, esta operacao nao e feita na alu
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '0';
				END CASE;
			
			WHEN MVI =>
				CASE IR_out(1 downto 0) IS
					WHEN "00" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '1';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "010";
									ALU_sel	<= "000"; -- tanto faz, esta operacao nao e feita na alu
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '0';
									
					WHEN "01" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '1';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "010";
									ALU_sel	<= "000"; -- tanto faz, esta operacao nao e feita na alu
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '0';
									
					WHEN "10" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '1';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "010";
									ALU_sel	<= "100"; -- tanto faz, esta operacao nao e feita na alu
									sel1 		<= IR_out(3 DOWNTO 2);
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '0';
									
					WHEN "11" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '1';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "010";
									ALU_sel	<= "100"; -- tanto faz, esta operacao nao e feita na alu
									sel1 		<= IR_out(3 DOWNTO 2); 
									sel2 		<= IR_out(1 DOWNTO 0);
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									rin_ld		 <= '0'; 
									rin_clr		 <= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '0';
				END CASE;
				
			WHEN ENTRADA =>
				CASE IR_out(1 downto 0) IS
					WHEN "00" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '1';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "001";
									ALU_sel	<= "000"; -- tanto faz, esta operacao nao e feita na alu
									sel1 		<= IR_out(3 DOWNTO 2); -- tanto faz
									sel2 		<= IR_out(1 DOWNTO 0); -- tanto faz
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									rin_ld		 <= '1'; 
									rin_clr		 <= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '0';
									
					WHEN "01" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '1';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "001";
									ALU_sel	<= "000"; -- tanto faz, esta operacao nao e feita na alu
									sel1 		<= IR_out(3 DOWNTO 2); -- tanto faz
									sel2 		<= IR_out(1 DOWNTO 0); -- tanto faz
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									rin_ld		 <= '1'; 
									rin_clr		 <= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '0';
					
					WHEN "10" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '1';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';								
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "001";
									ALU_sel	<= "100"; -- tanto faz, esta operacao nao e feita na alu
									sel1 		<= IR_out(3 DOWNTO 2); -- tanto faz
									sel2 		<= IR_out(1 DOWNTO 0); -- tanto faz
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									rin_ld		 <= '1'; 
									rin_clr		 <= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '0';
									
					WHEN "11" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '1';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "001";
									ALU_sel	<= "100"; -- tanto faz, esta operacao nao e feita na alu
									sel1 		<= IR_out(3 DOWNTO 2); -- tanto faz
									sel2 		<= IR_out(1 DOWNTO 0); -- tanto faz
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									rin_ld		 <= '1'; 
									rin_clr		 <= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '0';
				END CASE;
				
			WHEN SAIDA =>			
				IR_ld		<= '0';
				IR_clr	<= '0';									
				R0_ld		<= '0';
				R0_clr	<= '0';
				R1_ld		<= '0';
				R1_clr	<= '0';	
				R2_ld		<= '0';
				R2_clr	<= '0';	
				R3_ld		<= '0';
				R3_clr	<= '0';				
				Rout_ld	<= '1';
				Rout_clr	<= '0';
				Raux_ld	<= '0';
				Raux_clr	<= '0';
				sel0		<= "001"; -- tanto faz
				ALU_sel	<= "000"; -- tanto faz, esta operacao nao e feita na alu
				sel1 		<= IR_out(1 DOWNTO 0);
				sel2 		<= IR_out(1 DOWNTO 0); -- tanto faz					
				inst_exect <= '1';
				------------- PARTE 2 ------------------------------
				pc_rst				<= '0';				
				pc_cnt				<=	'0';			
				pc_ld					<=	'0';			
				data_memory_wren	<=	'0';							
				r_status_clr		<= '0'; 
				r_status_ld			<= '0';
				rin_ld		 		<= '0'; 
				rin_clr		 		<= '0';
			
			WHEN LD =>				
				CASE IR_out(1 downto 0) IS
					WHEN "00" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '1';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "100";
									ALU_sel	<= "000"; -- tanto faz, esta operacao nao e feita na alu
									sel1 		<= IR_out(3 DOWNTO 2); 
									sel2 		<= IR_out(1 DOWNTO 0); -- tanto faz
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '0';
									rin_ld		 		<= '0'; 
									rin_clr		 		<= '0';
									
					WHEN "01" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '1';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "100";
									ALU_sel	<= "000"; -- tanto faz, esta operacao nao e feita na alu
									sel1 		<= IR_out(3 DOWNTO 2); 
									sel2 		<= IR_out(1 DOWNTO 0); -- tanto faz
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '0';
									rin_ld		 		<= '0'; 
									rin_clr		 		<= '0';
					
					WHEN "10" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '1';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '1';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "100";
									ALU_sel	<= "000"; -- tanto faz, esta operacao nao e feita na alu
									sel1 		<= IR_out(3 DOWNTO 2); 
									sel2 		<= IR_out(1 DOWNTO 0); -- tanto faz
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '0';
									rin_ld		 		<= '0'; 
									rin_clr		 		<= '0';
									
					WHEN "11" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '1';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "100";
									ALU_sel	<= "000"; -- tanto faz, esta operacao nao e feita na alu
									sel1 		<= IR_out(3 DOWNTO 2); 
									sel2 		<= IR_out(1 DOWNTO 0); -- tanto faz
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '0';
									rin_ld		 		<= '0'; 
									rin_clr		 		<= '0';
				END CASE;
				
			WHEN ST =>											
				IR_ld		<= '0';
				IR_clr	<= '0';									
				R0_ld		<= '0';
				R0_clr	<= '0';
				R1_ld		<= '0';
				R1_clr	<= '0';	
				R2_ld		<= '0';
				R2_clr	<= '0';	
				R3_ld		<= '0';
				R3_clr	<= '0';									
				Rout_ld	<= '0';
				Rout_clr	<= '0';
				Raux_ld	<= '0';
				Raux_clr	<= '0';
				sel0		<= "101"; -- tanto faz
				ALU_sel	<= "000"; -- tanto faz, esta operacao nao e feita na alu
				sel1 		<= IR_out(1 DOWNTO 0); 
				sel2 		<= IR_out(3 DOWNTO 2); 
				inst_exect <= '1';
				------- PARTE 2 ---------
				pc_rst   <= '0';
				pc_cnt	<=	'0';		
				pc_ld		<=	'0';		
				data_memory_wren	<= '1';
				r_status_clr		<= '0'; 
				r_status_ld			<= '0';
				rin_ld		 		<= '0'; 
				rin_clr		 		<= '0';				
				
			WHEN JMP =>				
				IR_ld		<= '0';
				IR_clr	<= '0';				
				R0_ld		<= '0';
				R0_clr	<= '0';
				R1_ld		<= '0';
				R1_clr	<= '0';	
				R2_ld		<= '0';
				R2_clr	<= '0';	
				R3_ld		<= '0';
				R3_clr	<= '0';				
				Rout_ld	<= '0';
				Rout_clr	<= '0';
				Raux_ld	<= '0';
				Raux_clr	<= '0';
				sel0		<= "000";
				ALU_sel	<= "000";
				sel1 		<= IR_out(3 DOWNTO 2);
				sel2 		<= IR_out(1 DOWNTO 0);
				inst_exect <= '1';
				------- PARTE 2 ---------
				pc_rst   <= '0';
				pc_cnt	<=	'0';		
				pc_ld		<=	'1';		
				data_memory_wren	<= '0';
				r_status_clr		<= '0'; 
				r_status_ld			<= '0';
				rin_ld		 		<= '0'; 
				rin_clr		 		<= '0';		
				
			WHEN JZ =>				
				IR_ld		<= '0';
				IR_clr	<= '0';				
				R0_ld		<= '0';
				R0_clr	<= '0';
				R1_ld		<= '0';
				R1_clr	<= '0';	
				R2_ld		<= '0';
				R2_clr	<= '0';	
				R3_ld		<= '0';
				R3_clr	<= '0';				
				Rout_ld	<= '0';
				Rout_clr	<= '0';
				Raux_ld	<= '0';
				Raux_clr	<= '0';
				sel0		<= "000";
				ALU_sel	<= "000";
				sel1 		<= IR_out(3 DOWNTO 2);
				sel2 		<= IR_out(1 DOWNTO 0);				
				------- PARTE 2 ---------
				pc_rst   <= '0';
				pc_cnt	<=	'0';		
				data_memory_wren	<= '0';
				if (flag_jz = '1') then
					pc_ld <= '1';
					inst_exect <= '1';
				else
					pc_ld <= '0';
					inst_exect <= '0';
				end if;
				r_status_clr		<= '0'; 
				r_status_ld			<= '0';
				rin_ld		 		<= '0'; 
				rin_clr		 		<= '0';
			
			WHEN DEC =>				
				CASE IR_out(1 downto 0) IS
					WHEN "00" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '1';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "110"; 
									sel1 		<= IR_out(1 DOWNTO 0); 
									sel2 		<= IR_out(1 DOWNTO 0); -- tanto faz
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '1';
									rin_ld		 		<= '0'; 
									rin_clr		 		<= '0';
									
					WHEN "01" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '1';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "110"; 
									sel1 		<= IR_out(1 DOWNTO 0); 
									sel2 		<= IR_out(1 DOWNTO 0); -- tanto faz
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '1';
									rin_ld		 		<= '0'; 
									rin_clr		 		<= '0';
					
					WHEN "10" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '1';
									R2_clr	<= '0';	
									R3_ld		<= '0';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "110"; 
									sel1 		<= IR_out(1 DOWNTO 0); 									
									sel2 		<= IR_out(1 DOWNTO 0); -- tanto faz
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '1';
									rin_ld		 		<= '0'; 
									rin_clr		 		<= '0';
									
					WHEN "11" =>									
									IR_ld		<= '0';
									IR_clr	<= '0';									
									R0_ld		<= '0';
									R0_clr	<= '0';
									R1_ld		<= '0';
									R1_clr	<= '0';	
									R2_ld		<= '0';
									R2_clr	<= '0';	
									R3_ld		<= '1';
									R3_clr	<= '0';									
									Rout_ld	<= '0';
									Rout_clr	<= '0';
									Raux_ld	<= '0';
									Raux_clr	<= '0';
									sel0		<= "011";
									ALU_sel	<= "110"; 
									sel1 		<= IR_out(1 DOWNTO 0); 
									sel2 		<= IR_out(1 DOWNTO 0); -- tanto faz
									inst_exect <= '1';
									------- PARTE 2 ---------
									pc_rst   <= '0';
									pc_cnt	<=	'0';		
									pc_ld		<=	'0';		
									data_memory_wren	<= '0';
									r_status_clr		<= '0'; 
									r_status_ld			<= '1';
									rin_ld		 		<= '0'; 
									rin_clr		 		<= '0';
				END CASE;
				
			WHEN FIM =>				
				IR_ld		<= '0';
				IR_clr	<= '0';				
				R0_ld		<= '0';
				R0_clr	<= '0';
				R1_ld		<= '0';
				R1_clr	<= '0';	
				R2_ld		<= '0';
				R2_clr	<= '0';	
				R3_ld		<= '0';
				R3_clr	<= '0';				
				Rout_ld	<= '0';
				Rout_clr	<= '0';
				Raux_ld	<= '0';
				Raux_clr	<= '0';
				sel0		<= "011";
				ALU_sel	<= "110";
				sel1 		<= IR_out(3 DOWNTO 2);
				sel2 		<= IR_out(1 DOWNTO 0);
				inst_exect <= '1';
				------- PARTE 2 ---------
				pc_rst   <= '0';
				pc_cnt	<=	'0';		
				pc_ld		<=	'0';		
				data_memory_wren	<= '0';
				r_status_clr		<= '0'; 
				r_status_ld			<= '0';
				rin_ld		 		<= '0'; 
				rin_clr		 		<= '0';
				
																																																											
		END CASE;
	END PROCESS;
END comportamento;