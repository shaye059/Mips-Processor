library ieee;
use IEEE.Std_Logic_1164.all;

entity Two_Shift_Left_ThirtyTwo is 

	port (
			
			--Shifts a number two spaces to the left 
			
			NumIn: in std_logic_vector(31 downto 0);
			
			NumOut: out std_logic_vector(31 downto 0);
				
			clk: in std_logic	
				
		);
end Two_Shift_Left_ThirtyTwo;


Architecture ShiftLeftTwo of Two_Shift_Left_ThirtyTwo  is 

	SIGNAL d_in: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL d_qBar: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL d_q: STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	COMPONENT dFF_2
		PORT(
			i_d		: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;
	
begin	
	
	d_in <= NumIn; 
	
	DFF_Generator: for i in 0 to 31 generate
	
		DFF: DFF_2 port map (d_in(i), clk, d_q(i), d_qBar(i)) ;
		
	end generate DFF_Generator; 
	
	process (A)
	begin
	--Peform first shift left
	for i in 1 to 31 loop
		d_in (i) <= d_in(i-1);
	end loop;
	end process;
	
	--Set lowest bit to zero
	d_in(0) <= '0';
	
	process (B)
	begin
	--Perform second shift left
	for i in 1 to 31 loop
		d_in (i) <= d_in(i-1);
	end loop;
	end process; 
	
	--Final Output
	NumOut <= d_q;

end ShiftLeftTwo ;	
	
		
	