.model small
.stack 256

.data
     promptMsg db 10,13,'Calling every 1 sec: $'

.code

callEvery1Sec MACRO params
          ;beep
               ;    mov ah,2
               ;    mov dl,7
               ;    int 21h
          ; print ■ | 254 in Ascii table
                  mov ah,2
                  mov dl,254
                  int 21h
ENDM

waitFor1Sec MACRO params
          ; Delay 1 sec | 16960 | 4240H
                    MOV CX, 0FH
                    MOV DX, 4240H
                    MOV AH, 86H
                    INT 15H
ENDM

main proc
              mov ax, @data
              mov ds, ax

              mov ah, 9
              lea dx, promptMsg
              int 21h

     Loop:    
               waitFor1Sec

               callEvery1Sec
          
              jmp Loop
    
     exit:    
              mov ah, 4ch
              int 21h
main endp
    
end main
    
