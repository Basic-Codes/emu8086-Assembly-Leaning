.model small
.stack 256

.data
     promptMsg db 10,13,'Calling every 1 sec: $'

.code
main proc
          mov ax, @data
          mov ds, ax

          mov ah, 9
          lea dx, promptMsg
          int 21h

     Loop:
     ; Delay 1 sec | 16960 | 4240H
          MOV CX, 0FH
          MOV DX, 4240H
          MOV AH, 86H
          INT 15H

     ;beep
          mov ah,2
          mov dl,7
          int 21h

          mov ah,2
          mov dl,254
          int 21h
          
          jmp Loop
    
     exit:
          mov ah, 4ch
          int 21h
main endp
    
end main
    
