library ieee;
use IEEE.Std_Logic_1164.all;

entity PC_Adder is 

	--This is basically a 4-bit adder

	PORT(
		CarryIn		: in std_logic;
		A, B		: in std_logic_vector(7 downto 0);
		Sum	: out std_logic_vector(7 downto 0)
		);
		
END PC_Adder;

Architecture AdderArch of PC_Adder is 

	signal C: std_logic_vector(7 downto 0);
	signal Sum_temp: STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	component OneBitAdder
	port (
			
		i_CarryIn		: IN	STD_LOGIC;
		i_Ai, i_Bi		: IN	STD_LOGIC;
		o_Sum, o_CarryOut	: OUT	STD_LOGIC);
	
	end component; 
	
Begin
	
	SingleBitAdd: OneBitAdder port map (CarryIn, A(0), B(0), Sum_temp(0), C(0) );
	
	AddGenerator: for I in 1 to 7 generate
	
		SingleBitAdd: OneBitAdder port map (C(I-1), A(I), B(I), Sum_temp(I), C(I)) ;
		
	end generate AddGenerator; 
	
	Sum <= Sum_temp;

end AdderArch; 