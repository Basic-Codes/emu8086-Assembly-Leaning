.model small
.stack 256

.data
  Celcius dw ?
.code

main proc
       mov ax, @data
       mov ds, ax
    
       mov ax,1000
       sub ax,32

       mov cx,5
       mul cx

       mov cx,9
       div cx
         
       mov Celcius,ax
    
  exit:
       mov ah, 4ch
       int 21h
main endp
    
end main
    
