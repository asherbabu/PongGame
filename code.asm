STACK SEGMENT PARA STACK
    DB 64 DUP(' ')
STACK ENDS

DATA SEGMENT PARA 'DATA'

    TIME_AUX DB 0     ; variable used when chech=king if the time has changed

    BALL_X DW 0Ah     ; X position column of the ball
    BALL_Y DW 0Ah     ; Y position line of the ball
    BALL_SIZE DW 04H  ; size of the ball (how many pixel the doe the ball have in width and height)
    BALL_VELOCITY_X DW 05h     ; X (horizontal) velocity of the ball
    BALL_VELOCITY_Y DW 02h     ; Y (vertical) velocity of the ball

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
    
        CALL CLEAR_SCREEN

        CHECK_TIME:
            MOV AH, 2Ch   ; get the system time
            INT 21h       ; CH = hour, CL = minute, DH = second DL = 1/100 seconds

            CMP DL, TIME_AUX     ; is teh current time equal to the previous one(TIME_AUX)?
            JE CHECK_TIME        ; if it is the same check agaiin

            ; if it is different then draw, move, etc 
            MOV TIME_AUX, DL    ; updating time

            CALL CLEAR_SCREEN

            CALL MOVE_BALL

            CALL DRAW_BALL

            JMP CHECK_TIME ; after everything, checks time again

        RET           ; Return from procedure
    MAIN ENDP

    MOVE_BALL PROC NEAR
        MOV AX, BALL_VELOCITY_X
        ADD BALL_X, AX
        MOV AX, BALL_VELOCITY_Y
        ADD BALL_Y, AX
    MOVE_BALL ENDP

    DRAW_BALL PROC NEAR 

        MOV CX, BALL_X   ; set the initial column (X)
        MOV DX, BALL_Y   ; set the initial line (Y)
        
        DRAW_BALL_HORIZONTAL:
            MOV AH, 0Ch   ; set the configuration to write a pixel
            MOV AL, 0Fh   ; choose color
            MOV BH, 00h   ; set the page number 
            INT 10h       ; execute configuration

            INC CX        ; CX = CX + 1
            MOV AX, CX    ; CX - BALL_X > BALL_SIZE (Y -> We go to the next line,N -> We continue to the next column
            SUB AX, BALL_X
            CMP AX, BALL_SIZE
            JNG DRAW_BALL_HORIZONTAL

            MOV CX, BALL_X  ; the CX register goes back to the initial column
            INC DX          ; we advance one line

            MOV AX, DX      ; DX - BALL_Y > BALL_SIZE (Y -> we exit this procedure , N -> we comntinue to the next line)
            SUB AX, BALL_Y
            CMP AX, BALL_SIZE
            JNG DRAW_BALL_HORIZONTAL

        RET
    DRAW_BALL ENDP

    CLEAR_SCREEN PROC NEAR
        MOV AH, 00h   ; set the configuration to video mode
        MOV AL, 13h   ; choose videomode
        INT 10h       ; execute the configuration

        MOV AH, 0bh   ; set the configuration to the background color
        MOV BH, 00h   ; to the background color
        MOV BL, 01h   ; choosing background color
        INT 10h       ; executing the configuration

        RET
    CLEAR_SCREEN ENDP

CODE ENDS
END

