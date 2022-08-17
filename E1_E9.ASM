MOV A, #95H ; data 95h into A 
MOV 0F0H, #10H ; data 10H into B 
;(direct addressing mode)
DIV AB ; A÷B→A:B (QQ:RR)