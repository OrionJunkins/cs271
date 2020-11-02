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

// Put your code here.

(LOOP)
@KBD
D=M
@LOOP
D;JEQ //if KBD == 0 Goto loop


@i
M=0 //set i = 0

@KBD
D=A 
@n 
M=D  // Set n = KBD 

(FILL)
@i
D=M
@SCREEN 
D=D+A
@KBD
D = A - D
@STAYFILLED
D;JLE


@SCREEN
D=A
@i 
A = D + M  //Set A reg = screen + i
M = -1 // Value @a = 11111...11

@i
M=M+1 //i++

@FILL
0;JMP


(STAYFILLED)
@KBD 
D=M
@STAYFILLED
D; JNE  //if KBD != 0 Goto STAYFILLED


//goto Loop

@i
M=0 //reset i = 0

(CLEAR)
@i
D=M
@SCREEN 
D=D+A
@KBD
D = A - D
@LOOP
D;JLE


@SCREEN
D=A
@i 
A = D + M  //Set A reg = screen + i
M = 0 // Value @a = 0000...00

@i
M=M+1 //i++

@CLEAR
0;JMP

(END)
@END
0;JMP