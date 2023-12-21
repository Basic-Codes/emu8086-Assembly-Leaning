.model small
.stack 256

.data
     promptMsg db 'Enter a number: $'
     msg1      db 10,13,'Even $'
     msg2      db 10,13,'Odd $'
.code

main proc
                  mov ax, @data
                  mov ds, ax

     ; Display prompt
                  mov ah, 9
                  lea dx, promptMsg
                  int 21h
               
     ; Read a digit
                  mov ah,1              ;input a
                  int 21h
                  sub al, 48
                  mov cl,al
                  
                  xor ax,ax
                
                  mov al,cl
                  mov bl,2
                  div bl                ;al=al/bl
         
     ; Here al contains Quotient
     ; Here ah contains Remainder
                  mov cl, al
                  mov ch, ah
         
                  cmp ch,0
                  je  isDivisible
                  jmp notDivisible

     isDivisible: 
                  mov ah, 9
                  lea dx, msg1
                  int 21h
                  jmp exit:

     notDivisible:
                  mov ah, 9
                  lea dx, msg2
                  int 21h
                  jmp exit:
         
    
     exit:        
                  mov ah, 4ch
                  int 21h
main endp
    
end main
    
