.model small
.stack 256

.data
    myString db 'Hello World! $'
.code

calMacro MACRO params
    mov      ah,9
    lea      dx,params
    int      21h
ENDM

main proc
    mov ax,@data
    mov ds,ax

    mov      ah,2
    mov      dl,248
    int      21h

    calMacro myString

exit:    
    mov      ah, 4ch
    int      21h
main endp


    
end main
