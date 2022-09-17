; Realize a 2-digit decimal down counter which counts down from 90 to 30 and
; then repeats. Display each count in the data field of the display for 0.5 sec.

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:
	MOV A, #90H 		; INITIALISE

ITER:
	

	MOV 60H, A 			; COPY DATA TO DISPLAY PLACEHOLDERS
	LCALL UPDDT 		; DISPLAY PROGRAM
	LCALL DELAY 		; AWAIT 0.5 SECONDS
	
	SJMP ITER 			; REPEAT IN A LOOP

DELAY:
	; AWAIT (08H*0FAH*0FAH) MACHINE CYCLES => 0.5 SECONDS
	MOV R3, #08H
	UP1:
		MOV R4, #0FAH
		UP2:
			MOV R5, #0FAH
		DJNZ R4, UP2
	DJNZ R3, UP1

	RET 				; RETURN BACK TO THE MAIN LOOP
	END
