; Input a single digit decimal number from the keyboard. 
; If the number is 1, then light two LED’s, if the number is 2, 
; then light four LED’s, if the number is 3, then light six LED’s, 
; if the number is 4, then light eight LED’s. Neglect all other numbers.

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:	
	

HERE:
	SJMP HERE			; LOGICAL END
	END
