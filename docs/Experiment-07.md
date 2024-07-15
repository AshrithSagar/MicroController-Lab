# Experiment-7

## Exercises

### Exercise-1

```assembly
; Input two 2-digit HEX numbers from the keyboard. Display each
; number in the data field and when NEXT key is pressed display
; their product in the address field of the display.

; BIG ENDIAN CONVENTION FOR INPUTS,
; OUTPUT IN LITTLE ENDIAN

START:
	MOV R7, #02H 			; 7F 02 	; NUMBER OF INPUTS

INPUT:
	LCALL RDKBD 			; 12 02 A2 	; READ FIRST NIBBLE
	SWAP A 					; C4 		; SWAP FOR PACKING
	MOV B, A 				; F5 F0 	; SAVE IN REG (B)
	LCALL RDKBD 			; 12 02 A2 	; READ SECOND NIBBLE
	ORL A, B 				; 45 F0 	; PACK THE NUMBER
	PUSH ACC 				; C0 E0 	; SAVE A COPY OF THE INPUT IN STACK
	MOV 60H, A 				; F5 60 	; DISPLAY PLACEHOLDER
	MOV B, #00H 			; 75 F0 00 	; NO DOT IN DISPLAY; F0 00, NOT 00 F0
	LCALL UPDDT	 			; 12 01 9B 	; DISPLAY IN DATA FIELD

	DJNZ R7, INPUT 			; DF _E9	; TAKE TWO INPUTS

	LCALL RDKBD 			; 12 02 A2 	; READ FOR NEXT KEYPRESS
	CJNE A, #14H, START 	; B4 14 _E1 ; REPEAT PROGRAM, IF NOT PRESSED NEXT KEY

	POP ACC					; D0 E0 	; GET SECOND NUMBER
	MOV B, A				; F5 F0 	; LOAD IN REG (B)
	POP ACC 				; D0 E0 	; GET FIRST NUMBER
	MUL AB 					; A4 		; MULTIPLY THE INPUTS

	MOV 60H, A 				; F5 60 	; FOR DISPLAYING LOWER NIBBLE OF PRODUCT
	MOV 61H, B				; 85 F0 61 	; FOR DISPLAYING UPPER NIBBLE OF PRODUCT
	MOV B, #00H 			; 75 F0 00 	; NO DOT IN DISPLAY
	LCALL CLEAR 			; 12 01 70 	; CLEAR UTILITY ROUTINE
	LCALL UPDAD				; 12 02 0B 	; DISPLAY IN ADDRESS FIELD

	LJMP START 				; 12 80 00 	; REPEAT THE PROGRAM

RDKBD:
	RET
UPDDT:
	RET
UPDAD:
	RET
```

### Exercise-2

```assembly
; Input a 4-digit HEX address of a memory location from
; the keyboard and display its content in the data field
; of the display when “NEXT” key is pressed.

; LITTLE ENDIAN CONVENTION

START:
	MOV R0, #04H 				; 78 04 	; REPEAT COUNT
	INPUT:
		LCALL RDKBD 	 		; 12 02 A2 	; READ KEYBOARD
		PUSH ACC  				; C0 E0 	; SAVE INPUT CHARACTER
		DJNZ R0, INPUT 			; D8 _F9 	; REPEAT IN A LOOP

		LCALL RDKBD				; 12 02 A2 	; CHECK FOR NEXT KEY PRESS
		CJNE A, #14H, START 	; B4 14 _F1	; BREAK OUT IF NEXT KEY NOT PRESSED

	MOV R0, #83H 				; 78 83 	; TO PACK DATA TO (DPH, DPL)
	PACK:
		POP ACC  				; D0 E0 	; GET HIGHER NIBBLE
		SWAP A 					; C4 		; SWAP TO ALLOW FOR PACKING DATA
		MOV @R0, A 				; F6 		; MOVE TO DESTINATION (DP_)

		POP ACC 				; D0 E0 	; GET LOWER NIBBLE
		ORL A, @R0				; 46 		; PACK THE DATA, STORE IN ACCUMULATOR
		MOV @R0, A 				; F6	 	; MOVE TO DESTINATION (DP_)

		DEC R0 					; 18 		; DECREMENT TO POINT TO PREVIOUS ADDRESS
		CJNE @R0, #81H, PACK 	; B6 81 _F4	; CHECK IF DONE TWICE? FOR (DPH, DPL)

	MOVX A, @DPTR 				; E0 		; GET DATA FROM INPUTTED LOCATION
	MOV 60H, A 					; F5 60  	; DISPLAY PLACEHOLDER
	LCALL UPDDT 				; 12 01 9B 	; DISPLAY ROUTINE

RDKBD:
	RET
UPDDT:
	RET
```

### Exercise-3

```assembly
; Write an assembly language program to flash “SPICE” only
; 10 times (display SPICE for 2 sec and blank for 1 sec).

; 8050H:
; 37 60 93 97 00 00 D6

; 8000H:
MOV R0, #0AH 				; 78 0A 	; REPEAT COUNT
ITER:
	CLR PSW.5 				; C2 D5 	; LOAD FROM CODE MEMORY
	MOV DPTR, #8050H 		; 90 80 50 	; STARTING LOCATION OF THE LOOK-UP TABLE
	LCALL OUTPUT 			; 12 02 55 	; OUTPUT UTILITY ROUTINE
	; DELAY FOR 2 SECONDS
	LCALL DELAY 			; 12 _A0 00
	LCALL DELAY 			; 12 _A0 00

	LCALL CLEAR 			; 12 01 70 	; CLEAR UTILITY ROUTINE
	LCALL DELAY 			; 12 _A0 00 ; DELAY FOR 1 SECOND

	DJNZ R0, ITER 			; D8 _EA	; REPEAT IN A LOOP

	LCALL 0000H 			; 12 00 00 	; STOP EXECUTION

; A000H:
DELAY:
	; AWAIT (10H*0FAH*0FAH) MACHINE CYCLES => 1 SECOND
	MOV R3, #10H 			; 7B 10
	UP1:
		MOV R4, #0FAH 		; 7C FA
		UP2:
			MOV R5, #0FAH 	; 7D FA
		DJNZ R4, UP2 		; DC _FC
	DJNZ R3, UP1 			; DB _F8
	RET 					; 22 		; RETURN BACK TO THE MAIN LOOP

CLEAR:
	RET
OUTPUT:
	RET
```

### Exercise-4_1

```assembly
; Roll “SPICE” continuously (a) left side (b) right side.

; 8050H:
; 37 60 93 97 00 00 D6

; 8000H:
START:
	SETB PSW.5 				; D2 D5 	; LOAD FROM EXTERNAL DATA MEMORY
	MOV DPTR, #8050H 		; 90 80 50 	; STARTING LOCATION OF THE LOOK-UP TABLE
	LCALL OUTPUT 			; 12 02 55 	; OUTPUT UTILITY ROUTINE
	LCALL DELAY 			; 12 _A0 00	; AWAIT

	MOV DPTR, #8050H 		; 90 80 50 	; STARTING LOCATION OF THE LOOK-UP TABLE
	MOVX A, @DPTR 			; E0 		; GET STARTING DATA, FOR LEFT ROTATE CASE
	MOV B, A 				; F5 F0 	; SAVE IN REG (B)

	MOV R0, #07H 			; 78 07 	; REPEAT FOR 7 BYTES

LEFT:
	INC DPTR 				; A3 		; GO TO NEXT LOCATION
	MOVX A, @DPTR 			; E0 		; GET DATA FROM NEXT LOCATION
	PUSH ACC 				; C0 E0 	; SAVE A COPY OF THE DATA IN STACK

	; DECREMENT DATA POINTER AND GO TO CURRENT LOCATION
	CLR C 					; C3 		; CLEAR CARRY
	MOV A, 82H 				; E5 82  	; GET (DPL)
	SUBB A, #01H 			; 94 01 	; INCREMENT (DPL)
	MOV 82H, A 				; F5 82 	; SAVE (DPL)

	MOV A, 83H 				; E5 83 	; GET (DPH)
	ADDC A, #00H 			; 34 00 	; ADD CARRY TO (DPH)
	MOV 83H, A 				; F5 83 	; SAVE (DPH)

	POP ACC					; D0 E0 	; GET SAVED DATA
 	MOVX @DPTR, A 			; F0 		; COPY DATA TO CURRENT LOCATION

 	INC DPTR 				; A3 		; UPDATE TO NEXT LOCATION
	DJNZ R0, LEFT 			; D8 _E9 	; REPEAT FOR ALL IN THE LOOK-UP TABLE

	MOV DPTR, #8056H 		; 90 80 56 	; LAST LOCATION OF THE LOOK-UP TABLE
	MOV A, B 				; E5 F0 	; GET STORED FIRST LOCATION DATA
	MOVX @DPTR, A 			; F0 		; STORE FIRST DATA IN LAST LOCATION

	LJMP START 				; 02 80 00 	; REPEAT IN A LOOP

; A000H:
DELAY:
	; AWAIT (10H*0FAH*0FAH) MACHINE CYCLES => 1 SECOND
	MOV R3, #10H 			; 7B 10
	UP1:
		MOV R4, #0FAH 		; 7C FA
		UP2:
			MOV R5, #0FAH 	; 7D FA
		DJNZ R4, UP2 		; DC _FC
	DJNZ R3, UP1 			; DB _F8
	RET 					; 22 		; RETURN BACK TO THE MAIN LOOP

OUTPUT:
	RET
```

### Exercise-4_2

```assembly
; Roll “SPICE” continuously (a) left side (b) right side.

; 8050H:
; 37 60 93 97 00 00 D6

; 8000H:
START:
	SETB PSW.5 				; D2 D5 	; LOAD FROM EXTERNAL DATA MEMORY
	MOV DPTR, #8050H 		; 90 80 50 	; STARTING LOCATION OF THE LOOK-UP TABLE
	LCALL OUTPUT 			; 12 02 55 	; OUTPUT UTILITY ROUTINE
	LCALL DELAY 			; 12 _A0 00	; AWAIT

	MOV DPTR, #8056H 		; 90 80 50 	; LAST LOCATION OF THE LOOK-UP TABLE
	MOVX A, @DPTR 			; E0 		; GET STARTING DATA, FOR LEFT ROTATE CASE
	MOV B, A 				; F5 F0 	; SAVE IN REG (B)

	MOV R0, #07H 			; 78 07 	; REPEAT FOR 7 BYTES

RIGHT:
	LCALL DEC_DPTR			; 12 90 00 	; DECREMENT DATA POINTER AND GO TO PREVIOUS LOCATION

	MOVX A, @DPTR 			; E0 		; GET DATA FROM NEXT LOCATION
	INC DPTR 				; A3 		; GO TO NEXT LOCATION
 	MOVX @DPTR, A 			; F0 		; COPY DATA TO CURRENT LOCATION

 	LCALL DEC_DPTR 			; 12 90 00 	; UPDATE TO CURRENT LOCATION
	DJNZ R0, RIGHT 			; D8 _F5 	; REPEAT FOR ALL IN THE LOOK-UP TABLE

	MOV DPTR, #8050H 		; 90 80 56 	; STARTING LOCATION OF THE LOOK-UP TABLE
	MOV A, B 				; E5 F0 	; GET STORED FIRST LOCATION DATA
	MOVX @DPTR, A 			; F0 		; STORE FIRST DATA IN LAST LOCATION

	LJMP START 				; 02 80 00 	; REPEAT IN A LOOP

; 9000H
DEC_DPTR:
	PUSH ACC 				; C0 E0 	; SAVE ACCUMULATOR

	CLR C 					; C3 		; CLEAR CARRY
	MOV A, 82H 				; E5 82  	; GET (DPL)
	SUBB A, #01H 			; 94 01 	; INCREMENT (DPL)
	MOV 82H, A 				; F5 82 	; SAVE (DPL)

	MOV A, 83H 				; E5 83 	; GET (DPH)
	ADDC A, #00H 			; 34 00 	; ADD CARRY TO (DPH)
	MOV 83H, A 				; F5 83 	; SAVE (DPH)

	POP ACC 				; D0 E0 	; RETRIEVE ACCUMULATOR
	RET

; A000H:
DELAY:
	; AWAIT (10H*0FAH*0FAH) MACHINE CYCLES => 1 SECOND
	MOV R3, #10H 			; 7B 10
	UP1:
		MOV R4, #0FAH 		; 7C FA
		UP2:
			MOV R5, #0FAH 	; 7D FA
		DJNZ R4, UP2 		; DC _FC
	DJNZ R3, UP1 			; DB _F8
	RET 					; 22 		; RETURN BACK TO THE MAIN LOOP

OUTPUT:
	RET
```
