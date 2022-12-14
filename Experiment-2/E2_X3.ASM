; Multiply two 16-bit hex numbers and store the product.

; ASSUME THE NUMBERS ARE STORED IN EXTERNAL LOCATION 1000H TO 1003H
; WILL STORE THE PRODUCT IN R4, R5, R6, R7

ORG 0000H				; ORIGINATE
AJMP START				; JUMP TO THE LABEL START

START:
	CLR C 				; CLEAR CARRY
	MOV R3, #00H 		; CLEAR R3
	MOV R4, #00H 		; CLEAR R4
	MOV R5, #00H 		; CLEAR R5
	MOV R6, #00H 		; CLEAR R6
	MOV R7, #00H 		; CLEAR R7

	MOV DPTR, #1000H	; LSB_1
	MOVX A, @DPTR 		; GET EXTERNAL DATA
	MOV 0F0H, A 		; COPY IN B
	MOV DPTR, #1002H	; LSB_2
	MOVX A, @DPTR 		; GET EXTERNAL DATA
	MUL AB 				; LSB_1 TIMES LSB_2
	MOV R4, A  			; LSB OF CURRENT PRODUCT
	MOV A, B 			; COPY TO A
	MOV R5, A 			; MSB OF CURRENT PRODUCT

	MOV DPTR, #1001H	; MSB_1
	MOVX A, @DPTR 		; GET EXTERNAL DATA
	MOV 0F0H, A 		; COPY IN B
	MOV DPTR, #1002H	; LSB_2
	MOVX A, @DPTR 		; GET EXTERNAL DATA
	MUL AB 				; MSB_1 TIMES LSB_2
	ADD A, R5  			; LSB OF CURRENT PRODUCT
	MOV R5, A 			; STORE THE PRODUCT
	MOV A, B 			; COPT TO A
	ADDC A, R6 			; MSB OF CURRENT PRODUCT. R6 IS 00H
	MOV R6, A 			; STORE THE PRODUCT

	MOV DPTR, #1000H	; LSB_1
	MOVX A, @DPTR 		; GET EXTERNAL DATA
	MOV 0F0H, A 		; COPY IN B
	MOV DPTR, #1003H	; MSB_2
	MOVX A, @DPTR 		; GET EXTERNAL DATA
	MUL AB 				; LSB_1 TIMES MSB_2
	ADD A, R5  			; LSB OF CURRENT PRODUCT
	MOV R5, A 			; STORE THE PRODUCT
	MOV A, B 			; COPY TO A
	ADDC A, R6 			; MSB OF CURRENT PRODUCT
	MOV R6, A 			; STORE THE PRODUCT

	JNC NOCARR
	INC R3 				; INCREMENT IF CARRY

NOCARR:	
	MOV DPTR, #1001H	; MSB_1
	MOVX A, @DPTR 		; GET EXTERNAL DATA
	MOV 0F0H, A 		; COPY IN B
	MOV DPTR, #1003H	; MSB_2
	MOVX A, @DPTR 		; GET EXTERNAL DATA
	MUL AB 				; MSB_1 TIMES MSB_2
	ADD A, R6  			; LSB OF CURRENT PRODUCT
	MOV R6, A 			; STORE THE PRODUCT
	MOV A, B 			; COPY TO A
	ADDC A, R7 			; MSB OF CURRENT PRODUCT. R7 IS 00H
	ADD A, R3 			; ADD CARRY FROM PREVIOUS STEP, IN CASE
	MOV R7, A 			; STORE THE PRODUCT

	END
