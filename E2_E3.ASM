; Write program to perform multiplication of two numbers.
; Two 8- bit numbers are available in memory location 1000h
; and 1001h. Copy the product into 1002h and 1003h.

ORG 0000H					; ORIGINATE
AJMP START					; JUMP TO THE LABEL START

START:
	MOV DPTR, #1001H
	MOVX A, @DPTR			; READ FROM EXTERNAL MEMORY
	MOV 0F0H, A
	MOV DPTR, #1000H
	MOVX A, @DPTR			; READ FROM EXTERNAL MEMORY
	MUL AB
	MOV DPTR, #1002H
	MOVX @DPTR, A			; WRITE FROM EXTERNAL MEMORY
	INC DPTR
	MOV A, B
	MOVX @DPTR, A			; WRITE FROM EXTERNAL MEMORY
	END
