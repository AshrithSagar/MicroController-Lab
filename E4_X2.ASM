; Assuming R1:R0 registers as an 16 bit register rotate the 
; content of this register left such that bit-7 of R0 becomes 
; bit 0 of R1 and bit-7 of R1 becomes bit-0 of R0.

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:
	MOV R0, #34H 		; INPUT LOWER BYTE
	MOV R1, #12H 		; INPUT HIGHER BYTE
	
	RLC A
	
HERE:
	SJMP HERE			; LOGICAL END
	END
