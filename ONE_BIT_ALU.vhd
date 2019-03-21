--------------------------------------------------------------------------------
-- Title         : One Bit ALU
-- Project       : Mips Processor
-------------------------------------------------------------------------------
-- File          : ONE_BIT_ALU.vhd
-- Author        : Spencer Hayes-Laverdiere
-- Created       : 2019/03/10
-------------------------------------------------------------------------------
-- Description : Single bit of ALU. Takes as input the single bits A_IN, B_IN,
-- LESS, A_INVERT, B_INVERT, and CARRY_IN, as well as a 2-bit operation ccontrol.
-- The output, based on the opcode, is as follows:
--		00 - A AND B
--		01 - A OR B
--		10 - A + B
--		11 - LESS
--
-- A_INVERT and B_INVERT are control signal to choose whether to invert A or B.
-------------------------------------------------------------------------------
-- Modification history :
-- 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--
entity ONE_BIT_ALU is
	port(
		A_IN, B_IN, LESS, A_INVERT, B_INVERT, CARRY_IN: IN STD_LOGIC;
		OPERATION : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		RESULT, CARRY_OUT, SET : OUT STD_LOGIC
		);

	END ONE_BIT_ALU;
		
	architecture RTL of ONE_BIT_ALU is

-------------------------------------------------------------------------------
--  Signals
-------------------------------------------------------------------------------
	signal A_TEMP, B_TEMP, A_NOT, B_NOT, RESULT_TEMP, MUX_IN0, MUX_IN1, MUX_IN2, MUX_IN3 : STD_LOGIC;
	
-------------------------------------------------------------------------------
--  Component Declaration
-------------------------------------------------------------------------------

	component ONE_BIT_4_TO_1
	port(
		A_IN, B_IN, C_IN, D_IN: IN STD_LOGIC;
		SEL : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		RESULT: OUT STD_LOGIC
		);
	
	end component;

	
	component ONE_BIT_2_TO_1
	port(
		A_IN, B_IN, SEL: IN STD_LOGIC;
		RESULT: OUT STD_LOGIC
		);
		
	end component; 	
	
	component OneBitAdder
	port (
			
		i_CarryIn		: IN	STD_LOGIC;
		i_Ai, i_Bi		: IN	STD_LOGIC;
		o_Sum, o_CarryOut	: OUT	STD_LOGIC);
	
	end component; 

	
	begin

	A_NOT <= NOT(A_IN);
	B_NOT <= NOT(B_IN);
	
	MUXA : ONE_BIT_2_TO_1 port map(A_IN, A_NOT, A_INVERT, A_TEMP);
	MUXB : ONE_BIT_2_TO_1 port map(B_IN, B_NOT, B_INVERT, B_TEMP);
	ADDER : OneBitAdder port map(CARRY_IN, A_TEMP, B_TEMP, RESULT_TEMP, CARRY_OUT);
	
	MUX_IN0 <= A_TEMP AND B_TEMP;
	MUX_IN1 <= A_TEMP OR B_TEMP;
	MUX_IN2 <= RESULT_TEMP;
	MUX_IN3 <= LESS;
	
	MUX : ONE_BIT_4_TO_1 port map(MUX_IN0, MUX_IN1, MUX_IN2, MUX_IN3, OPERATION, RESULT);
	
	SET <= RESULT_TEMP;
	



	end RTL;