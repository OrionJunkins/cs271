// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

//Loop until a key is pressed
(STAYCLEAR)
@KBD
D=M
@STAYCLEAR
D;JEQ //if KBD == 0 Goto loop

//Create a counter
@i
M=0 //set i = 0

//Iterate 16 bits at a time until screen is full
(FILL)
@i
D=M
@SCREEN 
D=D+A
@KBD
D = A - D      //D = address of KBD - (address of SCREEN + I)
@STAYFILLED
D;JLE          //if D <= 0, screen is full so jump to STAYFILLED

@SCREEN
D=A
@i 
A = D + M     //Set A reg = screen + i
M = -1        // Value @a = 11111...11, fill that 16 bit segment

@i
M=M+1         //i++  

@FILL
0;JMP         //Jump back up to FILL to fill next segment


//Screen is now full, wait until key is no longer pressed before proceeding
(STAYFILLED)
@KBD 
D=M
@STAYFILLED
D; JNE       //if KBD != 0 Goto STAYFILLED

//Reset i counter to 0
@i
M=0 

//Use same logic as fill to clear screen
(CLEAR)
@i
D=M
@SCREEN 
D=D+A
@KBD
D = A - D
@STAYCLEAR
D;JLE       //Jump back to top if screen is full

@SCREEN
D=A
@i 
A = D + M 
M = 0     // Value @a = 0000...00, clear segment

@i
M=M+1

@CLEAR
0;JMP 

(END)
@END
0;JMP