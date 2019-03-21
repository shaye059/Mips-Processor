--------------------------------------------------------------------------------
-- Title         : One Bit 4 TO 1 Mux
-- Project       : Mips Processor
-------------------------------------------------------------------------------
-- File          : ONE_BIT_4_TO_1.vhd
-- Author        : Spencer Hayes-Laverdiere
-- Created       : 2019/03/10
-------------------------------------------------------------------------------
-- Description : 1-Bit 4 to 1 mux creted using three 2 to 1 multiplexers.
-------------------------------------------------------------------------------
-- Modification history :
-- 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--
entity ONE_BIT_4_TO_1 is
	port(
		A_IN, B_IN, C_IN, D_IN: IN STD_LOGIC;
		SEL : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		RESULT: OUT STD_LOGIC
		);

	END ONE_BIT_4_TO_1;
		
	architecture RTL of ONE_BIT_4_TO_1 is
	
	signal OUT1, OUT2 : STD_LOGIC;
	
	component ONE_BIT_2_TO_1
	port (
		A_IN, B_IN, SEL: IN STD_LOGIC;
		RESULT: OUT STD_LOGIC
		);
	
	end component; 

	
	begin
	
	SEL1 : ONE_BIT_2_TO_1 port map(A_IN, B_IN, SEL(0), OUT1);
	SEL2 : ONE_BIT_2_TO_1 port map(C_IN, D_IN, SEL(0), OUT2);
	
	SEL_RESULT : ONE_BIT_2_TO_1 port map(OUT1, OUT2, SEL(1), RESULT);


	end RTL;