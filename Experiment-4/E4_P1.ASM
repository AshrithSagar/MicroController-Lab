; Implement a 16 - bit down counter.
; [INCOMPLETE]

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:
	MOV R6, #0FFH	 	; LOWER BYTE REGISTER
	MOV R7, #0FFH 		; UPPER BYTE REGISTER

ITER:
	MOV A, R6			; GET CURRENT LOWER BYTE
	CLR C				; CLEAR CARRY
	SUBB A, #01H		; DECREMENT
	MOV R6, A 			; SAVE BACK

	MOV A, R7			; GET CURRENT UPPER BYTE
	CLR C				; CLEAR CARRY
	SUBB A, #01H		; DECREMENT
	MOV R6, A 			; SAVE BACK

HERE:
	SJMP HERE			; LOGICAL END
	END
