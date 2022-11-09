; Add two 4-digit BCD numbers available in memory external 
; data memory and store the result in internal RAM location 00h.

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:	
	

HERE:
	SJMP HERE			; LOGICAL END
	END
