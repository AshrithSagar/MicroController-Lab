; Generate a square (Calibration signal) waveform and display it on the oscilloscope.

; Assume the interface is connected over J2 of the trainer.
; The trainer kit set in Keyboard mode.
; Port A, B, and C are set as output ports

START:
	MOV P2, #E8H 			; Initialize 8255 for mode 0
	MOV R0, #03 			; Port A and B as O/P ports
	MOV A, #80H
	MOVX @R0, A

UP:
	CLR A 					; A = 00H
	MOV R0, A
	MOVX @R0, A 			; Data to DAC1
	LCALL DELAY 			; 1 mS Delay
	CPL A 					; A = FFH
	MOVX @R0, A 			; Data to DAC1
	LCALL DELAY 			; 1 mS Delay
	SJMP UP 				; Repeat the cycle.
