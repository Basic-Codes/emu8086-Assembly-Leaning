.model small
.stack 256

.data
    totalSec      dw 299
    sec           db ?
    min           db ?
    secMultiplier db 60

.code

main proc
         mov ax, @data
         mov ds, ax

         mov ax, totalSec
         mov bl,secMultiplier
         div bl

    ; Here al contains Quotient
    ; Here ah contains Remainder
         mov cl, al
         mov ch, ah
    
         mov min, cl
         mov sec, ch
    
    exit:
         mov ah, 4ch
         int 21h
main endp
    
end main
    
