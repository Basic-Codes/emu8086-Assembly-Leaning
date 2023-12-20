.model small
.stack 256

.code
main proc
         mov ah,1        ;input a
         int 21h
         mov bl,al
    
         mov ah,1        ;input b
         int 21h
         mov bh,al
         
         add bl,bh
    
         mov ah,2        ;output a+48
         mov dl,bl
         sub dl,48
         int 21h
    
    exit:
         mov ah, 4ch
         int 21h
main endp
    
end main