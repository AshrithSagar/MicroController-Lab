; Read a single digit hexadecimal number from the memory location
; and generate 7-segment code for the number read and send the 
; code to port1. Assume common-anode seven-segment display.

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:	
	

HERE:
	SJMP HERE			; LOGICAL END
	END
