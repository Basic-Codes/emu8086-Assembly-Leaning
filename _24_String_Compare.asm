include 'emu8086.inc'
.model small
.stack 100h
.data
      a    db 'Hello'
      b    db 'World'

      msg1 db 10,13,'Both are equal $'
      msg2 db 10,13,'Both are different $'

.code
main proc
              mov  ax,@data
              mov  ds,ax

              mov  si, offset a
              mov  di, offset b

              mov  cx,5

      loopx:  
              mov  ax,[si]
              mov  bx,[di]

              cmp  ax,bx
              jne  NotSame
         
              inc  si
              inc  di
              loop loopx

      NotSame:
              mov  ah, 9
              lea  dx, msg2
              int  21h
              jmp  exit:
    
      exit:   
              mov  ah,4ch
              int  21h
main endp
end main
    