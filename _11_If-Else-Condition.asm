.model small
.stack 256

.data
     promptMsg db 'Enter two number: $'
     msg1      db 10,13,'First num is large $'
     msg2      db 10,13,'Second num is large $'
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
       
     ; If Else
          cmp bl,bh
          jg  L1
          jmp L2
    
     L1:  
     ; Print output message
          mov ah, 9
          lea dx, msg1
          int 21h
          jmp exit:
       
     L2:  
     ; Print output message
          mov ah, 9
          lea dx, msg2
          int 21h
          jmp exit:

  
    
     exit:
          mov ah, 4ch
          int 21h
main endp
    
end main
    
