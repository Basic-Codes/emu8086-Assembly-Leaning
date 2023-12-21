.model small
.stack 100h
.data
    promptMsg db 'Enter a two-digit number: $'
    outputMsg db 'Your number is: $'

.code
main proc
         mov ax, @data
         mov ds, ax
    
    ; Display prompt
         mov ah, 9
         lea dx, promptMsg
         int 21h
    
    ; Read first digit
         mov ah, 1
         int 21h
    ;sub al, '0'     ; Convert from ASCII to number
         mov bl, al
    
    ; Read second digit
         mov ah, 1
         int 21h
    ;sub al, '0'     ; Convert from ASCII to number
         mov bh, al
    
    ;------------------------------ Print
         mov bl, al
         mul bl
         aam
         mov bx,ax
    
         mov ah, 2
         mov dl, bh
         add dl, 48
         int 21h
    
         mov ah, 2
         mov dl, bl
         add dl, 48
         int 21h
    ;------------------------------ Print

    ; Combine digits into a number
         mov al, bl
         mov bl, 10
         mul bl
         add al, bh

    ; Convert to ASCII for display
         aam                  ; ASCII Adjust after Multiply
         add ax, 3030h        ; Convert to ASCII
    
         mov ah,2             ;New Line
         mov dl,10
         int 21h
         mov dl,13            ;cret
         int 21h

    ; Print output message
         mov ah, 9
         lea dx, outputMsg
         int 21h

    ; Print first digit
         mov ah, 2
         mov dl, ah
         int 21h

    ; Print second digit
         mov ah, 2
         mov dl, al
         int 21h
    
    ; Exit program
         mov ah, 4ch
         int 21h
main endp
end main
