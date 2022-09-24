; Roll “SPICE” continuously (a) left side (b) right side.

; 8050H:
; 00 D6 37 60 93 97 00 D6 37 60 93 97 D6 37 60 93 97

START:
	CLR D5H
	MOV DPTR, #8050H
	LCALL OUTPUT
	LCALL DELAY
	