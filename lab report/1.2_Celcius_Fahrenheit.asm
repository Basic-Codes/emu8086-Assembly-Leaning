.model small
.stack 256

.data
    Fahrenheit dw ?
.code

main proc
         mov ax, @data
         mov ds, ax
    
         mov ax,260
         
         mov bx,9
         mul bx
         
         mov bx, 5
         div bx
         
         mov bx,32
         add ax,bx
         
         mov Fahrenheit,ax
    
    exit:
         mov ah, 4ch
         int 21h
main endp
    
end main
    
