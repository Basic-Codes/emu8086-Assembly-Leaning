.model small
.stack 256

.data
     promptMsg db 'Enter a two-digit number: $'
     outputMsg db 10,13,'Your number is: $'
.code

main proc
          mov ax, @data
          mov ds, ax

     ; Display prompt
          mov ah, 9
          lea dx, promptMsg
          int 21h
    
     ; Read first digit
          mov ah,1              ;input a
          int 21h
          sub al, 48
          mov bl,al
        
     ; Read second digit
          mov ah,1              ;input b
          int 21h
          sub al, 48
          mov bh,al

     ; Print output message
          mov ah, 9
          lea dx, outputMsg
          int 21h

     ; Print first digit
          mov ah, 2
          mov dl, bl
          add dl, 48
          int 21h

     ; Print second digit
          mov ah, 2
          mov dl, bh
          add dl, 48
          int 21h
    
     exit:
          mov ah, 4ch
          int 21h
main endp
    
end main
    
