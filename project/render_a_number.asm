.model small
.stack 256

.data

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

main proc
          mov ax, @data
          mov ds, ax
     
     render0
     newLine
     waitFor1Sec
     render1
     newLine
     waitFor1Sec
     render2
     newLine
     waitFor1Sec
     render3
     newLine
     waitFor1Sec
     render4
     newLine
     waitFor1Sec
     render5
     newLine
     waitFor1Sec
     render6
     newLine
     waitFor1Sec
     render7
     newLine
     waitFor1Sec
     render8
     newLine
     waitFor1Sec
     render9

          
     exit:
          mov ah, 4ch
          int 21h
main endp
    
end main
    
