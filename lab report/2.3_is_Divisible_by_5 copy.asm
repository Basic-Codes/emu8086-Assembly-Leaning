.model small
.stack 256

.data
     promptMsg db 'Enter a number: $'
     msg1      db 10,13,'Is Divisible by 5 $'
     msg2      db 10,13,'Not Divisible by 5 $'
.code

main proc
                  mov ax, @data
                  mov ds, ax
                  
                  xor ax,ax
                
                  mov al,35
                  mov bl,5
                  div bl               ;al=al/bl
         
     ; Here al contains Quotient
     ; Here ah contains Remainder
                  mov cl, al
                  mov ch, ah

     ; Remainder
                  mov ah,2             ;output
                  mov dl,ch
                  add dl,48
                  int 21h
         
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
    
