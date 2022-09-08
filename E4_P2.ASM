; Set the carry flag to 0 if the number in 
; accumulator is even, else reset the carry flag.

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:	
	

HERE:
	SJMP HERE			; LOGICAL END
	END
