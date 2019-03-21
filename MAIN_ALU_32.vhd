--------------------------------------------------------------------------------
-- Title         : Main ALU 32-bits
-- Project       : Mips Processor
-------------------------------------------------------------------------------
-- File          : MAIN_ALU_32.vhd
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
entity MAIN_ALU_32 is
	port(
		A_IN, B_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		OPERATION : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		ZERO : OUT STD_LOGIC;
		RESULT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);

	END MAIN_ALU_32;
		
	architecture RTL of MAIN_ALU_32 is
	
-------------------------------------------------------------------------------
--  Signals
-------------------------------------------------------------------------------
	
	signal CARRY, R_TEMP, SET_TEMP : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal B_INVERT_CONTR, CARRY_IN : STD_LOGIC;

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
	
	begin
	
	B_INVERT_CONTR <= OPERATION(2) OR (OPERATION(1) AND OPERATION(0));
	CARRY_IN <= OPERATION(2) OR (OPERATION(1) AND OPERATION(0));
	
	SINGLE_ALU0 : ONE_BIT_ALU port map
        (A_IN(0), B_IN(0),SET_TEMP(31), '0', B_INVERT_CONTR, CARRY_IN, OPERATION(1 DOWNTO 0), R_TEMP(0), CARRY(0), SET_TEMP(0));
	
	GEN_EIGHT_BIT_REG: 
   for I in 1 to 31 generate
      SINGLE_ALUX : ONE_BIT_ALU port map
        (A_IN(I), B_IN(I),'0', '0', B_INVERT_CONTR, CARRY(I-1), OPERATION(1 DOWNTO 0), R_TEMP(I), CARRY(I), SET_TEMP(I));
   end generate GEN_EIGHT_BIT_REG;
	
   ZERO <= NOT(R_TEMP(31) OR R_TEMP(30) OR R_TEMP(29) OR R_TEMP(28) OR R_TEMP(27) OR R_TEMP(26) OR R_TEMP(25) OR R_TEMP(24) OR
	R_TEMP(23) OR R_TEMP(22) OR R_TEMP(21) OR R_TEMP(20) OR R_TEMP(19) OR R_TEMP(18) OR R_TEMP(17) OR R_TEMP(16) OR
	R_TEMP(15) OR R_TEMP(14) OR R_TEMP(13) OR R_TEMP(12) OR R_TEMP(11) OR R_TEMP(10) OR R_TEMP(9) OR R_TEMP(8) OR
	R_TEMP(7) OR R_TEMP(6) OR R_TEMP(5) OR R_TEMP(4) OR R_TEMP(3) OR R_TEMP(2) OR R_TEMP(1) OR R_TEMP(0));
	
	RESULT <= R_TEMP;

	end RTL;