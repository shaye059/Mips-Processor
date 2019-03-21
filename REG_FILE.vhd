--------------------------------------------------------------------------------
-- Title         : Register File
-- Project       : Mips Processor
-------------------------------------------------------------------------------
-- File          : REG_FILE.vhd
-- Author        : Spencer Hayes-Laverdiere
-- Created       : 2019/03/06
-------------------------------------------------------------------------------
-- Description : Component containing the 32, 8-bit processor registers. The registers
-- to be read from are addressed by the two 5-bit inputs READ_REG1 and READ_REG2,
-- or if the signal bit REG_WRITE_SIG is high, the register addressed by WRITE_REG
-- is loaded with the byte from WRITE_DATA.
-------------------------------------------------------------------------------
-- Modification history :
-- 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--
entity REG_FILE is
	port(
		READ_REG1, READ_REG2, WRITE_REG: IN std_logic_vector(4 DOWNTO 0);
		WRITE_DATA: IN std_logic_vector(7 DOWNTO 0);
		REG_WRITE_SIG, CLOCK, G_RESETBAR  : IN STD_logic;
		READ_DATA1, READ_DATA2 : OUT STD_logic_vector(7 DOWNTO 0)
		);

	END REG_FILE;
		
	architecture RTL of REG_FILE is
	signal LOAD : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal REG_DATA : std_logic_vector(255 downto 0);

	component EIGHT_BIT_32_TO_1
		port(
		P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16,P17,P18,P19,P20,P21,P22,P23,P24,P25,P26,P27,P28,P29,P30,P31,P32 : IN std_logic_vector(7 DOWNTO 0);
		SEL : IN STD_logic_vector(4 DOWNTO 0);
		Q : OUT STD_logic_vector(7 DOWNTO 0)
		);
	end component;

	component EIGHT_BIT_REG
			PORT(
		load, resetBar: IN	STD_LOGIC;
		i_clock : IN	STD_LOGIC;
		i_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_q : OUT	STD_LOGIC_VECTOR(7 DOWNTO 0));
	end component;
	
	component ONE_BIT_1_TO_32
		port(
		SIG :IN STD_logic;
		SEL : IN STD_logic_vector(4 DOWNTO 0);
		P_OUT : OUT std_logic_vector(31 DOWNTO 0)
		);
	end component;
	
	begin
	
	GEN_EIGHT_BIT_REG: 
   for I in 0 to 31 generate
      REGX : EIGHT_BIT_REG port map
        (LOAD(I), G_RESETBAR,CLOCK,WRITE_DATA, REG_DATA((I*8)+7 DOWNTO (I*8)));
   end generate GEN_EIGHT_BIT_REG;
	
   SEL_R1 : EIGHT_BIT_32_TO_1 port map (REG_DATA(7 DOWNTO 0),REG_DATA(15 DOWNTO 8),REG_DATA(23 DOWNTO 16),REG_DATA(31 DOWNTO 24),
	REG_DATA(39 DOWNTO 32),REG_DATA(47 DOWNTO 40),REG_DATA(55 DOWNTO 48),REG_DATA(63 DOWNTO 56),REG_DATA(71 DOWNTO 64),REG_DATA(79 DOWNTO 72),
	REG_DATA(87 DOWNTO 80),REG_DATA(95 DOWNTO 88), REG_DATA(103 DOWNTO 96),REG_DATA(111 DOWNTO 104),REG_DATA(119 DOWNTO 112),REG_DATA(127 DOWNTO 120),
	REG_DATA(135 DOWNTO 128),REG_DATA(143 DOWNTO 136),REG_DATA(151 DOWNTO 144),REG_DATA(159 DOWNTO 152),REG_DATA(167 DOWNTO 160),REG_DATA(175 DOWNTO 168),
	REG_DATA(183 DOWNTO 176),REG_DATA(191 DOWNTO 184),REG_DATA(199 DOWNTO 192),REG_DATA(207 DOWNTO 200),REG_DATA(215 DOWNTO 208),REG_DATA(223 DOWNTO 216), 
	REG_DATA(231 DOWNTO 224),REG_DATA(239 DOWNTO 232),REG_DATA(247 DOWNTO 240),REG_DATA(255 DOWNTO 248),READ_REG1, READ_DATA1);
	
	SEL_R2 : EIGHT_BIT_32_TO_1 port map (REG_DATA(7 DOWNTO 0),REG_DATA(15 DOWNTO 8),REG_DATA(23 DOWNTO 16),REG_DATA(31 DOWNTO 24),
	REG_DATA(39 DOWNTO 32),REG_DATA(47 DOWNTO 40),REG_DATA(55 DOWNTO 48),REG_DATA(63 DOWNTO 56),REG_DATA(71 DOWNTO 64),REG_DATA(79 DOWNTO 72),
	REG_DATA(87 DOWNTO 80),REG_DATA(95 DOWNTO 88), REG_DATA(103 DOWNTO 96),REG_DATA(111 DOWNTO 104),REG_DATA(119 DOWNTO 112),REG_DATA(127 DOWNTO 120),
	REG_DATA(135 DOWNTO 128),REG_DATA(143 DOWNTO 136),REG_DATA(151 DOWNTO 144),REG_DATA(159 DOWNTO 152),REG_DATA(167 DOWNTO 160),REG_DATA(175 DOWNTO 168),
	REG_DATA(183 DOWNTO 176),REG_DATA(191 DOWNTO 184),REG_DATA(199 DOWNTO 192),REG_DATA(207 DOWNTO 200),REG_DATA(215 DOWNTO 208),REG_DATA(223 DOWNTO 216), 
	REG_DATA(231 DOWNTO 224),REG_DATA(239 DOWNTO 232),REG_DATA(247 DOWNTO 240),REG_DATA(255 DOWNTO 248),READ_REG2, READ_DATA2);
	
	SEL_WRITE : ONE_BIT_1_TO_32 port map (REG_WRITE_SIG,WRITE_REG, LOAD);


	end RTL;