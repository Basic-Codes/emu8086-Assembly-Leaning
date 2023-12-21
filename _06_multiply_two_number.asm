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
          sub al, 48            ; Convert from ASCII to number
          mov bl, al
    
     ; Read second digit
          mov ah, 1
          int 21h
          sub al, 48            ; Convert from ASCII to number
          mov bh, al
    
     ; Multiply
          mov al, bh
          mul bl                ; al = al x bl
          aam
          mov bx,ax
     
     ; Print first digit after multiply
          mov ah, 2
          mov dl, bh
          add dl, 48
          int 21h
    
     ; Print second digit after multiply
          mov ah, 2
          mov dl, bl
          add dl, 48
          int 21h
    
     ; Exit program
          mov ah, 4ch
          int 21h
main endp
end main
