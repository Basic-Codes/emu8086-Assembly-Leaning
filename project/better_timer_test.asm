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

displayTimer ENDP


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

    setSecPlaces
    setMinPlaces

    ; call displayTimer
setClockTime ENDP

displayPrompt MACRO
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

                displayPrompt
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
    
