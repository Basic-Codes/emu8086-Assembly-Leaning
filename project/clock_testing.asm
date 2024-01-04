.MODEL SMALL
.DATA
        sec          db ?
        min          db ?

        sec_1_place  db ?
        sec_10_place db ?
        min_1_place  db ?
        min_10_place db ?

.CODE
        START:MOV AX,@DATA
              MOV DS,AX

        HOUR: 
              MOV AH,2CH          ; To get System Time
              INT 21H
              MOV AL,CH           ; Hour is in CH
              MOV min,CH          ; Hour is in CH


        ;Display Part
DISP PROC
              MOV DL,BH           ; Since the values are in BX, BH Part
              ADD DL,30H          ; ASCII Adjustment
              MOV AH,02H          ; To Print in DOS
              INT 21H
              MOV DL,BL           ; BL Part
              ADD DL,30H          ; ASCII Adjustment
              MOV AH,02H          ; To Print in DOS
              INT 21H
              RET
DISP ENDP                         ; End Disp Procedure


END START      ; End of MAIN