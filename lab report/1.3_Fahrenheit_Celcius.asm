.model small
.stack 256

.data
  C    dw ?
.code

main proc
       mov ax, @data
       mov ds, ax
    
       mov ah,1       ;input a
       int 21h
       mov bl,al
        
       mov ah,1       ;input b
       int 21h
       mov bh,al
    
       mov ax,1000
       sub ax,32

       mov cx,5
       mul cx

       mov cx,9
       div cx
               
       add ax,1  ;taking the ceiling        
       mov C,ax
    
  exit:
       mov ah, 4ch
       int 21h
main endp
    
end main
    
