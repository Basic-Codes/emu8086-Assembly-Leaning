.model small
.stack 256
.code

main proc
         mov ah,1       ;input
         int 21h
         mov bl,al

         mov cl,'1'
    Loop:
         cmp cl,bl      ; if cl greater than input number ? exit
         jg  exit:

         mov ah,2       ;output
         mov dl,cl
         int 21h
         
         inc cl
         jmp Loop
    
    exit:
         mov ah, 4ch
         int 21h
main endp
    
end main
    
