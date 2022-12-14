; Write a program to find sum of 5bytes available in RAM locations 40h to 45h.
; Store the result in Reg A (low byte) and R7 (high byte).

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:
	MOV R0, #50H		; LOAD THE POINTER
	MOV R2, #06H		; LOAD THE COUNTER
	CLR A				; INITIALIZE

REPEAT:
	ADD A, @R0			; GET THE DATA POINTED BY THE POINTER AND ACCUMULATE
	JNC NEXT			; JUMP TO LABEL NEXT IF NO CARRY
	INC R7				; INCREMENT THE CARRY IN R7

NEXT:
	INC R0				; INCREMENT THE SUM
	DJNZ R2, REPEAT		; REPEAT TILL THE COUNTER IS 0
	END
