; .model small
; .stack 256

; DATA SEGMENT
;     buffer   DB 50 DUP('$')    ; Buffer of 50 characters initialized with '$'
;     maxChars DB 50             ; Maximum number of characters to read
; DATA ENDS

; CODE SEGMENT
;     START:
;           MOV AX, DATA
;           MOV DS, AX              ; Set DS to point to the data segment

;           LEA DX, buffer          ; Load the address of the buffer
;           MOV buffer, maxChars    ; Store the maximum number of characters
;           MOV AH, 0Ah             ; Function code for buffered input
;           INT 21h                 ; Call DOS interrupt

;     ; The string entered by the user is now in 'buffer', starting from the second byte

;     ; [Continue with the rest of the program]

; CODE ENDS
; END START
