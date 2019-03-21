--------------------------------------------------------------------------------
-- Title         : 8-bit 32-to-1 Mux
-- Project       : Mips Processor
-------------------------------------------------------------------------------
-- File          : EIGHT_BIT_32_TO_1.vhd
-- Author        : Spencer Hayes-Laverdiere
-- Created       : 2019/02/27
-------------------------------------------------------------------------------
-- Description : Multiplexer that takes as input 32 8-bit buses, and selects
-- one of them to output based on the value of the 5 select bits. 
-------------------------------------------------------------------------------
-- Modification history :
-- 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity EIGHT_BIT_32_TO_1 is
	port(
		P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16,P17,P18,P19,P20,P21,P22,P23,P24,P25,P26,P27,P28,P29,P30,P31,P32 : IN std_logic_vector(7 DOWNTO 0);
		SEL : IN STD_logic_vector(4 DOWNTO 0);
		Q : OUT STD_logic_vector(7 DOWNTO 0)
		);

END EIGHT_BIT_32_TO_1;
		
architecture stru of EIGHT_BIT_32_TO_1 is
	signal q_temp, q_temp1, q_temp2 : std_logic_vector(7 downto 0);

	component EIGHT_BIT_SIXTEEN_TO_ONE
		port(
		P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16 : IN std_logic_vector(7 DOWNTO 0);
		SEL : IN STD_logic_vector(3 DOWNTO 0);
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

   SEL_1TO4 : EIGHT_BIT_SIXTEEN_TO_ONE port map (P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16,SEL(3 DOWNTO 0), q_temp1);
	SEL_5TO8 : EIGHT_BIT_SIXTEEN_TO_ONE port map (P17,P18,P19,P20,P21,P22,P23,P24,P25,P26,P27,P28,P29,P30,P31,P32,SEL(3 DOWNTO 0), q_temp2);
	SEL_MAIN : EIGHT_BIT_TWO_TO_ONE port map (q_temp1,q_temp2, SEL(4), q_temp);


	Q <= q_temp;
end stru;