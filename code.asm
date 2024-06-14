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
        MOV BL, 01h   ; choosing background color
        INT 10h       ; executing the configuration

        MOV AH, 0Ch   ; set the configuration to write a pixel
        MOV AL, 0Fh   ; choose color
        MOV BH, 00h   ; set the page number 
        MOV CX, 0Ah   ; set the column (X)
        MOV DX, 0Ah   ; set the line (Y)
        INT 10h       ; execute configuration

        RET           ; Return from procedure
    MAIN ENDP

CODE ENDS
END

