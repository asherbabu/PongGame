STACK SEGMENT PARA STACK
    DB 64 DUP(' ')
STACK ENDS

DATA SEGMENT PARA 'DATA'
DATA ENDS

CODE SEGMENT PARA 'CODE'

    MAIN PROC FAR
    
        MOV AH, 00h   ; set the configuration to video mode
        MOV AL, 13h   ; choose videomode
        INT 10h       ; execute the configuration

        MOV AH, 0bh   ; set the configuration to the background color
        MOV BH, 00h   ; to the background color
        MOV BL, 00h   ; choosing background color
        INT 10h       ; executing the configuration
        
        RET           ; Return from procedure
    MAIN ENDP

CODE ENDS
END

