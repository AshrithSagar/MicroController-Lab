; Program timer 1 to generate the square wave of 1 KHz.
; Assume crystal frequency is 11.0592 MHz


ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:	
	

HERE:
	SJMP HERE			; LOGICAL END
	END
