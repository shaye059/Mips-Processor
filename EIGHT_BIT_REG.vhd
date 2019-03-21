--------------------------------------------------------------------------------
-- Title         : 8-Bit Register
-- Project       : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- File          : EIGHT_BIT_REG.vhd
-- Author        : Spencer Hayes-Laverdiere
-- Created       : 2019/03/06
-------------------------------------------------------------------------------
-- Description : Resister that stores an 8 bit, binary number. When the load signal
-- is active, the register contents are replaced by the value at i_in at the next
-- clock cycle. 
-------------------------------------------------------------------------------
-- Modification history :

-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EIGHT_BIT_REG IS
	PORT(
		load, resetBar: IN	STD_LOGIC;
		i_clock : IN	STD_LOGIC;
		i_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_q : OUT	STD_LOGIC_VECTOR(7 DOWNTO 0));
END EIGHT_BIT_REG;

ARCHITECTURE rtl OF EIGHT_BIT_REG IS
	SIGNAL d_in: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL d_qBar: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL d_out: STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	COMPONENT enARdFF_2
	port(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC
		);
	END COMPONENT;

BEGIN

	bit7: enARdFF_2 PORT MAP (resetBar, d_in(7), load, i_clock,d_out(7), d_qBar(7));
	bit6: enARdFF_2 PORT MAP (resetBar, d_in(6), load, i_clock,d_out(6), d_qBar(6));
	bit5: enARdFF_2 PORT MAP (resetBar, d_in(5), load, i_clock,d_out(5), d_qBar(5));
	bit4: enARdFF_2 PORT MAP (resetBar, d_in(4), load, i_clock,d_out(4), d_qBar(4));
	bit3: enARdFF_2 PORT MAP (resetBar, d_in(3), load, i_clock,d_out(3), d_qBar(3));
	bit2: enARdFF_2 PORT MAP (resetBar, d_in(2), load, i_clock,d_out(2), d_qBar(2));
	bit1: enARdFF_2 PORT MAP (resetBar, d_in(1), load, i_clock,d_out(1), d_qBar(1));
	bit0: enARdFF_2 PORT MAP (resetBar, d_in(0), load, i_clock,d_out(0), d_qBar(0));
	
	d_in(7) <= i_in(7);
	d_in(6) <= i_in(6);
	d_in(5) <= i_in(5);
	d_in(4) <= i_in(4);
	d_in(3) <= i_in(3);
	d_in(2) <= i_in(2);
	d_in(1) <= i_in(1);
	d_in(0) <= i_in(0);
	o_q <= d_out;
	
	END RTL;