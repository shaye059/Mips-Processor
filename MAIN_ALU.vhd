--------------------------------------------------------------------------------
-- Title         : Main ALU 8-bits
-- Project       : Mips Processor
-------------------------------------------------------------------------------
-- File          : MAIN_ALU.vhd
-- Author        : Spencer Hayes-Laverdiere
-- Created       : 2019/03/10
-------------------------------------------------------------------------------
-- Description : 
-------------------------------------------------------------------------------
-- Modification history :
-- 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--
entity MAIN_ALU is
	port(
		A_IN, B_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		OPERATION : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		ZERO : OUT STD_LOGIC;
		RESULT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);

	END MAIN_ALU;
		
	architecture RTL of MAIN_ALU is
	
-------------------------------------------------------------------------------
--  Signals
-------------------------------------------------------------------------------
	
	signal CARRY, CARRY_INV, R_TEMP, SET_TEMP, R_INV_TEMP, R_TEMP_FINAL, SET_INV_TEMP : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal B_INVERT_CONTR, CARRY_IN, RESULT_INV: STD_LOGIC;

-------------------------------------------------------------------------------
--  Component Declaration
-------------------------------------------------------------------------------

	
	component ONE_BIT_ALU
		port(
		A_IN, B_IN, LESS, A_INVERT, B_INVERT, CARRY_IN: IN STD_LOGIC;
		OPERATION : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		RESULT, CARRY_OUT, SET : OUT STD_LOGIC
		);
	end component;

	component EIGHT_BIT_TWO_TO_ONE 
	port(
		A,B : IN std_logic_vector(7 DOWNTO 0);
		SEL : IN STD_logic;
		Q : OUT STD_logic_vector(7 DOWNTO 0)
		);
	end component;
	
	begin
	
	B_INVERT_CONTR <= OPERATION(2) OR (OPERATION(1) AND OPERATION(0));
	CARRY_IN <= OPERATION(2) OR (OPERATION(1) AND OPERATION(0));
	
	SINGLE_ALU0 : ONE_BIT_ALU port map
        (A_IN(0), B_IN(0),SET_TEMP(7), '0', B_INVERT_CONTR, CARRY_IN, OPERATION(1 DOWNTO 0), R_TEMP(0), CARRY(0), SET_TEMP(0));
	
	GEN_EIGHT_BIT_REG: 
   for I in 1 to 7 generate
      SINGLE_ALUX : ONE_BIT_ALU port map
        (A_IN(I), B_IN(I),'0', '0', B_INVERT_CONTR, CARRY(I-1), OPERATION(1 DOWNTO 0), R_TEMP(I), CARRY(I), SET_TEMP(I));
   end generate GEN_EIGHT_BIT_REG;
	
   	ZERO <= NOT(R_TEMP(7) OR R_TEMP(6) OR R_TEMP(5) OR R_TEMP(4) OR R_TEMP(3) OR R_TEMP(2) OR R_TEMP(1) OR R_TEMP(0));

	SINGLE_ALUX0 : ONE_BIT_ALU port map
        ('0',R_TEMP(0),'0', '0', '1', '1', "10", R_INV_TEMP(0), CARRY_INV(0), SET_INV_TEMP(0));

	GEN_EIGHT_BIT_INV: 
   		for I in 1 to 7 generate
      			SINGLE_ALUXX : ONE_BIT_ALU port map
        		('0', R_TEMP(I),'0', '0','1', CARRY_INV(I-1), "10", R_INV_TEMP(I), CARRY_INV(I), SET_INV_TEMP(I));
   	end generate GEN_EIGHT_BIT_INV;

	
	RESULT_INV <= OPERATION(2) AND R_TEMP(7) AND NOT(A_IN(7)) AND B_IN(7);
	
	RES_SEL : EIGHT_BIT_TWO_TO_ONE port map(R_TEMP, R_INV_TEMP, RESULT_INV, R_TEMP_FINAL);
	
	RESULT <= R_TEMP_FINAL;

	end RTL;