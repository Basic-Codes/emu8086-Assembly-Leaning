include 'emu8086.inc'
.model small
.stack 100h
.data
    string db 'Hello World!'

.code
main proc
          mov  ax,@data
          mov  ds,ax

          mov  si, offset string

          mov  cx,12

    loopx:
          mov  bx,[si]
          push bx
         
          inc  si
          loop loopx
          
          mov  cx,12

    loopy:
          pop  dx
          mov  ah,2
          int  21h
         
          dec  si
          loop loopy
    
    exit: 
          mov  ah,4ch
          int  21h
main endp
end main
    