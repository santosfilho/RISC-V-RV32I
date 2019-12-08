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
		imm_sel		:	OUT 	STD_LOGIC_VECTOR(1 DOWNTO 0);
		PCSel			: 	OUT	STD_LOGIC;
		BrEq			:	IN		STD_LOGIC;
		BrLT			:	IN		STD_LOGIC
	);
END controlador;

ARCHITECTURE comportamento OF controlador IS

	BEGIN
		PROCESS(instrucao, clock)
		BEGIN
		--aritimetica--
			CASE instrucao(6 DOWNTO 0) IS
				WHEN "0110011" => -- tipo R
					CASE instrucao(14 DOWNTO 12) IS
						WHEN "000" =>
							w_rd <= '1';
							BSel <= '0';
							MemRW	<= '0';
							WBSel	<= "01";		
							sel_bhw <= "---";
							sel_su <= "--";
							ASel <= '0';
							BrUn <= '-';
							imm_sel <= "--";
							--enable_pc <= '1';
							PCSel <= '1';
							IF instrucao(30) = '0' THEN 	-- ADD
								ALUSel <= "0000";
							ELSE 									-- SUB
								ALUSel <= "1000";
							END IF;
						
						WHEN "001" =>  						-- SLL
							w_rd <= '1';
							ASel <= '0';
							BSel <= '0';
							MemRW	<= '-';
							WBSel	<= "01";		
							sel_bhw <= "---";
							sel_su <= "--";
							BrUn <= '-';
							imm_sel <= "--";
							PCSel <= '1';
							ALUSel <= "0001";
							--enable_pc <= '1';
						
						WHEN "010" =>  						-- SLT
							w_rd <= '1';
							ASel <= '0';
							BSel <= '0';
							MemRW	<= '-';
							WBSel	<= "01";		
							sel_bhw <= "---";
							sel_su <= "--";
							BrUn <= '-';
							imm_sel <= "--";
							PCSel <= '1';
							ALUSel <= "0010";
							--enable_pc <= '1';
						
						WHEN "011" =>  						-- SLTU
							w_rd <= '1';
							ASel <= '0';
							BSel <= '0';
							MemRW	<= '-';
							WBSel	<= "01";		
							sel_bhw <= "---";
							sel_su <= "--";
							BrUn <= '-';
							imm_sel <= "--";
							PCSel <= '1';
							ALUSel <= "0011";
							--enable_pc <= '1';
						
						WHEN "100" =>  						-- XOR
							w_rd <= '1';
							ASel <= '0';
							BSel <= '0';
							MemRW	<= '-';
							WBSel	<= "01";		
							sel_bhw <= "---";
							sel_su <= "--";
							BrUn <= '-';
							imm_sel <= "--";
							PCSel <= '1';
							ALUSel <= "0100";
							--enable_pc <= '1';
						
						WHEN "101" =>  						-- SRL e SRA
							w_rd <= '1';
							ASel <= '0';
							BSel <= '0';
							MemRW	<= '-';
							WBSel	<= "01";		
							sel_bhw <= "---";
							sel_su <= "--";
							BrUn <= '-';
							imm_sel <= "--";
							PCSel <= '1';
							--enable_pc <= '1';
							IF instrucao(30) = '0' THEN 	-- SRL
								ALUSel <= "0101";
							ELSE 									-- SRA
								ALUSel <= "1101";
							END IF;
							
						WHEN "110" =>  						-- OR
							w_rd <= '1';
							ASel <= '0';
							BSel <= '0';
							MemRW	<= '-';
							WBSel	<= "01";		
							sel_bhw <= "---";
							sel_su <= "--";
							BrUn <= '-';
							imm_sel <= "--";
							PCSel <= '1';
							ALUSel <= "0110";
							--enable_pc <= '1';
							
						WHEN "111" =>  						-- AND
							w_rd <= '1';
							ASel <= '0';
							BSel <= '0';
							MemRW	<= '-';
							WBSel	<= "01";		
							sel_bhw <= "---";
							sel_su <= "--";
							BrUn <= '-';
							imm_sel <= "--";
							PCSel <= '1';
							ALUSel <= "0111";
							--enable_pc <= '1';
						WHEN OTHERS => NULL;
					END CASE;
				WHEN OTHERS => NULL;
			END CASE;
		END PROCESS;
END comportamento;
