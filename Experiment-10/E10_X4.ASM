; Write an ALP to turn ON alternate LEDs connected to port A for 5 sec.

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:	
	

HERE:
	SJMP HERE			; LOGICAL END
	END
