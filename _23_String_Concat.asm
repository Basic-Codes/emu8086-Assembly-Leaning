include 'emu8086.inc'
.model small
.stack 100h
.data
      a    db 'Hello'
      b    db 'World'

.code
main proc
            mov  ax,@data
            mov  ds,ax

            mov  si, offset a
            mov  di, offset b

            mov  cx,5

      loopx:
            mov  bx,[si]

            mov  ah,2
            mov  dx,bx
            int  21h
         
            inc  si
            loop loopx

            mov  cx,5

      loopy:
            mov  bx,[di]

            mov  ah,2
            mov  dx,bx
            int  21h
         
            inc  di
            loop loopy
    
      exit: 
            mov  ah,4ch
            int  21h
main endp
end main
    