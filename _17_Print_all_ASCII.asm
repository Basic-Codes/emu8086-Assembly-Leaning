.model small
.stack 256
.code

main proc
         mov ah,2       ;output
         mov dx,0

    Loop:
         int 21h

         inc dx

         cmp dx,256
         jle Loop
    
    exit:
         mov ah, 4ch
         int 21h
main endp
    
end main
    
