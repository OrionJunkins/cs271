// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

//Set product = 0
@product
M=0

//Check R0 not 0
@R0
D=M
@STOP
D;JEQ

//Check R1 not 0
@R1
D=M
@STOP
D;JEQ

//Set itt = 0
@itt
M=1

(LOOP)  //name this line 'LOOP'
@itt
D=M
@R1
D=D-M   //D=b-itt
@STOP   
D;JGT  //if D > 0 Jump to STOP
@R0
D=M
@product
M=M+D    //product = product + a
@itt
M=M+1     //itt ++
@LOOP
0;JMP     //JMP to LOOP
(STOP)

@product
D=M
@R2
M=D

(END)
@END
0;JMP

