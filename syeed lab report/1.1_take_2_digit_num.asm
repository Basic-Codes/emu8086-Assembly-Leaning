.model small
.stack 256

.data
    message db 'number = $'
.code

main proc
         mov ax, @data
         mov ds, ax
    
         mov ah,1
         int 21h
         sub al, 48
         mov bl,al
        
         mov ah,1
         int 21h
         sub al, 48
         mov bh,al
       
         mov ah,2
         mov dl,10
         int 21h
    
         mov dl,13
         int 21h

         mov ah, 9
         lea dx, message
         int 21h

         mov ah, 2
         mov dl, bl
         add dl, 48
         int 21h

         mov ah, 2
         mov dl, bh
         add dl, 48
         int 21h
    
    exit:
         mov ah, 4ch
         int 21h
main endp
    
end main
    
