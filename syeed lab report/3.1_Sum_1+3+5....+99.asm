.model small
.stack 256
.data
    Sum  dw ?
.code

main proc
    
         mov ax, @data
         mov ds, ax
          
         mov cx,0

    Loop:

         add bx,2
         add sum,bx

         cmp bx,99
         jle Loop
                  
    
    exit:
         mov ah, 4ch
         int 21h
main endp
    
end main

