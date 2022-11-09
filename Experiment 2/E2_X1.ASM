; Find the difference of two 2-digit BCD numbers available 
; in R1 and R2 and store the result in location 2000h.

ORG 0000H		; ORIGINATE
AJMP START		; JUMP TO THE LABEL START

START:
	MOV A, R2
	CPL A
	ADDC A, R1
	DA A
	
	JNC STORE	; JUMP ON NO CARRY TO THE LABEL STORE

CONVERT:
	MOV R0, A
	MOV A, #00H
	SUBB A, R0

STORE:
	MOV DPTR, #2000H
	MOVX @DPTR, A
	END
