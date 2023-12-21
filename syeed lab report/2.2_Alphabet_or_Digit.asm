.model small
.stack 256

.data
    alphabet db 10,13,'Alphabet $'
    digit    db 10,13,'Digit $'
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
                  jle JUMPVowel
                  jmp JUMPAlphabet

    JUMP02:       
                  cmp bl,65
                  jge JUMP03
                  jmp JUMPAlphabet

    JUMP03:       
                  cmp bl,90
                  jle JUMPConsonant
                  jmp JUMPAlphabet

    JUMPVowel:    
                  mov ah, 9
                  lea dx, alphabet
                  int 21h
                  jmp exit:

    JUMPConsonant:
                  mov ah, 9
                  lea dx, alphabet
                  int 21h
                  jmp exit:

    JUMPAlphabet: 
                  cmp bl,48
                  jge JUMP05

    JUMP05:       
                  cmp bl,57
                  jle JUMPDIGIT

    JUMPDIGIT:    
                  mov ah, 9
                  lea dx, digit
                  int 21h
                  jmp exit:

  
    
    exit:         
                  mov ah, 4ch
                  int 21h
main endp
    
end main
    
