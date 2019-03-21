--------------------------------------------------------------------------------
-- Title         : 8-bit 2-to-1 Mux
-- Project       : Mips Processor
-------------------------------------------------------------------------------
-- File          : EIGHT_BIT_TWO_TO_ONE.vhd
-- Author        : Spencer Hayes-Laverdiere
-- Created       : 2019/02/27
-------------------------------------------------------------------------------
-- Description : Multiplexer that takes as input two 8 bit buses, and selects
-- one of them to out put based on the select input. 
-------------------------------------------------------------------------------
-- Modification history :
-- 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity EIGHT_BIT_TWO_TO_ONE is
	port(
		A,B : IN std_logic_vector(7 DOWNTO 0);
		SEL : IN STD_logic;
		Q : OUT STD_logic_vector(7 DOWNTO 0)
		);

END EIGHT_BIT_TWO_TO_ONE;
		
architecture stru of EIGHT_BIT_TWO_TO_ONE is
	signal q_temp : std_logic_vector(7 downto 0);

	component ONE_BIT_SELECT
		port(A, B, SEL: in std_logic;
			Q : out std_logic
		);
	end component;
	
	begin

   GEN_ONE_BIT_SELECT: 
   for I in 0 to 7 generate
      SELX : ONE_BIT_SELECT port map
        (A(I),B(I),SEL, q_temp(I));
   end generate GEN_ONE_BIT_SELECT;

	Q <= q_temp;
end stru;