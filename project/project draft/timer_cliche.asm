.model small
.stack 256

.data
     total_sec      dw 299
     sec           db ?
     min           db ?
     sec_multiplier db 60

     sec_1_place db ?
     sec_10_place db ?
     min_1_place db ?
     min_10_place db ?

.code

waitFor1Sec MACRO params
          ; Delay 1 sec | 16960 | 4240H
                    MOV CX, 0FH
                    MOV DX, 4240H
                    MOV AH, 86H
                    INT 15H
ENDM
separate MACRO
                       xor ax,ax
                       mov ax, total_sec
                       mov bl, sec_multiplier
                       div bl

                       mov min, al
                       mov sec, ah
ENDM

setSecPlaces MACRO
     xor ax,ax
     mov al, sec
     mov bl,10
     div bl
     mov sec_1_place, ah
     mov sec_10_place, al
ENDM

setMinPlaces MACRO
     xor ax,ax
     mov al, min
     mov bl,10
     div bl
     mov min_1_place, ah
     mov min_10_place, al
ENDM

displayDigit MACRO digit
     mov ah,2
     mov dl,digit
     add dl,48
     int 21h
ENDM
displayColor MACRO
     mov ah,2
     mov dl,58
     int 21h
ENDM

displayClicheTimer MACRO
     clearDisplay
     displayDigit min_10_place
     displayDigit min_1_place
     displayColor
     displayDigit sec_10_place
     displayDigit sec_1_place
ENDM

clearDisplay MACRO
     mov ax, 3
     int 10h
ENDM



main proc
               mov ax, @data
               mov ds, ax

               mov cx,total_sec

               loopx:
                    sub total_sec, 1
                    mov cx,total_sec
                    separate
                    setSecPlaces
                    setMinPlaces
                    displayClicheTimer
                    waitFor1Sec
                    loop loopx

     exit:    
              mov      ah, 4ch
              int      21h
main endp
    
end main
    
