.model small
.stack 100h
.data
    a    db 'Hello World! $'    ;$ means the string has finished

.code
main proc
         mov ax,@data
         mov ds,ax
    
         mov ah,9        ; printing string
         lea dx,a
         int 21h
    
    exit:
         mov ah,4ch
         int 21h
main endp
end main
    