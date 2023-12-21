.model small
.stack 256

.data
    msg1 db 'Even $'
    msg2 db 'Odd $'
.code

main proc
           mov ax, @data
           mov ds, ax

           mov ah,1
           int 21h
           sub al, 48
           mov cl,al
                  
           xor ax,ax
                
           mov al,cl
           mov bl,2
           div bl
         
           mov cl, al
           mov ch, ah
         
           cmp ch,0
           je  JUMP01
           jmp JUMP02

    JUMP01:
           mov ah,2
           mov dl,10
           int 21h
    
           mov dl,13
           int 21h
           mov ah, 9
           lea dx, msg1
           int 21h
           jmp exit:

    JUMP02:
           mov ah,2
           mov dl,10
           int 21h
    
           mov dl,13
           int 21h
           mov ah, 9
           lea dx, msg2
           int 21h
           jmp exit:
         
    
    exit:  
           mov ah, 4ch
           int 21h
main endp
    
end main
    
