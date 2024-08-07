; Perform mathematical operations: ADD, MULTIPLY and SUBTRACT.
; Connect the keyboard to J2 of the trainer
; Set the trainer in to KEYBOARD MODE
; Configure Port A as Input and Port C as Output

; Replace #HEX_ADD, #HEX_SUB, #HEX_MUL with their corresponding
; key-codes (HEX) for the checks to work

; 8000H
START:
	MOV R5, #00H 				; FLAG, TO KNOW FIRST/SECOND OPERAND

BEGIN:
	MOV DPTR, #E803H 			; ADDRESS OF (J2) CONTROL REG
	; SET ALL PORTS AS INPUTS; PORT_A IN INPUT MODE
	MOV A, #90H 				; CONTROL CODE
	MOVX @DPTR, A 				; SET CONTROL REGISTER WITH THE CODE
	MOV A, #07H 				; TO SEND HIGH ON ALL ROWS
	DEC 82H 					; DEC DPTR
	MOVX @DPTR, A 				; WRITE TO ~PORT_C
	MOV 82H, #00H 				; GO TO PORT_A

WAIT1:
	MOVX A, @DPTR 				; GET PORT_A INPUT TO ACCUMULATOR
	; CHECK ALL KEYS RELEASED?
	JNZ WAIT1 					; REPEAT UNTILL NON-ZERO INPUT GIVEN
	LCALL DBOUNCE 				; AWAIT DEBOUNCE KEYBOARD

WAIT2:
	MOVX A, @DPTR 				; READ PORT_A FOR COLUMNS
	JZ WAIT2 					; CHECK ANY KEY PRESSED?
	LCALL DBOUNCE 				; AWAIT DEBOUNCE KEYBOARD
	MOV R0, #00H 				; INITIAL KEY CODE
	MOV R1, #03H 				; THE NUMBER OF ROWS
	MOV R2, #80H 				; TO SEND HIGH TO THE ROWS; INITIAL VALUE

NXT_ROW:
	MOV DPTR, #E802H 			; ADDRESS OF PORT_C
	MOV A, R2 					; GET HIGH CODE TO ACCUMULATOR
	RL A 						; ROTATE LEFT TO GO TO THE NEXT ROW
	MOV R2, A 					; SAVE IN (R2)
	MOVX @DPTR, A 				; WRITE IN PORT_C
	MOV DPL, #00H 				; GO TO PORT_A
	MOVX A, @DPTR 				; GET PORT_A INPUT
	JNZ FOUND 					;
	MOV A, R0 					;
	ADD A, #08H 				;
	MOV R0, A 					;
	DJNZ R1, NXT_ROW 			;
	LJMP BEGIN 					; EXIT AND BEGIN AGAIN

; DECRPYT ONE-HOT ENCODING
FOUND:
	RRC A
	JC OVER
	INC R0
	SJMP FOUND

OVER:
	MOV 60H, R0 				; DISPLAY PLACEHOLDER
	MOV F0H, #00H 				; NO DOT
	LCALL UPDDT 				; SHOW IN DISPLAY FIELD

; CHECK OPERAND
CHK_OPR:
	CJE R5, #02H, CHK_ADD 		; CHECK IF FIRST & SECOND OPERAND ENTERED?
	; IF SO, THEN PERFORM THE OPERATIONS; ELSE SAVE THE OPERAND

SAVE_OPR:
	CJE R5, #01H, SAVE_SECND 	; CHECK WHETHER TO SAVE FIRST/SECOND OPERAND

SAVE_FIRST:
	MOV R3, R0 					; SAVE FIRST OPERAND IN (R3)
	INC R5 						; INCREMENT FLAG
	LJMP BEGIN					; PROCEED TO GET NEXT INPUT

SAVE_SECND:
	MOV R4, R0 					; SAVE SECOND OPERAND IN (R4)
	INC R5 						; INCREMENT FLAG
	LJMP BEGIN					; PROCEED TO GET NEXT INPUT

CHK_ADD:
	CJNE R0, #HEX_ADD, CHK_SUB 	; CHECK IF ADD? ELSE CHECK SUBTRACT

ADD_NUMS:
	MOV A, R3 					; RETRIEVE FIRST OPERAND
	ADD A, R0					; ADD THE SECOND OPERAND
	LJMP DISPLAY 				; RESULT IN (ACC)

CHK_SUB:
	CJNE R3, #HEX_SUB, CHK_MUL 	; CHECK IF SUBTRACT? ELSE CHECK MULTIPLY

SUB_NUMS:
	MOV A, R3 					; RETRIEVE FIRST OPERAND
	SUBB A, R0					; SUBTRACT SECOND OPERAND FROM FIRST OPERAND
	LJMP DISPLAY 				; RESULT IN (ACC)

CHK_MUL:
	CJNE R3, #HEX_MUL, BEGIN 	; CHECK IF MULTIPLY? ELSE BEGIN

MUL_NUMS:
	MOV F0H, R3 				; RETRIEVE FIRST OPERAND
	MOV A, R0					; RETRIEVE SECOND OPERAND
	MUL AB 						; MULTIPLY
	; FOR SIMPLICITY, ONLY LOWER BYTE (IN ACC) WILL BE DISPLAYED
	; PROCEED FOR DISPLAY

DISPLAY:
	MOV 60H, A 					; DISPLAY PLACEHOLDER
	MOV F0H, #00H 				; NO DOT
	LCALL UPDDT 				; SHOW IN DISPLAY FIELD

	MOV R5, #00H 				; RESET FLAG
	LJMP BEGIN 					; REPEAT ENTIRE PROGRAM AGAIN

DBOUNCE:
	MOV TMOD, #10H 				; TIMER-1 IN MODE_1
	; DELAY OF 20ms
	MOV TH1, #B7H
	MOV TL1, #FFH
	SETB TR1 					; TIMER-1 SET

HERE:
	JNB TF1, HERE 				; WAIT UNTIL TIMER-1 OVERFLOWS
	; RESET TIMER-1
	CLR TF1
	CLR TR1
	RET 						; RETURN BACK TO MAIN LOOP
