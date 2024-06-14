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
        
        RET           ; Return from procedure
    MAIN ENDP

CODE ENDS
END

