--------------------------------------------------------------------------------
-- Title         : 8-bit 4-to-1 Mux
-- Project       : Mips Processor
-------------------------------------------------------------------------------
-- File          : EIGHT_BIT_FOUR_TO_ONE.vhd
-- Author        : Spencer Hayes-Laverdiere
-- Created       : 2019/02/27
-------------------------------------------------------------------------------
-- Description : Multiplexer that takes as input four 8 bit buses, and selects
-- one of them to out put based on the value of the two select bits. 
-------------------------------------------------------------------------------
-- Modification history :
-- 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity EIGHT_BIT_FOUR_TO_ONE is
	port(
		P1,P2,P3,P4 : IN std_logic_vector(7 DOWNTO 0);
		SEL : IN STD_logic_vector(1 DOWNTO 0);
		Q : OUT STD_logic_vector(7 DOWNTO 0)
		);

END EIGHT_BIT_FOUR_TO_ONE;
		
architecture stru of EIGHT_BIT_FOUR_TO_ONE is
	signal q_temp, q_temp12, q_temp34 : std_logic_vector(7 downto 0);

	component EIGHT_BIT_TWO_TO_ONE
		port(
			A,B : IN std_logic_vector(7 DOWNTO 0);
			SEL : IN STD_logic;
			Q : OUT STD_logic_vector(7 DOWNTO 0)
		);
	end component;
	
	begin

   SEL12 : EIGHT_BIT_TWO_TO_ONE port map (P1,P2,SEL(0), q_temp12);
	SEL34 : EIGHT_BIT_TWO_TO_ONE port map (P3,P4,SEL(0), q_temp34);
	SEL_MAIN : EIGHT_BIT_TWO_TO_ONE port map (q_temp12,q_temp34,SEL(1), q_temp);


	Q <= q_temp;
end stru;