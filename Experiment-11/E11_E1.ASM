; Display BIO-LOGIC (as bIO-LOGIC) in the seven segment display interface.

; Assume the trainer is connected over J2 of the trainer.
; The trainer is set to KEYBOARD MODE.

START:
	MOV P2, #0E8H
	MOV R0, #03H
	MOV A, #80H
	MOVX @R0, A

UP1:
	MOV DPTR, #8100H
	MOV R3, #04H

NXT_GRP:
	MOV R1, #04H

NXT_CHAR:
	MOV R2, #08H
	CLR A
	MOVC A, @A+DPTR
	INC DPTR
	MOV R4, A

UP:
	RL A
	MOV R4, A
	MOV R0, #01
	MOVX @R0, A
	INC R0
	MOV A, #01
	MOVX @R0, A
	DEC A
	MOVX @R0, A
	MOV A, R4
	DJNZ R2, UP
	DJNZ R1, NXT_CHAR
	MOV R7, #64H

RPT:
	MOV TMOD, #10H
	MOV TH1, #00H
	MOV TL1, #00H
	SETB TR1

HERE:
	JNB TF1, HERE
	CLR TF1
	CLR TR1
	DJNZ R7, RPT
	DJNZ R3, NXT_GRP
	SJMP UP1
