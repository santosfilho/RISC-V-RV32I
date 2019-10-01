LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY dmem IS
	PORT(
		clock 	:  IN 	STD_LOGIC;
		addr		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_w	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		sel_bhw  :  IN    STD_LOGIC_VECTOR(2 DOWNTO 0);
		mem_rw	:	IN		STD_LOGIC;
		data_r	:	OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0);		
		sel_su	:  IN 	STD_LOGIC_VECTOR(1 DOWNTO 0); -- necessario para LB, LH, LBU, LHU
		sel_lw	:	IN		STD_LOGIC -- indica se vamos fazer LW
	);
END dmem;

ARCHITECTURE comportamento OF dmem IS
	
	COMPONENT extensor_bhw IS
		PORT(
			data_bhw_in			:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			sel_bhw				:	IN		STD_LOGIC_VECTOR(2 DOWNTO 0);
			ext_data_bhw		:	OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT data_memory IS
		PORT
		(
			address		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			clock			: IN STD_LOGIC  := '1';
			data			: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren			: IN STD_LOGIC ;
			q				: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT extensor_su IS
		PORT(
			in_ext_su		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			sel_su			:	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
			out_ext_su		:	OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT mux IS
		PORT(
			in1_mux, in2_mux		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			sel_mux					:	IN		STD_LOGIC;
			out_mux					:	OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	
	SIGNAL ext_data_bhw				:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL out_data_memory			:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL out_ext_su					:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	BEGIN
	
		extensor_bhw1  :	extensor_bhw PORT MAP(
								data_bhw_in		=> data_w,	
								sel_bhw			=> sel_bhw,	
								ext_data_bhw	=> ext_data_bhw		
								);
		
		data_memory1	:	data_memory PORT MAP(
								address		=>	addr(9 DOWNTO 0), 
								clock			=> clock,
								data			=> ext_data_bhw,
								wren			=> mem_rw,
								q				=> out_data_memory
								);			
		
		extensor_su1:		extensor_su PORT MAP(
								in_ext_su	=> out_data_memory,	
								sel_su		=> sel_su,	
								out_ext_su	=> out_ext_su
								);
								
		mux1:					mux PORT MAP(
								in1_mux 	=>	out_ext_su,
								in2_mux 	=> out_data_memory,
								sel_mux 	=>	sel_lw,	
								out_mux	=>	data_r				
								);
END comportamento;