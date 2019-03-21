library ieee;
use IEEE.Std_Logic_1164.all;

entity Instruction_ALU is 

	port (
			
	--This is basically a 32-bit adder
			
	A, B		: in std_logic_vector(31 downto 0);
	Sum	: out std_logic_vector(31 downto 0)
	);
			
end Instruction_ALU;
	
	
Architecture ALUArch of Instruction_ALU is 
	
	--Signals
	
	signal C: std_logic_vector(31 downto 0);
	signal Sum_temp: STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	
	--Components 

	component OneBitAdder
	port (
			
		i_CarryIn		: IN	STD_LOGIC;
		i_Ai, i_Bi		: IN	STD_LOGIC;
		o_Sum, o_CarryOut	: OUT	STD_LOGIC);
	
	end component; 
	
Begin
	
	SingleBitAdd: OneBitAdder port map ('0', A(0), B(0), Sum_temp(0), C(0) );
	
	AddGenerator: for I in 1 to 31 generate
	
		SingleBitAdd: OneBitAdder port map (C(I-1), A(I), B(I), Sum_temp(I), C(I)) ;
		
	end generate AddGenerator; 
	
	Sum <= Sum_temp;

End ALUArch;
	
	
	
	