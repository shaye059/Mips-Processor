
library ieee;
use ieee.std_logic_1164.all;
--
entity clockInverter is
	port(
		GClock : IN STD_LOGIC;
		InvertedClock : OUT STD_LOGIC
		);

	END clockInverter;
		
	architecture RTL of clockInverter is
	
	begin
	
	InvertedClock <= NOT(GClock);
	
	end rtl;
	