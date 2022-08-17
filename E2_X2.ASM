; Add two 32-bit numbers available in memory locations starting 
; from 3050h and store the result from memory location 3080h.

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:
	MOV DPTR, #3050H
	MOVX A, @DPTR

	MOV R0, #00H
	ADDC R0, A

	INC DPTR
	MOVX A, @DPTR

STORE:
	MOV DPTR, #3080H
	MOV @DPTR, A
	MOV A, B
	INC DPTR
	MOV @DPTR, A
	