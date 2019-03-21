--------------------------------------------------------------------------------
-- Title         : 8-bit 8-to-1 Mux
-- Project       : Mips Processor
-------------------------------------------------------------------------------
-- File          : EIGHT_BIT_EIGHT_TO_ONE.vhd
-- Author        : Spencer Hayes-Laverdiere
-- Created       : 2019/03/213
-------------------------------------------------------------------------------
-- Description : Multiplexer that takes as input eight 8 bit buses, and selects
-- one of them to out put based on the value of the two select bits. 
-------------------------------------------------------------------------------
-- Modification history :
-- 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity EIGHT_BIT_EIGHT_TO_ONE is
	port(
		P0,P1,P2,P3,P4,P5,P6,P7 : IN std_logic_vector(7 DOWNTO 0);
		SEL : IN STD_logic_vector(2 DOWNTO 0);
		Q : OUT STD_logic_vector(7 DOWNTO 0)
		);

END EIGHT_BIT_EIGHT_TO_ONE;
		
architecture stru of EIGHT_BIT_EIGHT_TO_ONE is
	signal q_temp, q_temp1234, q_temp5678 : std_logic_vector(7 downto 0);

	component EIGHT_BIT_FOUR_TO_ONE
		port(
			P1,P2,P3,P4 : IN std_logic_vector(7 DOWNTO 0);
			SEL : IN STD_logic_vector(1 DOWNTO 0);
			Q : OUT STD_logic_vector(7 DOWNTO 0)
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

   SEL1234 : EIGHT_BIT_FOUR_TO_ONE port map (P0,P1,P2,P3, SEL(1 DOWNTO 0), q_temp1234);
	SEL5678 : EIGHT_BIT_FOUR_TO_ONE port map (P4,P5,P6,P7,SEL(1 DOWNTO 0), q_temp5678);
	SEL_MAIN : EIGHT_BIT_TWO_TO_ONE port map (q_temp1234,q_temp5678, SEL(2), q_temp);


	Q <= q_temp;
end stru;