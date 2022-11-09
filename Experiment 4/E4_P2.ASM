; Set the carry flag to 0 if the number in 
; accumulator is even, else reset the carry flag.

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:	
	MOV A, #06H 		; INPUT
	
	MOV B, #02H 		; DIVISION BY 2
	DIV AB 				; DIVIDE ACCUMULATOR BY 2
	
	CJNE B, #00H, ODD 	; CHECK FOR ODD BY REMAINDER

	; NUMBER IS EVEN
	CLR C 				; CLEAR CARRY
	SJMP HERE 			; END THE PROGRAM

ODD:
	SETB C 				; SET CARRY FLAG

HERE:
	SJMP HERE			; LOGICAL END
	END
