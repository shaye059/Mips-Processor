--------------------------------------------------------------------------------
-- Title         : 1-bit 1-to-32 Demux
-- Project       : Mips Processor
-------------------------------------------------------------------------------
-- File          : ONE_BIT_1_TO_32.vhd
-- Author        : Spencer Hayes-Laverdiere
-- Created       : 2019/02/27
-------------------------------------------------------------------------------
-- Description : Demultiplexer that takes as the input SIG and passes it to one
-- of the 32 outputs, according to the value of SEL.
-------------------------------------------------------------------------------
-- Modification history :
-- 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity ONE_BIT_1_TO_32 is
	port(
		SIG :IN STD_logic;
		SEL : IN STD_logic_vector(4 DOWNTO 0);
		P_OUT : OUT std_logic_vector(31 DOWNTO 0)
		);

END ONE_BIT_1_TO_32;
		
architecture stru of ONE_BIT_1_TO_32 is

	SIGNAL P : STD_logic_vector(31 DOWNTO 0);
	
	begin

   P(0) <= NOT(SEL(4)) AND NOT(SEL(3)) AND NOT(SEL(2)) AND NOT(SEL(1)) AND NOT(SEL(0)) AND SIG;
	P(1) <= NOT(SEL(4)) AND NOT(SEL(3)) AND NOT(SEL(2)) AND NOT(SEL(1)) AND SEL(0) AND SIG;
	P(2) <= NOT(SEL(4)) AND NOT(SEL(3)) AND NOT(SEL(2)) AND SEL(1) AND NOT(SEL(0)) AND SIG;
	P(3) <= NOT(SEL(4)) AND NOT(SEL(3)) AND NOT(SEL(2)) AND SEL(1) AND SEL(0) AND SIG;
	P(4) <= NOT(SEL(4)) AND NOT(SEL(3)) AND SEL(2) AND NOT(SEL(1)) AND NOT(SEL(0)) AND SIG;
	P(5) <= NOT(SEL(4)) AND NOT(SEL(3)) AND SEL(2) AND NOT(SEL(1)) AND SEL(0) AND SIG;
	P(6) <= NOT(SEL(4)) AND NOT(SEL(3)) AND SEL(2) AND SEL(1) AND NOT(SEL(0)) AND SIG;
	P(7) <= NOT(SEL(4)) AND NOT(SEL(3)) AND SEL(2) AND SEL(1) AND SEL(0) AND SIG;
	P(8) <= NOT(SEL(4)) AND SEL(3) AND NOT(SEL(2)) AND NOT(SEL(1)) AND NOT(SEL(0)) AND SIG;
	P(9) <= NOT(SEL(4)) AND SEL(3) AND NOT(SEL(2)) AND NOT(SEL(1)) AND SEL(0) AND SIG;
	P(10) <= NOT(SEL(4)) AND SEL(3) AND NOT(SEL(2)) AND SEL(1) AND NOT(SEL(0)) AND SIG;
	P(11) <= NOT(SEL(4)) AND SEL(3) AND NOT(SEL(2)) AND SEL(1) AND SEL(0) AND SIG;
	P(12) <= NOT(SEL(4)) AND SEL(3) AND SEL(2) AND NOT(SEL(1)) AND NOT(SEL(0)) AND SIG;
	P(13) <= NOT(SEL(4)) AND SEL(3) AND SEL(2) AND NOT(SEL(1)) AND SEL(0) AND SIG;
	P(14) <= NOT(SEL(4)) AND SEL(3) AND SEL(2) AND SEL(1) AND NOT(SEL(0)) AND SIG;
	P(15) <= NOT(SEL(4)) AND SEL(3) AND SEL(2) AND SEL(1) AND SEL(0) AND SIG;
	P(16) <= SEL(4) AND NOT(SEL(3)) AND NOT(SEL(2)) AND NOT(SEL(1)) AND NOT(SEL(0)) AND SIG;
	P(17) <= SEL(4) AND NOT(SEL(3)) AND NOT(SEL(2)) AND NOT(SEL(1)) AND SEL(0) AND SIG;
	P(18) <= SEL(4) AND NOT(SEL(3)) AND NOT(SEL(2)) AND SEL(1) AND NOT(SEL(0)) AND SIG;
	P(19) <= SEL(4) AND NOT(SEL(3)) AND NOT(SEL(2)) AND SEL(1) AND SEL(0) AND SIG;
	P(20) <= SEL(4) AND NOT(SEL(3)) AND SEL(2) AND NOT(SEL(1)) AND NOT(SEL(0)) AND SIG;
	P(21) <= SEL(4) AND NOT(SEL(3)) AND SEL(2) AND NOT(SEL(1)) AND SEL(0) AND SIG;
	P(22) <= SEL(4) AND NOT(SEL(3)) AND SEL(2) AND SEL(1) AND NOT(SEL(0)) AND SIG;
	P(23) <= SEL(4) AND NOT(SEL(3)) AND SEL(2) AND SEL(1) AND SEL(0) AND SIG;
	P(24) <= SEL(4) AND SEL(3) AND NOT(SEL(2)) AND NOT(SEL(1)) AND NOT(SEL(0)) AND SIG;
	P(25) <= SEL(4) AND SEL(3) AND NOT(SEL(2)) AND NOT(SEL(1)) AND SEL(0) AND SIG;
	P(26) <= SEL(4) AND SEL(3) AND NOT(SEL(2)) AND SEL(1) AND NOT(SEL(0)) AND SIG;
	P(27) <= SEL(4) AND SEL(3) AND NOT(SEL(2)) AND SEL(1) AND SEL(0) AND SIG;
	P(28) <= SEL(4) AND SEL(3) AND SEL(2) AND NOT(SEL(1)) AND NOT(SEL(0)) AND SIG;
	P(29) <= SEL(4) AND SEL(3) AND SEL(2) AND NOT(SEL(1)) AND SEL(0) AND SIG;
	P(30) <= SEL(4) AND SEL(3) AND SEL(2) AND SEL(1) AND NOT(SEL(0)) AND SIG;
	P(31) <= SEL(4) AND SEL(3) AND SEL(2) AND SEL(1) AND SEL(0) AND SIG;

	P_OUT <= P;
end stru;