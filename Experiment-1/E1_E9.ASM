MOV A, #95H 		; DATA (95H) INTO ACCUMULATOR
MOV 0F0H, #10H 		; DATA (10H) INTO REG.B
;(DIRECT ADDRESSING MODE)
DIV AB 				; A ÷ B → A : B (QQ:RR)
