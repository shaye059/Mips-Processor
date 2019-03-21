--------------------------------------------------------------------------------
-- Title         : One Bit 2 TO 1 Mux
-- Project       : Mips Processor
-------------------------------------------------------------------------------
-- File          : ONE_BIT_2_TO_1.vhd
-- Author        : Spencer Hayes-Laverdiere
-- Created       : 2019/03/10
-------------------------------------------------------------------------------
-- Description : Simple 2-to-1 mux which chooses between inputs A_IN or B_IN based
-- on the value of the SEL input. 
-------------------------------------------------------------------------------
-- Modification history :
-- 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--
entity ONE_BIT_2_TO_1 is
	port(
		A_IN, B_IN, SEL: IN STD_LOGIC;
		RESULT: OUT STD_LOGIC
		);

	END ONE_BIT_2_TO_1;
		
	architecture RTL of ONE_BIT_2_TO_1 is

	
	begin
	
	RESULT <= ((NOT(SEL) AND A_IN) OR (SEL AND B_IN));


	end RTL;