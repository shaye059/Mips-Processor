library ieee;
use IEEE.Std_Logic_1164.all;

entity SignExtend is 

	port (
			
			--Converts a 16-bit number into a 32-bit number 
			
			NumIn: in std_logic_vector(15 downto 0);
			
			NumOut: out std_logic_vector(31 downto 0);
				
			clk: in std_logic
				
		);
end SignExtend;
	

Architecture SignExtendArch of SignExtend  is 

	signal Bigger_Number: STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	begin
	
	Bigger_Number (31 downto 16) <= '0';
	Bigger_Number (15 downto 0) <= NumIn;
	
	NumOut <= Bigger_Number; 
	
	end SignExtendArch;
	