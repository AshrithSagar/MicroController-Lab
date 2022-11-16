; Generate a saw tooth waveform.

START:
	MOV P2, #E8H
	MOV R0, #03H
	MOV A, #80H
	MOVX @R0, A
	CLR A
	MOV R0, A

UP:
	MOVX @R0, A
	INC A
	SJMP UP
