.model small
.stack 256

.data
     sec           dw ?
     secMultiplier db 60

.code

main proc
          mov ax, @data
          mov ds, ax
        

     ;input
          mov ah,1
          int 21h
          sub al, 48
          mov bl, al
          
          xor bh,bh
          
          mov ax,bx
          
          mul secMultiplier
          mov sec,ax

            
    
     exit:
          mov ah, 4ch
          int 21h
main endp
    
end main
    
