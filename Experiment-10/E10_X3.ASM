; Input two 2-digit HEX numbers from logic controller interface through
; port B of 8255 and display their product in the address field of the display.

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:	
	

HERE:
	SJMP HERE			; LOGICAL END
	END
