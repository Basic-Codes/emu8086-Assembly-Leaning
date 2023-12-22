INCLUDE 'EMU8086.INC'
.MODEL SMALL
.STACK 100h
.DATA        
    ARR DB 50 DUP(?) 
    primeARR DB 50 DUP(?)
    nonPrimeARR DB 50 DUP(?)
    isPrime    db 10,13,'Is Prime! $'
    notPrime    db 10,13,'Not Prime! $'
    checking db 10,13,'Checking: $'

.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        XOR BX,BX
        XOR CX,CX
        
        PRINT "Enter numbers of elements: "
        
        MOV AH,1
        INT 21H
        AND AL,0FH
        
        MOV CL,AL
        MOV BL,AL
        MOV SI,0
        
        PRINTN
        PRINT "Enter values:"
        
        ARRAY_INPUT
           
        PRINTN
        PRINT "OUTPUT: "
        
        MOV CX,BX
        MOV SI,0
        MOV AH,2  
        
        ARRAY_OUTPUT
        ARRAY_LOOP
        CHECK_PRIME
  MAIN ENDP
    
    ARRAY_INPUT MACRO
        INPUT:
         INT 21H
         MOV ARR[SI],AL
         INC SI
         LOOP INPUT
    ENDM
    
    ARRAY_OUTPUT MACRO
        OUTPUT:
            MOV DL,ARR[SI]
            INT 21h
            INC SI
           LOOP OUTPUT
    ENDM
    
    ARRAY_LOOP MACRO
        ARR_LOOP:
            MOV CL,ARR[SI]
            INC SI
            CHECK_PRIME 
           LOOP ARR_LOOP
    ENDM
    
    CHECK_PRIME MACRO
         mov ah,9
         lea dx,checking
         int 21h
        
         mov ah,2
         mov dl,CL
         mov dl,48
         int 21h
    ENDM
    
END MAIN