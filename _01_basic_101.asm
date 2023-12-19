.model small
.stack 256
.code

main proc
    mov ah,1
    int 21h            ;input
    mov bl,al
    
    mov ah,2 
    mov dl,10          ;New Line
    int 21h
    
    mov dl,13          ;cret
    int 21h
    
    mov ah,2
    mov dl,bl          ;output
    int 21h
    
    exit:
    mov ah, 4ch
    int 21h
    main endp
    
end main
    
