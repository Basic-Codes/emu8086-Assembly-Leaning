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

    service                  db ?
     
    welcomePrompt01          db 10,13,'                      +----------------------------+$'
    welcomePrompt02          db 10,13,'                      |           Welcome          |$'
    welcomePrompt03          db 10,13,'                      +----------------------------+$'
    selectServicePromptStart db 10,13,'+-----------------------------------------------------------------------+$'
    selectServicePrompt01    db 10,13,'|                            Select a service                           |$'
    selectServicePrompt02    db 10,13,'|                                                                       |$'
    selectServicePrompt03    db 10,13,'|                            1. Timer                                   |$'
    selectServicePrompt04    db 10,13,'|                            2. Stopwatch                               |$'
    selectServicePrompt05    db 10,13,'|                            3. Clock                                   |$'
    selectServicePromptEnd   db 10,13,'+-----------------------------------------------------------------------+$'
    selectServicePromptFinal db 10,13,'Service: $'
    
    timerPromptStart             db 10,13,'                      +----------------------------+$',
    timerPromptTimer             db 10,13,'                      |             Timer          |$',
    timerPromptEnd               db 10,13,'                      +----------------------------+$'
    timerPromptSet               db 10,13,'Set timer for (Min): $'


    stopwatchPrompt         db 10,13,'Stopwatch: $'
    clockPrompt             db 10,13,'Clock: $'
     
 ; Numbers String
     _0_1 db '  ###  $'
     _0_2 db ' #   # $'
     _0_3 db ' #   # $'
     _0_4 db ' #   # $'
     _0_5 db '  ###  $'

     _1_1 db '     # $'
     _1_2 db '     # $'
     _1_3 db '     # $'
     _1_4 db '     # $'
     _1_5 db '     # $'

     _2_1 db ' ##### $'
     _2_2 db '     # $'
     _2_3 db ' ##### $'
     _2_4 db ' #     $'
     _2_5 db ' ##### $'

     _3_1 db ' ####  $'
     _3_2 db '     # $'
     _3_3 db '  ###  $'
     _3_4 db '     # $'
     _3_5 db ' ####  $'

     _4_1 db ' #   # $'
     _4_2 db ' #   # $'
     _4_3 db ' ##### $'
     _4_4 db '     # $'
     _4_5 db '     # $'

     _5_1 db ' ##### $'
     _5_2 db ' #     $'
     _5_3 db ' ##### $'
     _5_4 db '     # $'
     _5_5 db ' ##### $'

     _6_1 db ' ##### $'
     _6_2 db ' #     $'
     _6_3 db ' ##### $'
     _6_4 db ' #   # $'
     _6_5 db ' ##### $'

     _7_1 db ' ##### $'
     _7_2 db '     # $'
     _7_3 db '     # $'
     _7_4 db '     # $'
     _7_5 db '     # $'

     _8_1 db '  ###  $'
     _8_2 db ' #   # $'
     _8_3 db '  ###  $'
     _8_4 db ' #   # $'
     _8_5 db '  ###  $'

     _9_1 db ' ##### $'
     _9_2 db ' #   # $'
     _9_3 db ' ##### $'
     _9_4 db '     # $'
     _9_5 db ' ##### $'

     _x_1 db '   $'
     _x_2 db ' # $'
     _x_3 db '   $'
     _x_4 db ' # $'
     _x_5 db '   $'
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

     ; cmp dl,'0'
     ; je .jump_render0
     ; cmp dl,'1'
     ; je .jump_render1
     ; cmp dl,'2'
     ; je .jump_render2
     ; cmp dl,'3'
     ; je .jump_render3
     ; cmp dl,'4'
     ; je .jump_render4
     ; cmp dl,'5'
     ; je .jump_render5
     ; cmp dl,'6'
     ; je .jump_render6
     ; cmp dl,'7'
     ; je .jump_render7
     ; cmp dl,'8'
     ; je .jump_render8
     ; cmp dl,'9'
     ; je .jump_render9

     ; .jump_render0:  
     ;      render0
     ;      jmp exit:
     ; .jump_render1:  
     ;      render1
     ;      jmp exit:
     ; .jump_render2:  
     ;      render2
     ;      jmp exit:
     ; .jump_render3:  
     ;      render3
     ;      jmp exit:
     ; .jump_render4:  
     ;      render4
     ;      jmp exit:
     ; .jump_render5:  
     ;      render5
     ;      jmp exit:
     ; .jump_render6:  
     ;      render6
     ;      jmp exit:
     ; .jump_render7:  
     ;      render7
     ;      jmp exit:
     ; .jump_render8:  
     ;      render8
     ;      jmp exit:
     ; .jump_render9:  
     ;      render9
     ;      jmp exit:
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

displayTimer PROC

     clearDisplay

     call displayLevel_01

displayTimer ENDP

; ======================
;      Level_01
; ======================
displayLevel_01 PROC

     show_min_10_place_1:
        mov dl,min_10_place

        cmp dl,0
        je .jump_render_min_10_place_0_1
        cmp dl,1
        je .jump_render_min_10_place_1_1
        cmp dl,2
        je .jump_render_min_10_place_2_1
        cmp dl,3
        je .jump_render_min_10_place_3_1
        cmp dl,4
        je .jump_render_min_10_place_4_1
        cmp dl,5
        je .jump_render_min_10_place_5_1
        cmp dl,6
        je .jump_render_min_10_place_6_1
        cmp dl,7
        je .jump_render_min_10_place_7_1
        cmp dl,8
        je .jump_render_min_10_place_8_1
        cmp dl,9
        je .jump_render_min_10_place_9_1

        .jump_render_min_10_place_0_1:  
            print _0_1
            jmp show_min_1_place_1
            jmp exit:
        .jump_render_min_10_place_1_1:  
            print _1_1
            jmp show_min_1_place_1
            jmp exit:
        .jump_render_min_10_place_2_1:  
            print _2_1
            jmp show_min_1_place_1
            jmp exit:
        .jump_render_min_10_place_3_1:  
            print _3_1
            jmp show_min_1_place_1
            jmp exit:
        .jump_render_min_10_place_4_1:  
            print _4_1
            jmp show_min_1_place_1
            jmp exit:
        .jump_render_min_10_place_5_1:  
            print _5_1
            jmp show_min_1_place_1
            jmp exit:
        .jump_render_min_10_place_6_1:  
            print _6_1
            jmp show_min_1_place_1
            jmp exit:
        .jump_render_min_10_place_7_1:  
            print _7_1
            jmp show_min_1_place_1
            jmp exit:
        .jump_render_min_10_place_8_1:  
            print _8_1
            jmp show_min_1_place_1
            jmp exit:
        .jump_render_min_10_place_9_1:  
            print _9_1
            jmp show_min_1_place_1
            jmp exit:
; ------------<end>-------------

    show_min_1_place_1:
        mov dl,min_1_place

        cmp dl,0
        je .jump_render_min_1_place_0_1
        cmp dl,1
        je .jump_render_min_1_place_1_1
        cmp dl,2
        je .jump_render_min_1_place_2_1
        cmp dl,3
        je .jump_render_min_1_place_3_1
        cmp dl,4
        je .jump_render_min_1_place_4_1
        cmp dl,5
        je .jump_render_min_1_place_5_1
        cmp dl,6
        je .jump_render_min_1_place_6_1
        cmp dl,7
        je .jump_render_min_1_place_7_1
        cmp dl,8
        je .jump_render_min_1_place_8_1
        cmp dl,9
        je .jump_render_min_1_place_9_1

        .jump_render_min_1_place_0_1:  
            print _0_1
            jmp show_colon_1
            jmp exit:
        .jump_render_min_1_place_1_1:  
            print _1_1
            jmp show_colon_1
            jmp exit:
        .jump_render_min_1_place_2_1:  
            print _2_1
            jmp show_colon_1
            jmp exit:
        .jump_render_min_1_place_3_1:  
            print _3_1
            jmp show_colon_1
            jmp exit:
        .jump_render_min_1_place_4_1:  
            print _4_1
            jmp show_colon_1
            jmp exit:
        .jump_render_min_1_place_5_1:  
            print _5_1
            jmp show_colon_1
            jmp exit:
        .jump_render_min_1_place_6_1:  
            print _6_1
            jmp show_colon_1
            jmp exit:
        .jump_render_min_1_place_7_1:  
            print _7_1
            jmp show_colon_1
            jmp exit:
        .jump_render_min_1_place_8_1:  
            print _8_1
            jmp show_colon_1
            jmp exit:
        .jump_render_min_1_place_9_1:  
            print _9_1
            jmp show_colon_1
            jmp exit:
; ------------<end>-------------

    show_colon_1:
        print _x_1
        jmp show_sec_10_place_1
; ------------<end>-------------

    show_sec_10_place_1:
        mov dl,sec_10_place

        cmp dl,0
        je .jump_render_sec_10_place_0_1
        cmp dl,1
        je .jump_render_sec_10_place_1_1
        cmp dl,2
        je .jump_render_sec_10_place_2_1
        cmp dl,3
        je .jump_render_sec_10_place_3_1
        cmp dl,4
        je .jump_render_sec_10_place_4_1
        cmp dl,5
        je .jump_render_sec_10_place_5_1
        cmp dl,6
        je .jump_render_sec_10_place_6_1
        cmp dl,7
        je .jump_render_sec_10_place_7_1
        cmp dl,8
        je .jump_render_sec_10_place_8_1
        cmp dl,9
        je .jump_render_sec_10_place_9_1

        .jump_render_sec_10_place_0_1:  
            print _0_1
            jmp show_sec_1_place_1
            jmp exit:
        .jump_render_sec_10_place_1_1:  
            print _1_1
            jmp show_sec_1_place_1
            jmp exit:
        .jump_render_sec_10_place_2_1:  
            print _2_1
            jmp show_sec_1_place_1
            jmp exit:
        .jump_render_sec_10_place_3_1:  
            print _3_1
            jmp show_sec_1_place_1
            jmp exit:
        .jump_render_sec_10_place_4_1:  
            print _4_1
            jmp show_sec_1_place_1
            jmp exit:
        .jump_render_sec_10_place_5_1:  
            print _5_1
            jmp show_sec_1_place_1
            jmp exit:
        .jump_render_sec_10_place_6_1:  
            print _6_1
            jmp show_sec_1_place_1
            jmp exit:
        .jump_render_sec_10_place_7_1:  
            print _7_1
            jmp show_sec_1_place_1
            jmp exit:
        .jump_render_sec_10_place_8_1:  
            print _8_1
            jmp show_sec_1_place_1
            jmp exit:
        .jump_render_sec_10_place_9_1:  
            print _9_1
            jmp show_sec_1_place_1
            jmp exit:
; ------------<end>-------------

    show_sec_1_place_1:
        mov dl,sec_1_place

        cmp dl,0
        je .jump_render_sec_1_place_0_1
        cmp dl,1
        je .jump_render_sec_1_place_1_1
        cmp dl,2
        je .jump_render_sec_1_place_2_1
        cmp dl,3
        je .jump_render_sec_1_place_3_1
        cmp dl,4
        je .jump_render_sec_1_place_4_1
        cmp dl,5
        je .jump_render_sec_1_place_5_1
        cmp dl,6
        je .jump_render_sec_1_place_6_1
        cmp dl,7
        je .jump_render_sec_1_place_7_1
        cmp dl,8
        je .jump_render_sec_1_place_8_1
        cmp dl,9
        je .jump_render_sec_1_place_9_1

        .jump_render_sec_1_place_0_1:  
            print _0_1
            call displayLevel_02
            jmp exit:
        .jump_render_sec_1_place_1_1:  
            print _1_1
            call displayLevel_02
            jmp exit:
        .jump_render_sec_1_place_2_1:  
            print _2_1
            call displayLevel_02
            jmp exit:
        .jump_render_sec_1_place_3_1:  
            print _3_1
            call displayLevel_02
            jmp exit:
        .jump_render_sec_1_place_4_1:  
            print _4_1
            call displayLevel_02
            jmp exit:
        .jump_render_sec_1_place_5_1:  
            print _5_1
            call displayLevel_02
            jmp exit:
        .jump_render_sec_1_place_6_1:  
            print _6_1
            call displayLevel_02
            jmp exit:
        .jump_render_sec_1_place_7_1:  
            print _7_1
            call displayLevel_02
            jmp exit:
        .jump_render_sec_1_place_8_1:  
            print _8_1
            call displayLevel_02
            jmp exit:
        .jump_render_sec_1_place_9_1:  
            print _9_1
            call displayLevel_02
            jmp exit:
; ------------<end>-------------

displayLevel_01 ENDP

; ======================
;      Level_02
; ======================
displayLevel_02 PROC
     newLine

     show_min_10_place_2:
        mov dl,min_10_place

        cmp dl,0
        je .jump_render_min_10_place_0_2
        cmp dl,1
        je .jump_render_min_10_place_1_2
        cmp dl,2
        je .jump_render_min_10_place_2_2
        cmp dl,3
        je .jump_render_min_10_place_3_2
        cmp dl,4
        je .jump_render_min_10_place_4_2
        cmp dl,5
        je .jump_render_min_10_place_5_2
        cmp dl,6
        je .jump_render_min_10_place_6_2
        cmp dl,7
        je .jump_render_min_10_place_7_2
        cmp dl,8
        je .jump_render_min_10_place_8_2
        cmp dl,9
        je .jump_render_min_10_place_9_2

        .jump_render_min_10_place_0_2:  
            print _0_2
            jmp show_min_1_place_2
            jmp exit:
        .jump_render_min_10_place_1_2:  
            print _1_2
            jmp show_min_1_place_2
            jmp exit:
        .jump_render_min_10_place_2_2:  
            print _2_2
            jmp show_min_1_place_2
            jmp exit:
        .jump_render_min_10_place_3_2:  
            print _3_2
            jmp show_min_1_place_2
            jmp exit:
        .jump_render_min_10_place_4_2:  
            print _4_2
            jmp show_min_1_place_2
            jmp exit:
        .jump_render_min_10_place_5_2:  
            print _5_2
            jmp show_min_1_place_2
            jmp exit:
        .jump_render_min_10_place_6_2:  
            print _6_2
            jmp show_min_1_place_2
            jmp exit:
        .jump_render_min_10_place_7_2:  
            print _7_2
            jmp show_min_1_place_2
            jmp exit:
        .jump_render_min_10_place_8_2:  
            print _8_2
            jmp show_min_1_place_2
            jmp exit:
        .jump_render_min_10_place_9_2:  
            print _9_2
            jmp show_min_1_place_2
            jmp exit:
; ------------<end>-------------

    show_min_1_place_2:
        mov dl,min_1_place

        cmp dl,0
        je .jump_render_min_1_place_0_2
        cmp dl,1
        je .jump_render_min_1_place_1_2
        cmp dl,2
        je .jump_render_min_1_place_2_2
        cmp dl,3
        je .jump_render_min_1_place_3_2
        cmp dl,4
        je .jump_render_min_1_place_4_2
        cmp dl,5
        je .jump_render_min_1_place_5_2
        cmp dl,6
        je .jump_render_min_1_place_6_2
        cmp dl,7
        je .jump_render_min_1_place_7_2
        cmp dl,8
        je .jump_render_min_1_place_8_2
        cmp dl,9
        je .jump_render_min_1_place_9_2

        .jump_render_min_1_place_0_2:
            print _0_2
            jmp show_colon_2
            jmp exit:
        .jump_render_min_1_place_1_2:
            print _1_2
            jmp show_colon_2
            jmp exit:
        .jump_render_min_1_place_2_2:
            print _2_2
            jmp show_colon_2
            jmp exit:
        .jump_render_min_1_place_3_2:
            print _3_2
            jmp show_colon_2
            jmp exit:
        .jump_render_min_1_place_4_2:
            print _4_2
            jmp show_colon_2
            jmp exit:
        .jump_render_min_1_place_5_2:
            print _5_2
            jmp show_colon_2
            jmp exit:
        .jump_render_min_1_place_6_2:
            print _6_2
            jmp show_colon_2
            jmp exit:
        .jump_render_min_1_place_7_2:
            print _7_2
            jmp show_colon_2
            jmp exit:
        .jump_render_min_1_place_8_2:
            print _8_2
            jmp show_colon_2
            jmp exit:
        .jump_render_min_1_place_9_2:
            print _9_2
            jmp show_colon_2
            jmp exit:
; ------------<end>-------------

    show_colon_2:
        print _x_2
        jmp show_sec_10_place_2
; ------------<end>-------------

    show_sec_10_place_2:
        mov dl,sec_10_place

        cmp dl,0
        je .jump_render_sec_10_place_0_2
        cmp dl,1
        je .jump_render_sec_10_place_1_2
        cmp dl,2
        je .jump_render_sec_10_place_2_2
        cmp dl,3
        je .jump_render_sec_10_place_3_2
        cmp dl,4
        je .jump_render_sec_10_place_4_2
        cmp dl,5
        je .jump_render_sec_10_place_5_2
        cmp dl,6
        je .jump_render_sec_10_place_6_2
        cmp dl,7
        je .jump_render_sec_10_place_7_2
        cmp dl,8
        je .jump_render_sec_10_place_8_2
        cmp dl,9
        je .jump_render_sec_10_place_9_2

        .jump_render_sec_10_place_0_2:
            print _0_2
            jmp show_sec_1_place_2
            jmp exit:
        .jump_render_sec_10_place_1_2:
            print _1_2
            jmp show_sec_1_place_2
            jmp exit:
        .jump_render_sec_10_place_2_2:
            print _2_2
            jmp show_sec_1_place_2
            jmp exit:
        .jump_render_sec_10_place_3_2:
            print _3_2
            jmp show_sec_1_place_2
            jmp exit:
        .jump_render_sec_10_place_4_2:
            print _4_2
            jmp show_sec_1_place_2
            jmp exit:
        .jump_render_sec_10_place_5_2:
            print _5_2
            jmp show_sec_1_place_2
            jmp exit:
        .jump_render_sec_10_place_6_2:
            print _6_2
            jmp show_sec_1_place_2
            jmp exit:
        .jump_render_sec_10_place_7_2:
            print _7_2
            jmp show_sec_1_place_2
            jmp exit:
        .jump_render_sec_10_place_8_2:
            print _8_2
            jmp show_sec_1_place_2
            jmp exit:
        .jump_render_sec_10_place_9_2:
            print _9_2
            jmp show_sec_1_place_2
            jmp exit:
; ------------<end>-------------

    show_sec_1_place_2:
        mov dl,sec_1_place

        cmp dl,0
        je .jump_render_sec_1_place_0_2
        cmp dl,1
        je .jump_render_sec_1_place_1_2
        cmp dl,2
        je .jump_render_sec_1_place_2_2
        cmp dl,3
        je .jump_render_sec_1_place_3_2
        cmp dl,4
        je .jump_render_sec_1_place_4_2
        cmp dl,5
        je .jump_render_sec_1_place_5_2
        cmp dl,6
        je .jump_render_sec_1_place_6_2
        cmp dl,7
        je .jump_render_sec_1_place_7_2
        cmp dl,8
        je .jump_render_sec_1_place_8_2
        cmp dl,9
        je .jump_render_sec_1_place_9_2

        .jump_render_sec_1_place_0_2:
            print _0_2
            call displayLevel_03
            jmp exit:
        .jump_render_sec_1_place_1_2:
            print _1_2
            call displayLevel_03
            jmp exit:
        .jump_render_sec_1_place_2_2:
            print _2_2
            call displayLevel_03
            jmp exit:
        .jump_render_sec_1_place_3_2:
            print _3_2
            call displayLevel_03
            jmp exit:
        .jump_render_sec_1_place_4_2:
            print _4_2
            call displayLevel_03
            jmp exit:
        .jump_render_sec_1_place_5_2:
            print _5_2
            call displayLevel_03
            jmp exit:
        .jump_render_sec_1_place_6_2:
            print _6_2
            call displayLevel_03
            jmp exit:
        .jump_render_sec_1_place_7_2:
            print _7_2
            call displayLevel_03
            jmp exit:
        .jump_render_sec_1_place_8_2:
            print _8_2
            call displayLevel_03
            jmp exit:
        .jump_render_sec_1_place_9_2:
            print _9_2
            call displayLevel_03
            jmp exit:
; ------------<end>-------------

displayLevel_02 ENDP


; ======================
;      Level_03
; ======================
displayLevel_03 PROC
     newLine

     show_min_10_place_3:
        mov dl,min_10_place

        cmp dl,0
        je .jump_render_min_10_place_0_3
        cmp dl,1
        je .jump_render_min_10_place_1_3
        cmp dl,2
        je .jump_render_min_10_place_2_3
        cmp dl,3
        je .jump_render_min_10_place_3_3
        cmp dl,4
        je .jump_render_min_10_place_4_3
        cmp dl,5
        je .jump_render_min_10_place_5_3
        cmp dl,6
        je .jump_render_min_10_place_6_3
        cmp dl,7
        je .jump_render_min_10_place_7_3
        cmp dl,8
        je .jump_render_min_10_place_8_3
        cmp dl,9
        je .jump_render_min_10_place_9_3

        .jump_render_min_10_place_0_3:
            print _0_3
            jmp show_min_1_place_3
            jmp exit:
        .jump_render_min_10_place_1_3:
            print _1_3
            jmp show_min_1_place_3
            jmp exit:
        .jump_render_min_10_place_2_3:
            print _2_3
            jmp show_min_1_place_3
            jmp exit:
        .jump_render_min_10_place_3_3:
            print _3_3
            jmp show_min_1_place_3
            jmp exit:
        .jump_render_min_10_place_4_3:
            print _4_3
            jmp show_min_1_place_3
            jmp exit:
        .jump_render_min_10_place_5_3:
            print _5_3
            jmp show_min_1_place_3
            jmp exit:
        .jump_render_min_10_place_6_3:
            print _6_3
            jmp show_min_1_place_3
            jmp exit:
        .jump_render_min_10_place_7_3:
            print _7_3
            jmp show_min_1_place_3
            jmp exit:
        .jump_render_min_10_place_8_3:
            print _8_3
            jmp show_min_1_place_3
            jmp exit:
        .jump_render_min_10_place_9_3:
            print _9_3
            jmp show_min_1_place_3
            jmp exit:
; ------------<end>-------------

    show_min_1_place_3:
        mov dl,min_1_place

        cmp dl,0
        je .jump_render_min_1_place_0_3
        cmp dl,1
        je .jump_render_min_1_place_1_3
        cmp dl,2
        je .jump_render_min_1_place_2_3
        cmp dl,3
        je .jump_render_min_1_place_3_3
        cmp dl,4
        je .jump_render_min_1_place_4_3
        cmp dl,5
        je .jump_render_min_1_place_5_3
        cmp dl,6
        je .jump_render_min_1_place_6_3
        cmp dl,7
        je .jump_render_min_1_place_7_3
        cmp dl,8
        je .jump_render_min_1_place_8_3
        cmp dl,9
        je .jump_render_min_1_place_9_3

        .jump_render_min_1_place_0_3:
            print _0_3
            jmp show_colon_3
            jmp exit:
        .jump_render_min_1_place_1_3:
            print _1_3
            jmp show_colon_3
            jmp exit:
        .jump_render_min_1_place_2_3:
            print _2_3
            jmp show_colon_3
            jmp exit:
        .jump_render_min_1_place_3_3:
            print _3_3
            jmp show_colon_3
            jmp exit:
        .jump_render_min_1_place_4_3:
            print _4_3
            jmp show_colon_3
            jmp exit:
        .jump_render_min_1_place_5_3:
            print _5_3
            jmp show_colon_3
            jmp exit:
        .jump_render_min_1_place_6_3:
            print _6_3
            jmp show_colon_3
            jmp exit:
        .jump_render_min_1_place_7_3:
            print _7_3
            jmp show_colon_3
            jmp exit:
        .jump_render_min_1_place_8_3:
            print _8_3
            jmp show_colon_3
            jmp exit:
        .jump_render_min_1_place_9_3:
            print _9_3
            jmp show_colon_3
            jmp exit:
; ------------<end>-------------

    show_colon_3:
        print _x_3
        jmp show_sec_10_place_3
; ------------<end>-------------

    show_sec_10_place_3:
        mov dl,sec_10_place

        cmp dl,0
        je .jump_render_sec_10_place_0_3
        cmp dl,1
        je .jump_render_sec_10_place_1_3
        cmp dl,2
        je .jump_render_sec_10_place_2_3
        cmp dl,3
        je .jump_render_sec_10_place_3_3
        cmp dl,4
        je .jump_render_sec_10_place_4_3
        cmp dl,5
        je .jump_render_sec_10_place_5_3
        cmp dl,6
        je .jump_render_sec_10_place_6_3
        cmp dl,7
        je .jump_render_sec_10_place_7_3
        cmp dl,8
        je .jump_render_sec_10_place_8_3
        cmp dl,9
        je .jump_render_sec_10_place_9_3

        .jump_render_sec_10_place_0_3:
            print _0_3
            jmp show_sec_1_place_3
            jmp exit:
        .jump_render_sec_10_place_1_3:
            print _1_3
            jmp show_sec_1_place_3
            jmp exit:
        .jump_render_sec_10_place_2_3:
            print _2_3
            jmp show_sec_1_place_3
            jmp exit:
        .jump_render_sec_10_place_3_3:
            print _3_3
            jmp show_sec_1_place_3
            jmp exit:
        .jump_render_sec_10_place_4_3:
            print _4_3
            jmp show_sec_1_place_3
            jmp exit:
        .jump_render_sec_10_place_5_3:
            print _5_3
            jmp show_sec_1_place_3
            jmp exit:
        .jump_render_sec_10_place_6_3:
            print _6_3
            jmp show_sec_1_place_3
            jmp exit:
        .jump_render_sec_10_place_7_3:
            print _7_3
            jmp show_sec_1_place_3
            jmp exit:
        .jump_render_sec_10_place_8_3:
            print _8_3
            jmp show_sec_1_place_3
            jmp exit:
        .jump_render_sec_10_place_9_3:
            print _9_3
            jmp show_sec_1_place_3
            jmp exit:
; ------------<end>-------------

    show_sec_1_place_3:
        mov dl,sec_1_place

        cmp dl,0
        je .jump_render_sec_1_place_0_3
        cmp dl,1
        je .jump_render_sec_1_place_1_3
        cmp dl,2
        je .jump_render_sec_1_place_2_3
        cmp dl,3
        je .jump_render_sec_1_place_3_3
        cmp dl,4
        je .jump_render_sec_1_place_4_3
        cmp dl,5
        je .jump_render_sec_1_place_5_3
        cmp dl,6
        je .jump_render_sec_1_place_6_3
        cmp dl,7
        je .jump_render_sec_1_place_7_3
        cmp dl,8
        je .jump_render_sec_1_place_8_3
        cmp dl,9
        je .jump_render_sec_1_place_9_3

        .jump_render_sec_1_place_0_3:
            print _0_3
            call displayLevel_04
            jmp exit:
        .jump_render_sec_1_place_1_3:
            print _1_3
            call displayLevel_04
            jmp exit:
        .jump_render_sec_1_place_2_3:
            print _2_3
            call displayLevel_04
            jmp exit:
        .jump_render_sec_1_place_3_3:
            print _3_3
            call displayLevel_04
            jmp exit:
        .jump_render_sec_1_place_4_3:
            print _4_3
            call displayLevel_04
            jmp exit:
        .jump_render_sec_1_place_5_3:
            print _5_3
            call displayLevel_04
            jmp exit:
        .jump_render_sec_1_place_6_3:
            print _6_3
            call displayLevel_04
            jmp exit:
        .jump_render_sec_1_place_7_3:
            print _7_3
            call displayLevel_04
            jmp exit:
        .jump_render_sec_1_place_8_3:
            print _8_3
            call displayLevel_04
            jmp exit:
        .jump_render_sec_1_place_9_3:
            print _9_3
            call displayLevel_04
            jmp exit:
; ------------<end>-------------

displayLevel_03 ENDP

; ======================
;      Level_04
; ======================
displayLevel_04 PROC
     newLine

     show_min_10_place_4:
        mov dl,min_10_place

        cmp dl,0
        je .jump_render_min_10_place_0_4
        cmp dl,1
        je .jump_render_min_10_place_1_4
        cmp dl,2
        je .jump_render_min_10_place_2_4
        cmp dl,3
        je .jump_render_min_10_place_3_4
        cmp dl,4
        je .jump_render_min_10_place_4_4
        cmp dl,5
        je .jump_render_min_10_place_5_4
        cmp dl,6
        je .jump_render_min_10_place_6_4
        cmp dl,7
        je .jump_render_min_10_place_7_4
        cmp dl,8
        je .jump_render_min_10_place_8_4
        cmp dl,9
        je .jump_render_min_10_place_9_4

        .jump_render_min_10_place_0_4:
            print _0_4
            jmp show_min_1_place_4
            jmp exit:
        .jump_render_min_10_place_1_4:
            print _1_4
            jmp show_min_1_place_4
            jmp exit:
        .jump_render_min_10_place_2_4:
            print _2_4
            jmp show_min_1_place_4
            jmp exit:
        .jump_render_min_10_place_3_4:
            print _3_4
            jmp show_min_1_place_4
            jmp exit:
        .jump_render_min_10_place_4_4:
            print _4_4
            jmp show_min_1_place_4
            jmp exit:
        .jump_render_min_10_place_5_4:
            print _5_4
            jmp show_min_1_place_4
            jmp exit:
        .jump_render_min_10_place_6_4:
            print _6_4
            jmp show_min_1_place_4
            jmp exit:
        .jump_render_min_10_place_7_4:
            print _7_4
            jmp show_min_1_place_4
            jmp exit:
        .jump_render_min_10_place_8_4:
            print _8_4
            jmp show_min_1_place_4
            jmp exit:
        .jump_render_min_10_place_9_4:
            print _9_4
            jmp show_min_1_place_4
            jmp exit:
; ------------<end>-------------

    show_min_1_place_4:
        mov dl,min_1_place

        cmp dl,0
        je .jump_render_min_1_place_0_4
        cmp dl,1
        je .jump_render_min_1_place_1_4
        cmp dl,2
        je .jump_render_min_1_place_2_4
        cmp dl,3
        je .jump_render_min_1_place_3_4
        cmp dl,4
        je .jump_render_min_1_place_4_4
        cmp dl,5
        je .jump_render_min_1_place_5_4
        cmp dl,6
        je .jump_render_min_1_place_6_4
        cmp dl,7
        je .jump_render_min_1_place_7_4
        cmp dl,8
        je .jump_render_min_1_place_8_4
        cmp dl,9
        je .jump_render_min_1_place_9_4

        .jump_render_min_1_place_0_4:
            print _0_4
            jmp show_colon_4
            jmp exit:
        .jump_render_min_1_place_1_4:
            print _1_4
            jmp show_colon_4
            jmp exit:
        .jump_render_min_1_place_2_4:
            print _2_4
            jmp show_colon_4
            jmp exit:
        .jump_render_min_1_place_3_4:
            print _3_4
            jmp show_colon_4
            jmp exit:
        .jump_render_min_1_place_4_4:
            print _4_4
            jmp show_colon_4
            jmp exit:
        .jump_render_min_1_place_5_4:
            print _5_4
            jmp show_colon_4
            jmp exit:
        .jump_render_min_1_place_6_4:
            print _6_4
            jmp show_colon_4
            jmp exit:
        .jump_render_min_1_place_7_4:
            print _7_4
            jmp show_colon_4
            jmp exit:
        .jump_render_min_1_place_8_4:
            print _8_4
            jmp show_colon_4
            jmp exit:
        .jump_render_min_1_place_9_4:
            print _9_4
            jmp show_colon_4
            jmp exit:
; ------------<end>-------------

    show_colon_4:
        print _x_4
        jmp show_sec_10_place_4
; ------------<end>-------------

    show_sec_10_place_4:
        mov dl,sec_10_place

        cmp dl,0
        je .jump_render_sec_10_place_0_4
        cmp dl,1
        je .jump_render_sec_10_place_1_4
        cmp dl,2
        je .jump_render_sec_10_place_2_4
        cmp dl,3
        je .jump_render_sec_10_place_3_4
        cmp dl,4
        je .jump_render_sec_10_place_4_4
        cmp dl,5
        je .jump_render_sec_10_place_5_4
        cmp dl,6
        je .jump_render_sec_10_place_6_4
        cmp dl,7
        je .jump_render_sec_10_place_7_4
        cmp dl,8
        je .jump_render_sec_10_place_8_4
        cmp dl,9
        je .jump_render_sec_10_place_9_4

        .jump_render_sec_10_place_0_4:
            print _0_4
            jmp show_sec_1_place_4
            jmp exit:
        .jump_render_sec_10_place_1_4:
            print _1_4
            jmp show_sec_1_place_4
            jmp exit:
        .jump_render_sec_10_place_2_4:
            print _2_4
            jmp show_sec_1_place_4
            jmp exit:
        .jump_render_sec_10_place_3_4:
            print _3_4
            jmp show_sec_1_place_4
            jmp exit:
        .jump_render_sec_10_place_4_4:
            print _4_4
            jmp show_sec_1_place_4
            jmp exit:
        .jump_render_sec_10_place_5_4:
            print _5_4
            jmp show_sec_1_place_4
            jmp exit:
        .jump_render_sec_10_place_6_4:
            print _6_4
            jmp show_sec_1_place_4
            jmp exit:
        .jump_render_sec_10_place_7_4:
            print _7_4
            jmp show_sec_1_place_4
            jmp exit:
        .jump_render_sec_10_place_8_4:
            print _8_4
            jmp show_sec_1_place_4
            jmp exit:
        .jump_render_sec_10_place_9_4:
            print _9_4
            jmp show_sec_1_place_4
            jmp exit:
; ------------<end>-------------

    show_sec_1_place_4:
        mov dl,sec_1_place

        cmp dl,0
        je .jump_render_sec_1_place_0_4
        cmp dl,1
        je .jump_render_sec_1_place_1_4
        cmp dl,2
        je .jump_render_sec_1_place_2_4
        cmp dl,3
        je .jump_render_sec_1_place_3_4
        cmp dl,4
        je .jump_render_sec_1_place_4_4
        cmp dl,5
        je .jump_render_sec_1_place_5_4
        cmp dl,6
        je .jump_render_sec_1_place_6_4
        cmp dl,7
        je .jump_render_sec_1_place_7_4
        cmp dl,8
        je .jump_render_sec_1_place_8_4
        cmp dl,9
        je .jump_render_sec_1_place_9_4

        .jump_render_sec_1_place_0_4:
            print _0_4
            call displayLevel_05
            jmp exit:
        .jump_render_sec_1_place_1_4:
            print _1_4
            call displayLevel_05
            jmp exit:
        .jump_render_sec_1_place_2_4:
            print _2_4
            call displayLevel_05
            jmp exit:
        .jump_render_sec_1_place_3_4:
            print _3_4
            call displayLevel_05
            jmp exit:
        .jump_render_sec_1_place_4_4:
            print _4_4
            call displayLevel_05
            jmp exit:
        .jump_render_sec_1_place_5_4:
            print _5_4
            call displayLevel_05
            jmp exit:
        .jump_render_sec_1_place_6_4:
            print _6_4
            call displayLevel_05
            jmp exit:
        .jump_render_sec_1_place_7_4:
            print _7_4
            call displayLevel_05
            jmp exit:
        .jump_render_sec_1_place_8_4:
            print _8_4
            call displayLevel_05
            jmp exit:
        .jump_render_sec_1_place_9_4:
            print _9_4
            call displayLevel_05
            jmp exit:
; ------------<end>-------------

displayLevel_04 ENDP

; ======================
;      Level_05
; ======================
displayLevel_05 PROC
     newLine

     show_min_10_place_5:
        mov dl,min_10_place

        cmp dl,0
        je .jump_render_min_10_place_0_5
        cmp dl,1
        je .jump_render_min_10_place_1_5
        cmp dl,2
        je .jump_render_min_10_place_2_5
        cmp dl,3
        je .jump_render_min_10_place_3_5
        cmp dl,4
        je .jump_render_min_10_place_4_5
        cmp dl,5
        je .jump_render_min_10_place_5_5
        cmp dl,6
        je .jump_render_min_10_place_6_5
        cmp dl,7
        je .jump_render_min_10_place_7_5
        cmp dl,8
        je .jump_render_min_10_place_8_5
        cmp dl,9
        je .jump_render_min_10_place_9_5

        .jump_render_min_10_place_0_5:
            print _0_5
            jmp show_min_1_place_5
            jmp exit:
        .jump_render_min_10_place_1_5:
            print _1_5
            jmp show_min_1_place_5
            jmp exit:
        .jump_render_min_10_place_2_5:
            print _2_5
            jmp show_min_1_place_5
            jmp exit:
        .jump_render_min_10_place_3_5:
            print _3_5
            jmp show_min_1_place_5
            jmp exit:
        .jump_render_min_10_place_4_5:
            print _4_5
            jmp show_min_1_place_5
            jmp exit:
        .jump_render_min_10_place_5_5:
            print _5_5
            jmp show_min_1_place_5
            jmp exit:
        .jump_render_min_10_place_6_5:
            print _6_5
            jmp show_min_1_place_5
            jmp exit:
        .jump_render_min_10_place_7_5:
            print _7_5
            jmp show_min_1_place_5
            jmp exit:
        .jump_render_min_10_place_8_5:
            print _8_5
            jmp show_min_1_place_5
            jmp exit:
        .jump_render_min_10_place_9_5:
            print _9_5
            jmp show_min_1_place_5
            jmp exit:
; ------------<end>-------------

    show_min_1_place_5:
        mov dl,min_1_place

        cmp dl,0
        je .jump_render_min_1_place_0_5
        cmp dl,1
        je .jump_render_min_1_place_1_5
        cmp dl,2
        je .jump_render_min_1_place_2_5
        cmp dl,3
        je .jump_render_min_1_place_3_5
        cmp dl,4
        je .jump_render_min_1_place_4_5
        cmp dl,5
        je .jump_render_min_1_place_5_5
        cmp dl,6
        je .jump_render_min_1_place_6_5
        cmp dl,7
        je .jump_render_min_1_place_7_5
        cmp dl,8
        je .jump_render_min_1_place_8_5
        cmp dl,9
        je .jump_render_min_1_place_9_5

        .jump_render_min_1_place_0_5:
            print _0_5
            jmp show_colon_5
            jmp exit:
        .jump_render_min_1_place_1_5:
            print _1_5
            jmp show_colon_5
            jmp exit:
        .jump_render_min_1_place_2_5:
            print _2_5
            jmp show_colon_5
            jmp exit:
        .jump_render_min_1_place_3_5:
            print _3_5
            jmp show_colon_5
            jmp exit:
        .jump_render_min_1_place_4_5:
            print _4_5
            jmp show_colon_5
            jmp exit:
        .jump_render_min_1_place_5_5:
            print _5_5
            jmp show_colon_5
            jmp exit:
        .jump_render_min_1_place_6_5:
            print _6_5
            jmp show_colon_5
            jmp exit:
        .jump_render_min_1_place_7_5:
            print _7_5
            jmp show_colon_5
            jmp exit:
        .jump_render_min_1_place_8_5:
            print _8_5
            jmp show_colon_5
            jmp exit:
        .jump_render_min_1_place_9_5:
            print _9_5
            jmp show_colon_5
            jmp exit:
; ------------<end>-------------

    show_colon_5:
        print _x_5
        jmp show_sec_10_place_5
; ------------<end>-------------

    show_sec_10_place_5:
        mov dl,sec_10_place

        cmp dl,0
        je .jump_render_sec_10_place_0_5
        cmp dl,1
        je .jump_render_sec_10_place_1_5
        cmp dl,2
        je .jump_render_sec_10_place_2_5
        cmp dl,3
        je .jump_render_sec_10_place_3_5
        cmp dl,4
        je .jump_render_sec_10_place_4_5
        cmp dl,5
        je .jump_render_sec_10_place_5_5
        cmp dl,6
        je .jump_render_sec_10_place_6_5
        cmp dl,7
        je .jump_render_sec_10_place_7_5
        cmp dl,8
        je .jump_render_sec_10_place_8_5
        cmp dl,9
        je .jump_render_sec_10_place_9_5

        .jump_render_sec_10_place_0_5:
            print _0_5
            jmp show_sec_1_place_5
            jmp exit:
        .jump_render_sec_10_place_1_5:
            print _1_5
            jmp show_sec_1_place_5
            jmp exit:
        .jump_render_sec_10_place_2_5:
            print _2_5
            jmp show_sec_1_place_5
            jmp exit:
        .jump_render_sec_10_place_3_5:
            print _3_5
            jmp show_sec_1_place_5
            jmp exit:
        .jump_render_sec_10_place_4_5:
            print _4_5
            jmp show_sec_1_place_5
            jmp exit:
        .jump_render_sec_10_place_5_5:
            print _5_5
            jmp show_sec_1_place_5
            jmp exit:
        .jump_render_sec_10_place_6_5:
            print _6_5
            jmp show_sec_1_place_5
            jmp exit:
        .jump_render_sec_10_place_7_5:
            print _7_5
            jmp show_sec_1_place_5
            jmp exit:
        .jump_render_sec_10_place_8_5:
            print _8_5
            jmp show_sec_1_place_5
            jmp exit:
        .jump_render_sec_10_place_9_5:
            print _9_5
            jmp show_sec_1_place_5
            jmp exit:
; ------------<end>-------------

    show_sec_1_place_5:
        mov dl,sec_1_place

        cmp dl,0
        je .jump_render_sec_1_place_0_5
        cmp dl,1
        je .jump_render_sec_1_place_1_5
        cmp dl,2
        je .jump_render_sec_1_place_2_5
        cmp dl,3
        je .jump_render_sec_1_place_3_5
        cmp dl,4
        je .jump_render_sec_1_place_4_5
        cmp dl,5
        je .jump_render_sec_1_place_5_5
        cmp dl,6
        je .jump_render_sec_1_place_6_5
        cmp dl,7
        je .jump_render_sec_1_place_7_5
        cmp dl,8
        je .jump_render_sec_1_place_8_5
        cmp dl,9
        je .jump_render_sec_1_place_9_5

        .jump_render_sec_1_place_0_5:
            print _0_5
            call serviceDecider
            jmp exit:
        .jump_render_sec_1_place_1_5:
            print _1_5
            call serviceDecider
            jmp exit:
        .jump_render_sec_1_place_2_5:
            print _2_5
            call serviceDecider
            jmp exit:
        .jump_render_sec_1_place_3_5:
            print _3_5
            call serviceDecider
            jmp exit:
        .jump_render_sec_1_place_4_5:
            print _4_5
            call serviceDecider
            jmp exit:
        .jump_render_sec_1_place_5_5:
            print _5_5
            call serviceDecider
            jmp exit:
        .jump_render_sec_1_place_6_5:
            print _6_5
            call serviceDecider
            jmp exit:
        .jump_render_sec_1_place_7_5:
            print _7_5
            call serviceDecider
            jmp exit:
        .jump_render_sec_1_place_8_5:
            print _8_5
            call serviceDecider
            jmp exit:
        .jump_render_sec_1_place_9_5:
            print _9_5
            call serviceDecider
            jmp exit:
; ------------<end>-------------

displayLevel_05 ENDP

serviceDecider PROC
    mov dl,service
    cmp dl,2
    je serviceStopWatchLoop
    jl serviceTimerLoop
    jg serviceClockClose

    serviceTimerLoop:
        call loopStartTimer
        jmp exit:

    serviceStopWatchLoop:
        
        jmp exit:
        
    serviceClockClose:
        
        jmp exit:
serviceDecider ENDP

loopStartTimer PROC
     waitFor1Sec
     sub total_sec, 1
     separate
     setSecPlaces
     setMinPlaces
     call displayTimer
loopStartTimer ENDP

startTimer PROC
     mov cx,total_sec
     loopx:
          waitFor1Sec
          sub total_sec, 1
          mov cx,total_sec
          separate
          setSecPlaces
          setMinPlaces
          ; displayClicheTimer
          call displayTimer
          loop loopx
startTimer ENDP

setClockTime PROC
    xor ax,ax
    mov ah,2CH          ; To get System Time
    int 21h
    MOV min,ch          ; Hour is in CH | Hour goes to min
    MOV sec,cl          ; Hour is in CL | Min goes to sec

    ;making 12 hour format
    xor ax,ax
    mov al, min
    mov bl, 12
    div bl
    mov min, ah

    setSecPlaces
    setMinPlaces

    call displayTimer
setClockTime ENDP

displayWelcomePrompt MACRO
        print         welcomePrompt01
        print         welcomePrompt02
        print         welcomePrompt03

        print         selectServicePromptStart
        print         selectServicePrompt01
        print         selectServicePrompt02
        print         selectServicePrompt03
        print         selectServicePrompt04
        print         selectServicePrompt05
        print         selectServicePromptEnd
        print         selectServicePromptFinal
ENDM

displayTimerPrompt MACRO
    clearDisplay
    print timerPromptStart
    print timerPromptTimer
    print timerPromptEnd
    print timerPromptSet
ENDM

displayStopwatchPrompt MACRO
    clearDisplay
    print stopwatchPrompt
ENDM

displayClockPrompt MACRO
    clearDisplay
    print clockPrompt
ENDM

takeServiceInput MACRO
    mov ah,1
    int 21h
    sub al, 48
    mov service,al 
ENDM

takeTimerInput MACRO
    mov ah,1
    int 21h
    sub al, 48
    mov bl, al
    
    xor bh,bh
    
    mov ax,bx
    
    mul sec_multiplier
    mov total_sec,ax
ENDM

main proc
               mov ax, @data
               mov ds, ax

                displayWelcomePrompt
                takeServiceInput

                mov dl,service
                cmp dl,2
                je serviceStopWatch
                jl serviceTimer
                jg serviceClock

                serviceTimer:
                    displayTimerPrompt
                    takeTimerInput
                    call startTimer
                    jmp exit:

                serviceStopWatch:
                    displayStopwatchPrompt
                    jmp exit:
                    
                serviceClock:
                    displayClockPrompt
                    call setClockTime
                    jmp exit:

     exit:    
              mov      ah, 4ch
              int      21h
main endp
    
end main
    
