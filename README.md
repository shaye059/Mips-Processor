# Mips-Processor

This project is a 32-bit instruction/8-bit data single cycle MIPS processor. The top level entity is SingleCycleProc.vhd. The inputs include a 3 bit value select, to choose which 8-bit value is output (more documentation will be added listing the options in the coming weeks), as well as a global clock and a negative global reset. To start a simulation, the 3-bit value should be chosen (000 represents the output of the program counter and is what has been used for most testing), the global reset should be set to 0, and a clock should be connected to the global clock input.

The minimum clock cycle time has yet to be calculated, so for testing purposes we used a large value of 100ns to ensure that all propagation delays were encapsulated. The global reset should be left at 0 for 2 clock cycles and then it can be set to 1. AT this point the program loaded into the instruction memory will begin to execute. The instruction memory and data memory are read from hex files for ModelSim simulation. More documentation on the current program will be uploaded shortly, however the instructions are standard 32-bit MIPS, stored in hex values, and therefore can be decoded by converting to binary and grouping the bits into their respective fields for each instruction.

Note: It is best to view this README file in RAW format when reading the next section

The instructions executed in the current instruction memory are:
lw $2, 0; ($t2=memory(00) = 55),
lw $3, 1; ($t3=memory(01) = AA), 
sub $1, $2, $3; ($t1=$t2-$t3 = 55),
or $4, $1, $3; ($t4=$t1 or $t3 = FF),
sw $4, 3; (memory(03)=$t4 = FF),
add $1, $2, $3; ($t1=$t2+$t3 = FF),
sw $1, 4; (memory(04)=$t1 = FF),
lw $2, 3; ($t2=memory(03) = FF),
lw $3, 4; ($t3=memory(04) = FF),
j 11; (jump forward 11 instructions from next instruction, to address 0x58),
beq $1, $1, -44; (loop back to beginning of program)


As previously stated, these instructions are stored in hex in the instruction memory. Their hex equivalents are:
8C020000,
8C030001,	
00430822,
00232025,
AC040003,
00430820,
AC010004,
8C020003,
8C030004,
0800000B,
10210035
