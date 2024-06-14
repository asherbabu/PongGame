STACK SEGMENT PARA STACK
    DB 64 DUP(' ')
STACK ENDS

DATA SEGMENT PARA 'DATA'
DATA ENDS

CODE SEGMENT PARA 'CODE'

    MAIN PROC FAR
    
        MOV DL, 'A'   ; Move 'A' character into DL register
        MOV AH, 6h     ; Set AH to 2 (function number for "print character")
        INT 21h       ; Call DOS interrupt
        
        RET           ; Return from procedure
    MAIN ENDP

CODE ENDS
END

