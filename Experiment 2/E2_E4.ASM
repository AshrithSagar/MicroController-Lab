; Perform division of two numbers. The numbers are available
; in 2000h and 2001h data memory. After division operation,
; store the result in 200Ah and 200Bh.

ORG 0000H					; ORIGINATE
AJMP START					; JUMP TO THE LABEL START

START:
	MOV DPTR, #2001H
	MOVX A, @DPTR
	MOV B, A

	MOV DPTR, #2000H
	MOVX A, @DPTR
	DIV AB

	MOV DPTR, #200AH
	MOVX @DPTR, A

	INC DPTR
	MOV A, 0F0H
	MOVX @DPTR, A

HERE:
	SJMP HERE 			; LOGICAL END
	END
