.model small
.stack 256

.data
     promptMsg db 'Enter a number: $'
     msg1      db 10,13,'Greater Than 5 $'
     msg2      db 10,13,'Less Than 5 $'
     msg3      db 10,13,'Equals To 5 $'
.code

main proc
          mov ax, @data
          mov ds, ax

     ; Display prompt
          mov ah, 9
          lea dx, promptMsg
          int 21h
    
     ; Read a digit
          mov ah,1              ;input a
          int 21h
          sub al, 48
          mov bl,al
          
     ;If Else
          cmp bl,0
          jg  L1
          jl  L2
          jmp L3
    
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
     L3:  
     ; Print output message
          mov ah, 9
          lea dx, msg3
          int 21h
          jmp exit:

  
    
     exit:
          mov ah, 4ch
          int 21h
main endp
    
end main
    
