.model small
.stack 256
.code

main proc
         mov ah,1       ;input
         int 21h
         mov bl,al
    
         mov ah,2       ;New Line
         mov dl,10
         int 21h
    
         mov dl,13      ;cret
         int 21h
    
         mov ah,2       ;output
         mov dl,bl
         int 21h
    
    exit:
         mov ah, 4ch
         int 21h
main endp
    
end main
    
