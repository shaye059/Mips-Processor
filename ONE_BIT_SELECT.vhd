library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY ONE_BIT_SELECT IS
	PORT(
		A,B, Sel: IN STD_LOGIC; 	--Inputs A,B, and select bit
		Q : OUT STD_LOGIC
	);

END ONE_BIT_SELECT;

ARCHITECTURE BEHAV OF ONE_BIT_SELECT IS
	BEGIN
	Q <= (A and not(Sel)) or (B and Sel);
	
END BEHAV;