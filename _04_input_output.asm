.model small
.stack 100h
.data
a db 'Enter a number: $'
b db 'Your number is $'

.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9        ;print string a
    lea dx,a
    int 21h
    
    mov ah,1        ;input
    int 21h
    mov bl,al 
    
    mov ah,2        ;New Line
    mov dl,10
    int 21h
    
    mov dl,13       ;cret
    int 21h
    
    mov ah,9        ;print string b
    lea dx,b
    int 21h
    
    mov ah,2        ;output
    mov dl,bl
    int 21h
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main