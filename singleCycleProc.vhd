--------------------------------------------------------------------------------
-- Title         : Single Cycle Processor
-- Project       : Mips Processor
-------------------------------------------------------------------------------
-- File          : singleCycleProc.vhd
-- Author        : Spencer Hayes-Laverdiere
-- Created       : 2019/03/08
-------------------------------------------------------------------------------
-- Description : Top level module of the Single Cycle Processor.
-- Note: The branch offset is the 6 least significant bits of instruction. It is
-- represented in signed 2's complement. For example, -3 would be 111101. The
-- offset represents the jump in instructions, and will therefore be multiplied
-- by 4 in order to increase PC by the proper # of bytes. 
-------------------------------------------------------------------------------
-- Modification history :
-- 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--
entity singleCycleProc is
	port(
		ValueSelect : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		GClock, GresetBar : IN STD_LOGIC;
		MuxOut : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		InstructionOut: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		BranchOut, ZeroOut, MemWriteOut, RegWriteOut: OUT STD_LOGIC
		);

	END singleCycleProc;
		
	architecture RTL of singleCycleProc is
-------------------------------------------------------------------------------
--  Signals
-------------------------------------------------------------------------------
	signal PC_IN, PC_OUT, PC_INC_OUT, REG_READ1, REG_READ2, WRITE_DATA_IN, ALU_MUX_OUT, ALU_RESULT, READ_DATA, PC_ADD2, 
	PC_BRANCH_ADR, PC_MUX1_OUT, LAST_MUX_INPUT : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	signal INSTRUCTION_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal WRITE_REG_IN : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal ALU_CONTROL_OUT : STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal RegDST, REG_WRITE_SIG, ALUSrc, ZERO_SIG, MemWrite, BRANCH_ZERO_SIG, Jump, MemToReg, BRANCH, MemRead, InvertedClock: STD_LOGIC;
	signal ALUOp : STD_LOGIC_VECTOR(1 DOWNTO 0);
	
	
-------------------------------------------------------------------------------
--  Component Declaration
-------------------------------------------------------------------------------

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
	
	component instruction_mem
		PORT(
		address	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock	: IN STD_LOGIC  := '1';
		q	: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	end component;
	
	component EIGHT_BIT_TWO_TO_ONE
		port(
		A,B : IN std_logic_vector(7 DOWNTO 0);
		SEL : IN STD_logic;
		Q : OUT STD_logic_vector(7 DOWNTO 0)
		);
	end component;
	
	component FIVE_BIT_TWO_TO_ONE
		port(
		A,B : IN std_logic_vector(4 DOWNTO 0);
		SEL : IN STD_logic;
		Q : OUT STD_logic_vector(4 DOWNTO 0)
		);
	end component;
	
	
	component REG_FILE
		port(
		READ_REG1, READ_REG2, WRITE_REG: IN std_logic_vector(4 DOWNTO 0);
		WRITE_DATA: IN std_logic_vector(7 DOWNTO 0);
		REG_WRITE_SIG, CLOCK, G_RESETBAR  : IN STD_logic;
		READ_DATA1, READ_DATA2 : OUT STD_logic_vector(7 DOWNTO 0)
		);
	end component;
	
	component PC_Adder
		PORT(
		CarryIn		: in std_logic;
		A, B		: in std_logic_vector(7 downto 0);
		Sum	: out std_logic_vector(7 downto 0)
		);
	end component;
	
	component MAIN_ALU
		port(
		A_IN, B_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		OPERATION : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		ZERO : OUT STD_LOGIC;
		RESULT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	end component;
	
	component data_mem
		PORT(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		rden		: IN STD_LOGIC  := '1';
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);
	end component;
	
	component FOUR_MULTIPLIER
		port(
		BYTE_IN : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		PRODUCT_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);

	end component;
	
	component CONTROL_UNIT
		port(
		OPCODE_IN : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		RegDst, Jump, Branch, MemToReg, MemWrite, ALUSrc, RegWrite, MemRead : OUT STD_LOGIC;
		ALUOp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
		);

	end component;
	
	component ALU_CONTROL
		port(
		ALUOp_IN : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		INSTRUCTION_OP: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		ALU_OP_OUT : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
		);
	end component;
	
	
	component EIGHT_BIT_EIGHT_TO_ONE
		port(
		P0,P1,P2,P3,P4,P5,P6,P7 : IN std_logic_vector(7 DOWNTO 0);
		SEL : IN STD_logic_vector(2 DOWNTO 0);
		Q : OUT STD_logic_vector(7 DOWNTO 0)
		);
	end component;
	
	component clockInverter
	port(
		GClock : IN STD_LOGIC;
		InvertedClock : OUT STD_LOGIC
		);

	END component;
	
	begin
	
	--Program Counter
	PC_REG : EIGHT_BIT_REG port map('1', GresetBar, InvertedClock,PC_IN, PC_OUT);
	
	--Instruction Memeory
	MEM_ROM : instruction_mem port map(PC_OUT, GClock, INSTRUCTION_OUT);
	
	--Write Register Mux
	WRITE_MUX : FIVE_BIT_TWO_TO_ONE port map(INSTRUCTION_OUT(20 DOWNTO 16), INSTRUCTION_OUT(15 DOWNTO 11), RegDST, WRITE_REG_IN);
	
	--Register File
	REGISTER_FILE : REG_FILE port map(INSTRUCTION_OUT(25 DOWNTO 21), INSTRUCTION_OUT(20 DOWNTO 16), WRITE_REG_IN, WRITE_DATA_IN,
	REG_WRITE_SIG, GClock, GresetBar, REG_READ1, REG_READ2);
	
	--PC Incrementer
	PC_INC : PC_Adder port map('0', PC_OUT, "00000100", PC_INC_OUT);
	
	--ALU Source2 Mux
	ALU_SRC2 : EIGHT_BIT_TWO_TO_ONE port map(REG_READ2, INSTRUCTION_OUT(7 DOWNTO 0), ALUSrc, ALU_MUX_OUT);
	
	--Main ALU
	DATA_ALU : MAIN_ALU port map(REG_READ1, ALU_MUX_OUT, ALU_CONTROL_OUT, ZERO_SIG, ALU_RESULT);
	
	--Data Memory
	MEM_RAM : data_mem port map(ALU_RESULT, InvertedClock, REG_READ2, MemRead, MemWrite, READ_DATA); -- GClock replaced by '1'
	
	--Branch Offset Multiplier
	BR_MULT : FOUR_MULTIPLIER port map(INSTRUCTION_OUT(5 DOWNTO 0), PC_ADD2);
	
	--Branch Offset Adder
	BR_ADD : PC_Adder port map('0', PC_INC_OUT, PC_ADD2, PC_BRANCH_ADR);
	
	--Branch Decision Mux
	BR_MUX  : EIGHT_BIT_TWO_TO_ONE port map(PC_INC_OUT, PC_BRANCH_ADR, BRANCH_ZERO_SIG, PC_MUX1_OUT);
	
	--Jump Decision Mux
	JU_MUX  : EIGHT_BIT_TWO_TO_ONE port map(PC_MUX1_OUT, PC_ADD2, Jump, PC_IN);
	
	--Register File Data Mux
	REG_DATA_MUX : EIGHT_BIT_TWO_TO_ONE port map(ALU_RESULT, READ_DATA, MemToReg, WRITE_DATA_IN);
	
	--ALU Control
	ALU_CNTRL : ALU_CONTROL port map(ALUOp, INSTRUCTION_OUT(5 DOWNTO 0), ALU_CONTROL_OUT);
	
	--Control Unit
	CNTRL : CONTROL_UNIT port map(INSTRUCTION_OUT(31 DOWNTO 26), regDST, Jump, BRANCH, MemToReg, MemWrite, ALUSrc, REG_WRITE_SIG, MemRead, ALUOp);
	
	--CLock Inverter
	INV : ClockInverter port map(GClock, InvertedClock);
	
	
	
	--Output Mux
	HLMUX : EIGHT_BIT_EIGHT_TO_ONE port map(PC_OUT, ALU_RESULT, REG_READ1, REG_READ2, WRITE_DATA_IN,LAST_MUX_INPUT,LAST_MUX_INPUT,LAST_MUX_INPUT, ValueSelect, MuxOut);
	
	
	--Signals
	LAST_MUX_INPUT(7) <= '0';
	LAST_MUX_INPUT(6) <= RegDST;
	LAST_MUX_INPUT(5) <= Jump;
	LAST_MUX_INPUT(4) <= MemRead;
	LAST_MUX_INPUT(3) <= MemToReg;
	LAST_MUX_INPUT(2 DOWNTO 1) <= ALUOp;
	LAST_MUX_INPUT(0) <= ALUSrc;
	BRANCH_ZERO_SIG <= BRANCH AND ZERO_SIG;
	InstructionOut <= INSTRUCTION_OUT;
	BranchOut <= BRANCH;
	ZeroOut <= ZERO_SIG;
	MemWriteOut <= MemWrite;
	RegWriteOut <= REG_WRITE_SIG;
	
	


	end RTL;