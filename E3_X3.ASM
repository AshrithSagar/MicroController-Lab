; Transfer ten elements of an array starting at location XX40h 
; in external data memory to a location XX45 in the same memory

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:
	MOV DPTR, #1049H
	MOV A, @DPTR
	MOV R0, #10
	

UP:


END
