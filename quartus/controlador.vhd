LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY controlador IS
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
		sel_su		: 	OUT 	STD_LOGIC_VECTOR(1 DOWNTO 0); --Necessario para LB, LH, LBU, LHU			
		ASel			: 	OUT	STD_LOGIC;
		BrUn			: 	OUT	STD_LOGIC;
		imm_sel		:	OUT 	STD_LOGIC_VECTOR(2 DOWNTO 0);
		PCSel			: 	OUT	STD_LOGIC;
		BrEq			:	IN		STD_LOGIC;
		BrLT			:	IN		STD_LOGIC
	);
END controlador;

ARCHITECTURE comportamento OF controlador IS

	BEGIN
		PROCESS(instrucao, clock, BrEq, BrLT)
		BEGIN
		--aritimetica--
			CASE instrucao(6 DOWNTO 0) IS
				WHEN "0110011" => -- tipo R
						w_rd <= '1';
						ASel <= '0';
						BSel <= '0';
						MemRW	<= '-';
						WBSel	<= "01";		
						sel_bhw <= "---";
						sel_su <= "--";
						BrUn <= '-';
						imm_sel <= "---";
						PCSel <= '0';
					CASE instrucao(14 DOWNTO 12) IS
						WHEN "000" =>
							IF instrucao(30) = '0' THEN 	-- ADD
								ALUSel <= "0000";
							ELSE 									-- SUB
								ALUSel <= "1000";
							END IF;
						
						WHEN "001" =>  						-- SLL
							
							ALUSel <= "0001";
							--enable_pc <= '1';
						
						WHEN "010" =>  						-- SLT
							
							ALUSel <= "0010";
							--enable_pc <= '1';
						
						WHEN "011" =>  						-- SLTU
							
							ALUSel <= "0011";
							--enable_pc <= '1';
						
						WHEN "100" =>  						-- XOR
							
							ALUSel <= "0100";
							--enable_pc <= '1';
						
						WHEN "101" =>  						-- SRL e SRA
							
							--enable_pc <= '1';
							IF instrucao(30) = '0' THEN 	-- SRL
								ALUSel <= "0101";
							ELSE 									-- SRA
								ALUSel <= "1101";
							END IF;
							
						WHEN "110" =>  						-- OR
							
							ALUSel <= "0110";
							--enable_pc <= '1';
							
						WHEN "111" =>  						-- AND
							
							ALUSel <= "0111";
							--enable_pc <= '1';
						WHEN OTHERS => NULL;
					END CASE;
					
				WHEN "0010011" => -- Tipo I
						w_rd <= '1';
						ASel <= '0';
						BSel <= '1';
						WBSel	<= "01";
						
						-- Para instruçoes de memoria
						MemRW	<= '-';
						sel_bhw <= "---";
						sel_su <= "--";
						
						BrUn <= '-';
						imm_sel <= "000";
						PCSel <= '0';
						
					CASE instrucao(14 DOWNTO 12) IS
						WHEN "000" => -- ADDI
							ALUSel <= "0000";
							
						WHEN "010" => -- SLTI
							ALUSel <= "0010";
							
						WHEN "011" => -- SLTIU
							ALUSel <= "0011";
							
						WHEN "100" => -- XORI
							ALUSel <= "0100";
							
						WHEN "110" => -- ORI
							ALUSel <= "0110";
							
						WHEN "111" => -- ANDI
							ALUSel <= "0111";
						
						WHEN "001" => -- SLLI
							ALUSel <= "0001";
							
						WHEN "101" => -- SRLI e SRAI
							IF instrucao(30) = '0' THEN 	-- SRLI
								ALUSel <= "0101";
							ELSE 									-- SRAI
								ALUSel <= "1101";
							END IF;
						WHEN OTHERS => NULL;
					END CASE;
				WHEN "0000011" => -- Tipo L
					w_rd <= '1';
					ASel <= '0';
					BSel <= '1';
					WBSel	<= "00";
					
					-- Para instruçoes de memoria
					MemRW	<= '0';
					sel_bhw <= "---";
					
					BrUn <= '-';
					imm_sel <= "000";
					PCSel <= '0';
					ALUSel <= "0000";
					
					CASE instrucao(14 DOWNTO 12) IS
						WHEN "000" => -- LB
							sel_su <= "00";
						
						WHEN "001" => -- LH
							sel_su <= "01";
						
						WHEN "010" => -- LW
							sel_su <= "10";
						
						WHEN "100" => -- LBU
							sel_su <= "10";
						
						WHEN "101" => -- LHU
							sel_su <= "10";
							
						WHEN OTHERS => NULL;
					END CASE;
					
				WHEN "0100011" => -- Tipo S
					w_rd <= '0';
					ASel <= '0';
					BSel <= '1';
					WBSel	<= "--";
					
					-- Para instruçoes de memoria
					MemRW	<= '1';
					sel_su <= "--";
					
					BrUn <= '-';
					imm_sel <= "100";
					PCSel <= '0';
					ALUSel <= "0000";
					
					CASE instrucao(14 DOWNTO 12) IS
						WHEN "000" => -- SB
							sel_bhw <= "000";
						WHEN "001" => -- SH
							sel_bhw <= "001";
						WHEN "010" => -- SB
							sel_bhw <= "010";
						WHEN OTHERS => NULL;
					END CASE;
				
				WHEN "1100011" => -- Tipo B
					w_rd <= '0';
					ASel <= '1';
					BSel <= '1';
					WBSel	<= "--";
					-- Para instruçoes de memoria
					MemRW	<= '0';
					sel_bhw <= "---";
					sel_su <= "--";
					imm_sel <= "001";
					ALUSel <= "0000";
					
					CASE instrucao(14 DOWNTO 12) IS
						WHEN "000" => -- BEQ							
							BrUn <= '0';
							PCSel <= BrEq;
						
						WHEN "001" => -- BNE
							BrUn <= '0';
							PCSel <= NOT (BrEq);
						
						WHEN "100" => -- BLT
							BrUn <= '0';
							PCSel <= BrLT;
							
						WHEN "101" => -- BGE
							BrUn <= '0';
							PCSel <= NOT (BrLT);
							
						WHEN "110" => -- BLTU
							BrUn <= '1';
							PCSel <= BrLT;
						WHEN "111" => -- BGEU
							BrUn <= '1';
							PCSel <= NOT (BrLT);
							
						WHEN OTHERS => NULL;
					END CASE;
					
				WHEN "1101111" => -- JAL
					w_rd <= '1';
					ASel <= '1';
					BSel <= '1';
					WBSel	<= "10";
					
					-- Para instruçoes de memoria
					MemRW	<= '0';
					sel_bhw <= "---";
					sel_su <= "--";
					
					imm_sel <= "010";
					ALUSel <= "0000";
					BrUn <= '-';
					PCSel <= '1';
					
				WHEN "1100111" => -- JALR
					w_rd <= '1';
					ASel <= '0';
					BSel <= '1';
					WBSel	<= "10";
					
					-- Para instruçoes de memoria
					MemRW	<= '0';
					sel_bhw <= "---";
					sel_su <= "--";
					
					imm_sel <= "000";
					ALUSel <= "0000";
					BrUn <= '-';
					PCSel <= '1';
				
				WHEN "0010111" => -- AUIPC
					w_rd <= '1';
					ASel <= '1';
					BSel <= '1';
					WBSel	<= "01";
					
					-- Para instruçoes de memoria
					MemRW	<= '0';
					sel_bhw <= "---";
					sel_su <= "--";
					
					imm_sel <= "011";
					ALUSel <= "0000";
					BrUn <= '-';
					PCSel <= '0';
					
				WHEN "0110111" => -- LUI
					w_rd <= '1';
					ASel <= '-';
					BSel <= '-';
					WBSel	<= "11";
					
					-- Para instruçoes de memoria
					MemRW	<= '0';
					sel_bhw <= "---";
					sel_su <= "--";
					
					imm_sel <= "011";
					ALUSel <= "----";
					BrUn <= '-';
					PCSel <= '0';
				
				WHEN OTHERS => NULL;
			END CASE;
		END PROCESS;
END comportamento;
