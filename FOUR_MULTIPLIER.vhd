--------------------------------------------------------------------------------
-- Title         : Times 4 Multiplier
-- Project       : Mips Processor
-------------------------------------------------------------------------------
-- File          : FOUR_MULTIPLIER.vhd
-- Author        : Spencer Hayes-Laverdiere
-- Created       : 2019/03/12
-------------------------------------------------------------------------------
-- Description : Extends a signed 8-bit number to 10 bits and keeps the sign. 
-------------------------------------------------------------------------------
-- Modification history :
-- 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity FOUR_MULTIPLIER is
	port(
		BYTE_IN : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		PRODUCT_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);

END FOUR_MULTIPLIER;
		
architecture stru of FOUR_MULTIPLIER is

	BEGIN	
	
	PRODUCT_OUT(7 DOWNTO 2) <= BYTE_IN;
	PRODUCT_OUT(1 DOWNTO 0) <= "00";
	
end stru;