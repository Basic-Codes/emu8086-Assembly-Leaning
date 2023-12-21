.model small
.stack 256

.data
    msg1 db 10,13,'This number is divisible by 5 $'
    msg2 db 10,13,'This number not divisible by 5 $'
.code

main proc
                 mov ax, @data
                 mov ds, ax
                  
                 xor ax,ax
                
                 mov al,36
                 mov bl,5
                 div bl
         
                 mov cl, al
                 mov ch, ah
         
                 cmp ch,0
                 je  isDivisible
                 jmp notDivisible

    isDivisible: 
                 mov ah, 9
                 lea dx, msg1
                 int 21h
                 jmp exit:

    notDivisible:
                 mov ah, 9
                 lea dx, msg2
                 int 21h
                 jmp exit:
         
    
    exit:        
                 mov ah, 4ch
                 int 21h
main endp
    
end main
    
