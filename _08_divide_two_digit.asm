.model small
.stack 256
.code

main proc
          mov al,14
          mov bl,3
          div bl          ;al=al/bl
         
     ; Here al contains Quotient
     ; Here ah contains Remainder
          mov cl, al
          mov ch, ah
         
     ; Quotient
          mov ah,2        ;output
          mov dl,cl
          add dl,48
          int 21h
         
     ; Remainder
          mov ah,2        ;output
          mov dl,ch
          add dl,48
          int 21h
    
     exit:
          mov ah, 4ch
          int 21h
main endp
    
end main
    
