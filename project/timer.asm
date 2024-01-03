.model small
.stack 256

.data
     total_sec      dw 295
     sec           db ?
     min           db ?
     sec_multiplier db 60

     sec_1_place db ?
     sec_10_place db ?
     min_1_place db ?
     min_10_place db ?
     
 ; Numbers String
     _0_1 db 10,13,'  ###  $'
     _0_2 db 10,13,' #   # $'
     _0_3 db 10,13,' #   # $'
     _0_4 db 10,13,' #   # $'
     _0_5 db 10,13,'  ###  $'

     _1_1 db 10,13,'     # $'
     _1_2 db 10,13,'     # $'
     _1_3 db 10,13,'     # $'
     _1_4 db 10,13,'     # $'
     _1_5 db 10,13,'     # $'

     _2_1 db 10,13,' ##### $'
     _2_2 db 10,13,'     # $'
     _2_3 db 10,13,' ##### $'
     _2_4 db 10,13,' #     $'
     _2_5 db 10,13,' ##### $'

     _3_1 db 10,13,' ####  $'
     _3_2 db 10,13,'     # $'
     _3_3 db 10,13,'  ###  $'
     _3_4 db 10,13,'     # $'
     _3_5 db 10,13,' ####  $'

     _4_1 db 10,13,' #   # $'
     _4_2 db 10,13,' #   # $'
     _4_3 db 10,13,' ##### $'
     _4_4 db 10,13,'     # $'
     _4_5 db 10,13,'     # $'

     _5_1 db 10,13,' ##### $'
     _5_2 db 10,13,' #     $'
     _5_3 db 10,13,' ##### $'
     _5_4 db 10,13,'     # $'
     _5_5 db 10,13,' ##### $'

     _6_1 db 10,13,' ##### $'
     _6_2 db 10,13,' #     $'
     _6_3 db 10,13,' ##### $'
     _6_4 db 10,13,' #   # $'
     _6_5 db 10,13,' ##### $'

     _7_1 db 10,13,' ##### $'
     _7_2 db 10,13,'     # $'
     _7_3 db 10,13,'     # $'
     _7_4 db 10,13,'     # $'
     _7_5 db 10,13,'     # $'

     _8_1 db 10,13,'  ###  $'
     _8_2 db 10,13,' #   # $'
     _8_3 db 10,13,'  ###  $'
     _8_4 db 10,13,' #   # $'
     _8_5 db 10,13,'  ###  $'

     _9_1 db 10,13,' ##### $'
     _9_2 db 10,13,' #   # $'
     _9_3 db 10,13,' ##### $'
     _9_4 db 10,13,'     # $'
     _9_5 db 10,13,' ##### $'
.code

print MACRO params
                  mov ah,9
                  lea dx,params
                  int 21h
ENDM

clearDisplay MACRO
     mov ax, 3
     int 10h
ENDM

newLine MACRO
         mov ah,2       ;New Line
         mov dl,10
         int 21h
         mov dl,13      ;cret
         int 21h
ENDM

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


     cmp dl,'0'
     je jump_render0
     cmp dl,'1'
     je jump_render1
     cmp dl,'2'
     je jump_render2
     cmp dl,'3'
     je jump_render3
     cmp dl,'4'
     je jump_render4
     cmp dl,'5'
     je jump_render5
     cmp dl,'6'
     je jump_render6
     cmp dl,'7'
     je jump_render7
     cmp dl,'8'
     je jump_render8
     cmp dl,'9'
     je jump_render9
ENDM

displayColon MACRO
     mov ah,2
     mov dl,58
     int 21h
ENDM

displayClicheTimer MACRO
     clearDisplay
     displayDigit min_10_place
     displayDigit min_1_place
     displayColon
     displayDigit sec_10_place
     displayDigit sec_1_place
ENDM



render0 MACRO
          print _0_1
          print _0_2
          print _0_3
          print _0_4
          print _0_5
ENDM
render1 MACRO
          print _1_1
          print _1_2
          print _1_3
          print _1_4
          print _1_5
ENDM
render2 MACRO
          print _2_1
          print _2_2
          print _2_3
          print _2_4
          print _2_5
ENDM
render3 MACRO
          print _3_1
          print _3_2
          print _3_3
          print _3_4
          print _3_5
ENDM
render4 MACRO
          print _4_1
          print _4_2
          print _4_3
          print _4_4
          print _4_5
ENDM
render5 MACRO
          print _5_1
          print _5_2
          print _5_3
          print _5_4
          print _5_5
ENDM
render6 MACRO
          print _6_1
          print _6_2
          print _6_3
          print _6_4
          print _6_5
ENDM
render7 MACRO
          print _7_1
          print _7_2
          print _7_3
          print _7_4
          print _7_5
ENDM
render8 MACRO
          print _8_1
          print _8_2
          print _8_3
          print _8_4
          print _8_5
ENDM
render9 MACRO
          print _9_1
          print _9_2
          print _9_3
          print _9_4
          print _9_5
ENDM


startTimer MACRO
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
ENDM

main proc
               mov ax, @data
               mov ds, ax

               startTimer

     jump_render0:  
          render0
          jmp exit:
     jump_render1:  
          render1
          jmp exit:
     jump_render2:  
          render2
          jmp exit:
     jump_render3:  
          render3
          jmp exit:
     jump_render4:  
          render4
          jmp exit:
     jump_render5:  
          render5
          jmp exit:
     jump_render6:  
          render6
          jmp exit:
     jump_render7:  
          render7
          jmp exit:
     jump_render8:  
          render8
          jmp exit:
     jump_render9:  
          render9
          jmp exit:

     exit:    
              mov      ah, 4ch
              int      21h
main endp
    
end main
    
