# Experiment-5

## Exercises

### Exercise-1

```assembly
;  Convert an ASCII code available in external data memory location
; into HEX equivalent and display in the Data field of the display.

ORG 0000H					; ORIGINATE
AJMP START					; JUMP TO THE LABEL START

START:
	MOV DPTR, #5000H 		; DATA LOCATION
	MOVX A, @DPTR 			; GET THE DATA

	CLR C 					; CLEAR CARRY
	SUBB A, #30H 			; SUBTRACT (30H) INITIALLY
	MOV R1, A 				; SAVE A COPY IN (R1)

	SUBB A, #0AH           	; CHECK FOR NUMBER OR ALPHA-NUMERIC CHARACTER

	MOV A, R1 				; GET THE STORED COPY
	
	; IF CARRY ==> INPUT NUMBER IS < 3AH ==> [0-9]
	JC DISP

; IF NO CARRY ==> INPUT NUMBER IS >= 3AH ==> [A-F]
ALPH:
	CLR C 					; CLEAR CARRY AGAIN
	SUBB A, #07H 			; SUBTRACT AN ADDITIONAL (07H)

DISP:
	MOV R0, #60H 			; LOCATION OF THE DISPLAY FIELD
	MOV @R0, A 				; UPDATE THE DATA TO THE LOCATION TO BE DISPLAYED

HERE:
	SJMP HERE				; LOGICAL END
	END
```

### Exercise-1-2

```assembly
;  Convert an ASCII code available in external data memory location
; into HEX equivalent and display in the Data field of the display.

ORG 0000H
AJMP START

START:
	; GET THE DATA FROM EXTERNAL MEMORY
	MOV DPTR, #0000H
	MOVX A, @DPTR

	; SUBTRACT (30H) BY DEFAULT
	CLR C
	SUBB A, #30H

	MOV R1, A 				; MAKE A COPY IN (R1)

	; CHECK IF NUMBER IS [0-9] OR [A-F]
	SUBB A, #0AH

	MOV A, R1 				; RETRIEVE THE STORED COPY

	; IF CARRY ==> NUMBER IS IN [0-9]
	JC DISPLAY

	; IF NO CARRY ==> NUMBER IS IN [A-F]
	; SUBTRACT AN ADDITIONAL (07H)
	CLR C
	SUBB A, #07H

; UPDATE THE KIT DISPLAY WITH THE DATA
DISPLAY:
	MOV R0, #60H
	MOV @R0, A
	; LCALL UPDDT

END
```

