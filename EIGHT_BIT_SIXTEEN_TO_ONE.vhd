--------------------------------------------------------------------------------
-- Title         : 8-bit 16-to-1 Mux
-- Project       : Mips Processor
-------------------------------------------------------------------------------
-- File          : EIGHT_BIT_SIXTEEN_TO_ONE.vhd
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

entity EIGHT_BIT_SIXTEEN_TO_ONE is
	port(
		P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16 : IN std_logic_vector(7 DOWNTO 0);
		SEL : IN STD_logic_vector(3 DOWNTO 0);
		Q : OUT STD_logic_vector(7 DOWNTO 0)
		);

END EIGHT_BIT_SIXTEEN_TO_ONE;
		
architecture stru of EIGHT_BIT_SIXTEEN_TO_ONE is
	signal q_temp, q_temp1, q_temp2, q_temp3, q_temp4 : std_logic_vector(7 downto 0);

	component EIGHT_BIT_FOUR_TO_ONE
		port(
		P1,P2,P3,P4 : IN std_logic_vector(7 DOWNTO 0);
		SEL : IN STD_logic_vector(1 DOWNTO 0);
		Q : OUT STD_logic_vector(7 DOWNTO 0)
		);
	end component;
	
	begin

   SEL_1TO4 : EIGHT_BIT_FOUR_TO_ONE port map (P1,P2,P3,P4,SEL(1 DOWNTO 0), q_temp1);
	SEL_5TO8 : EIGHT_BIT_FOUR_TO_ONE port map (P5,P6,P7,P8,SEL(1 DOWNTO 0), q_temp2);
	SEL_9TO12 : EIGHT_BIT_FOUR_TO_ONE port map (P9,P10,P11,P12,SEL(1 DOWNTO 0), q_temp3);
	SEL_12TO16 : EIGHT_BIT_FOUR_TO_ONE port map (P13,P14,P15,P16, SEL(1 DOWNTO 0), q_temp4);
	SEL_MAIN : EIGHT_BIT_FOUR_TO_ONE port map (q_temp1,q_temp2, q_temp3,q_temp4,SEL(3 DOWNTO 2), q_temp);


	Q <= q_temp;
end stru;