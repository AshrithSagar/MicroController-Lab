; Find the number of occurrences of data ‘2AH’ in a memory array.
; The last element of the array is ‘3AH’. The array begins at XX30H.
; Store the result in memory location XX80H.

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:
	MOV DPTR, #1030H 	; THE START LOCATION OF THE ARRAY
	CLR C    			; CLEAR THE CARRY

	; INITIALISE WITH #0FFH SINCE UPDATE WILL BE RUN ONCE BY DEFAULT, AFTER WHICH IT'S 00H;
	MOV R1, #0FFH  		; COUNT REGISTER

UPDATE:
	; INCREMENT THE COUNTER
 	INC R1

REPEAT:
	MOVX A, @DPTR   	; GET THE DATA
	SUBB A, #2AH   		; PERFORM A SUBTRACTION TO CHECK FOR #2AH
	INC DPTR    		; INCREMENT TO THE NEXT ARRAY POSITION

	; IF THE DIFFERENCE IS ZERO => DATA IS ACTUALLY #2AH
	JZ UPDATE

	; IF THE DIFFERENCE IS NOT ZERO => CHECK WHETHER TO STOP
	; SUBTRACT AN ADDITIONAL #10H TO CHECK FOR STOP CONDITION
	SUBB A, #10H   		; => EFFECTIVELY SUBTRACTING #3AH FROM DATA

	; REPEAT THE PROCESS IF NOT REACHED THE STOP CONDITION
	JNZ REPEAT

	; STOP CONDITION IS MET; STORE THE FINAL COUNT IN THE DESIRED LOCATION
	MOV A, R1
	MOV DPTR, #1080H
	MOVX @DPTR, A

HERE:
	SJMP HERE   ; LOGICAL END
	END
