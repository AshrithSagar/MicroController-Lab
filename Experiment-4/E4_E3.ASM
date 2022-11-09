; Assuming that clock pulses fed into pin T1, write a program 
; for counter 1 in mode2 to count the pulses and display the 
; state of the TL1 count on P2.

ORG 0000H					; ORIGINATE
AJMP START					; JUMP TO THE LABEL START

START:
	MOV TMOD, #01100000B 	; SET COUNTER IN MODE-2: AUTO RELOAD MODE
	MOV TH1, #00 			; RESET TH1
	SETB P3.5 				; ENABLE T1 AS INPUT, FOR THE COUNTER

AGAIN:
	SETB TR1 				; START THE TIMER-1

BACK:
	MOV A, TL1
	MOV P2, A 				; UPDATE (P2) EVERTIME WITH (TL1)
	JNB TF1, BACK 			; WAIT UNTIL TIMER OVERFLOWS
	
	; RESET TIMER-1
	CLR TR1
	CLR TF1
	
	SJMP AGAIN 				; REPEAT IN A LOOP
	END
