--------------------------------------------------------------------------------
-- Title         : ALU Control
-- Project       : Mips Processor
-------------------------------------------------------------------------------
-- File          : ALU_CONTROL.vhd
-- Author        : Spencer Hayes-Laverdiere
-- Created       : 2019/03/13
-------------------------------------------------------------------------------
-- Description : Assigns control bits based on opcode. 
-------------------------------------------------------------------------------
-- Modification history :
-- 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity ALU_CONTROL is
	port(
		ALUOp_IN : IN STD_LOGIC;
		INSTRUCTION_OP: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		ALU_OP_OUT : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
		);

END ALU_CONTROL;
		
architecture stru of ALU_CONTROL is

	BEGIN	
	
	ALU_OP_OUT(2) <= NOT(ALUOp_IN) AND NOT(INSTRUCTION_OP(3)) AND INSTRUCTION_OP(1);
	ALU_OP_OUT(1) <= (NOT(INSTRUCTION_OP(2)) AND NOT(INSTRUCTION_OP(0))) OR ALUOp_IN;
	ALU_OP_OUT(0) <= NOT(ALUOp_IN) AND ((NOT(INSTRUCTION_OP(3)) AND INSTRUCTION_OP(2) AND NOT(INSTRUCTION_OP(1)) AND INSTRUCTION_OP(0)) OR
		(INSTRUCTION_OP(3) AND NOT(INSTRUCTION_OP(2)) AND INSTRUCTION_OP(1) AND NOT(INSTRUCTION_OP(0))));
	
	
	
end stru;