; Perform the logical AND operation of two 8-bit data 
; available in R0 and R1 and output the result 
to port2.

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START: 	MOV R1, #23H
		MOV R0, #0AAH
		MOV A, R0
		ANL A, R1
		MOV P2, A

HERE:	SJMP HERE
		END
