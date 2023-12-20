.model small
.stack 256

.data
    a    db 5
    b    db ?

.code
main proc
         mov ax,@data
         mov ds,ax
    
         mov ah,1        ;input b
         int 21h
         mov b,al
    
         mov ah,2        ;New Line
         mov dl,10
         int 21h
    
         mov dl,13       ;cret
         int 21h
    
         mov ah,2        ;output a+48
         mov dl,a
         add dl,48
         int 21h
   
    
         mov ah,2        ;output b
         mov dl,b
         int 21h
    
    exit:
         mov ah, 4ch
         int 21h
main endp
    
end main