STACK SEGMENT PARA STACK
    DB 64 DUP(' ')
STACK ENDS

DATA SEGMENT PARA 'DATA'

    BALL_X DW 0Ah     ; X position column of the ball
    BALL_Y DW 0Ah     ; Y position line of the ball

DATA ENDS

CODE SEGMENT PARA 'CODE'

    MAIN PROC FAR
    ASSUME CS:CODE, DS:DATA, SS:STACK     ; assume as code, data and stack arguments the respective register
    PUSH DS                               ; push to the stack the DS segment
    SUB AX, AX                            ; clean the AX register
    PUSH AX                               ; push AX to the stack
    MOV AX, DATA                          ; DATA segment content saved on the AX register
    MOV DS, AX                            ; AX contents saved on the DX segment
    POP AX                                ; release the top item from the stack to the AX register
    POP AX                                ; release the top item from the stack to the AX register
    
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
        MOV CX, BALL_X   ; set the column (X)
        MOV DX, BALL_Y   ; set the line (Y)
        INT 10h       ; execute configuration

        RET           ; Return from procedure
    MAIN ENDP

CODE ENDS
END

