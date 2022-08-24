; Find the sum of ten 16 –bit hexadecimal numbers available in memory
; starting from location XX10h. store the result in XX50h onwards.

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:
	MOV DPTR, #1010H	;
	MOV R1, #10

UP:
	MOV A, @DPTR
	MOV 0F0H, A
	ADDC A, B
	INC DPTR
	DJNZ R1, UP

STORE:
	MOV DPTR, #1050H
	MOV @DPTR, A

HERE:
	SJMP HERE			; LOGICAL END
	END
