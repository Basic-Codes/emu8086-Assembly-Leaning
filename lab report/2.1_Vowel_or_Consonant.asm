.model small
.stack 256

.data
    promptMsg db 'Enter a character: $'
    msg1      db 10,13,'Vowel $'
    msg2      db 10,13,'Consonant $'
    msg3      db 10,13,'Neither $'
.code

main proc
                mov ax, @data
                mov ds, ax

    ; Display prompt
                mov ah, 9
                lea dx, promptMsg
                int 21h
    
    ; Read a Char
                mov ah,1             ;input a
                int 21h
                mov bl,al
          
    ;If Else
                cmp bl,97
                jge G_T_97
                jmp L_T_97
    
    G_T_97:     
                cmp bl,122
                jle isVowel
                jmp isOthers
            
    
    L_T_97:     
                cmp bl,65
                jge G_T_65
                jmp isOthers

    G_T_65:     
                cmp bl,90
                jle isConsonant
                jmp isOthers

    isVowel:    
                mov ah, 9
                lea dx, msg1
                int 21h
                jmp exit:
    isConsonant:
                mov ah, 9
                lea dx, msg2
                int 21h
                jmp exit:
    isOthers:   
                mov ah, 9
                lea dx, msg3
                int 21h
                jmp exit:

  
    
    exit:       
                mov ah, 4ch
                int 21h
main endp
    
end main
    
