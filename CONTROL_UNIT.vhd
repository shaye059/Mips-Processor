--------------------------------------------------------------------------------
-- Title         : Control Unit
-- Project       : Mips Processor
-------------------------------------------------------------------------------
-- File          : CONTROL_UNIT.vhd
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

entity CONTROL_UNIT is
	port(
		OPCODE_IN : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		RegDst, Jump, Branch, MemToReg, MemWrite, ALUSrc, RegWrite, MemRead : OUT STD_LOGIC;
		ALUOp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
		);

END CONTROL_UNIT;
		
architecture stru of CONTROL_UNIT is

	BEGIN	
	
	RegDst <= NOT(OPCODE_IN(5) OR OPCODE_IN(3) OR OPCODE_IN(2) OR OPCODE_IN(1) OR OPCODE_IN(0));
	Jump <= NOT(OPCODE_IN(5)) AND NOT(OPCODE_IN(3)) AND (OPCODE_IN(1));
	Branch <= OPCODE_IN(2);
	MemToReg <= OPCODE_IN(5) AND NOT(OPCODE_IN(3));
	ALUOp(0) <= OPCODE_IN(5);
	ALUOp(1) <= NOT(OPCODE_IN(5)) AND OPCODE_IN(2);
	MemWrite <= OPCODE_IN(3);
	ALUSrc <= OPCODE_IN(5);
	RegWrite <= (OPCODE_IN(5) AND NOT(OPCODE_IN(3))) OR NOT(OPCODE_IN(5) OR OPCODE_IN(3) OR OPCODE_IN(2) OR OPCODE_IN(1) OR OPCODE_IN(0));
	MemRead <= OPCODE_IN(5) AND NOT(OPCODE_IN(3));
	
	
	
end stru;