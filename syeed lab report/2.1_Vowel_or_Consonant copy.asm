.model small
.stack 256

.data
    vowel     db 'Vowel $'
    consonant db 'Consonant $'
.code

main proc
                  mov ax, @data
                  mov ds, ax
                
                  mov ah,1
                  int 21h
                  mov bl,al

                  cmp bl,97
                  jge JUMP01
                  jmp JUMP02
    
    JUMP01:       
                  cmp bl,122
                  jle JUMP04
            
    
    JUMP02:       
                  cmp bl,65
                  jge JUMP03

    JUMP03:       
                  cmp bl,90
                  jle JumpConsonant

    JUMP04:       
                  mov ah, 9
                  lea dx, vowel
                  int 21h
                  jmp exit:
    JumpConsonant:
                  mov ah, 9
                  lea dx, consonant
                  int 21h
                  jmp exit:

  
    
    exit:         
                  mov ah, 4ch
                  int 21h
main endp
    
end main
    
