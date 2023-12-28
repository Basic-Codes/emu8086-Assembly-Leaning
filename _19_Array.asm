include 'emu8086.inc'
.model small
.stack 256

.data
    array db 2,6,1,5,7

.code
main proc
          mov   ax,@data
          mov   ds,ax

          mov   si, offset array

          mov   cx,5                ;cx will hold how many times the array will run

          print "Your array: "
    loopx:
          mov   ah,2                ;output
          mov   dl,[si]
          add   dl,48
          int   21h
         
          inc   si
          loop  loopx
    
    exit: 
          mov   ah, 4ch
          int   21h
main endp
    
end main