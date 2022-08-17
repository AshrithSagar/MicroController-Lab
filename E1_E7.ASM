CLR C ; clear carry
MOV A, #3FH ; data 3Fh into A
MOV R3, #23H ; copy 23h into R3
SUBB A, R3 ; A-R3 = A