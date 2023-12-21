.model small
.stack 256
.data
    num  db ?
    Sum  db 1
.code

main proc
         mov ax, @data
         mov ds, ax
        
         mov ah,1
         int 21h
         sub al,48
         mov num,al

    Loop:
         mov al, num
         mov bl, sum
         mul bl
         mov sum,al
         sub num,1
         cmp num,0
         jg  Loop
    
    exit:
         mov ah, 4ch
         int 21h
main endp
    
end main

