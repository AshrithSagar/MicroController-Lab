# Experiment-1

## Examples

### Example-1

```assembly
MOV A, #55H		; USES AN IMMEDIATE DATA
MOV R0, A		; COPY FROM THE ACCUMULATOR
MOV R1, A 		; COPY FROM THE ACCUMULATOR
MOV R2, A 		; COPY FROM THE ACCUMULATOR
MOV R3, #99H 	; USES AND IMMEDIATE DATA AS WELL
MOV R3, A 		; COPY FROM THE ACCUMULATOR
END
```

### Example-2

```assembly
MOV R5, #0AH	; USES AN IMMEDIATE DATA
MOV R7, #28		; USES AN IMMEDIATE DATA. BUT NOT HEXADECIMAL
MOV A, #00H		; USES AN IMMEDIATE DATA AS WELL
ADD A, R5		; ADD TO THE ACCUMULATOR
ADD A, R7		; ADD TO THE ACCUMULATOR
END
```

### Example-3

```assembly
ORG 5000H
DATA1:	DB	28			; DEFINE A SINGLE BYTE WITH DECIMAL DATA
DATA2:	DB	00111010B	; DEFINE A SINGLE BYTE WITH BINARY DATA
DATA3:	DB	39H			; DEFINE A SINGLE BYTE WITH HEXADECIMAL DATA

ORG 510H
DATA4:	DB	"2591"		; DEFINE A SERIES OF BYTES AS STRING TO ASCII

ORG 518H
DATA6:	DB	"MANIPAL INSTITUTE"	; DEFINE A SERIES OF BYTES AS STRING TO ASCII

END
```

### Example-4

```assembly
MOV R0, #99H	; USES AN IMMEDIATE DATA. JUST MOVE AROUND
MOV R1, #85H	; USES AN IMMEDIATE DATA. JUST MOVE AROUND
MOV R2, #3FH	; USES AN IMMEDIATE DATA. JUST MOVE AROUND
MOV R7, #63H	; USES AN IMMEDIATE DATA. JUST MOVE AROUND
MOV R5, #12H	; USES AN IMMEDIATE DATA. JUST MOVE AROUND
END
```

### Example-5

```assembly
MOV R0, #99H	; JUST MOVE AROUND
MOV R1, #85H	; JUST MOVE AROUND
MOV R2, #3FH	; JUST MOVE AROUND
MOV R7, #63H	; JUST MOVE AROUND
MOV R5, #12H	; JUST MOVE AROUND
MOV R6, #25H	; JUST MOVE AROUND
MOV R1, #12H	; JUST MOVE AROUND
MOV R4, #0F3H	; JUST MOVE AROUND. PREFIX A 0 WHEN HEXADECIMAL STARTS WITH AN ALPHANUMERIC.
PUSH 6			; PUSH R6 TO THE NEXT POSITION, WHICH IS POSITION 8. SP IS INCREMENTED
PUSH 1			; PUSH R1 TO THE NEXT POSITION, WHICH IS POSITION 9. SP IS INCREMENTED
END
```

### Example-6

```assembly
MOV A, #47H		; DECIMAL ADDITION
MOV B, #25H
ADD A, B
DA A
```

### Example-7

```assembly
CLR C 			; CLEAR CARRY
MOV A, #3FH 	; DATA (3FH) INTO ACCUMULATOR
MOV R3, #23H 	; COPY (23H) INTO R3
SUBB A, R3 		; (A) - (R3) => (A)
```

### Example-8

```assembly
MOV A, #25H 		; DATA (25H) INTO ACCUMULATOR
MOV 0F0H, #65H 		; DATA (65H) INTO REG.B
MUL AB 				; A × B = A : B
```

### Example-9

```assembly
MOV A, #95H 		; DATA (95H) INTO ACCUMULATOR
MOV 0F0H, #10H 		; DATA (10H) INTO REG.B
;(DIRECT ADDRESSING MODE)
DIV AB 				; A ÷ B → A : B (QQ:RR)
```

### Example-10

```assembly
MOV A, #44H	 	; LOAD DATA (44H) INTO THE ACCUMULATOR
MOV P1, A 		; TRANSFER DATA FROM ACCUMULATOR TO PORT 1
MOV P2, A 		; TRANSFER DATA TO PORT 2
```

### Example-11

```assembly
MOV R0, #30H 		; SOURCE POINTER
MOV R1, #50H 		; DESTINATION POINTER
MOV R3, #10 		; COUNTER
BACK: MOV A, @R0 	; GET A BYTE FROM SOURCE
MOV @R1, A 			; COPY IT TO DESTINATION
INC R0 				; INCREMENT SOURCE POINTER
INC R1 				; INCREMENT DESTINATION POINTER
DJNZ R3, BACK		; REPEAT FOR ALL 10 BYTES
```
