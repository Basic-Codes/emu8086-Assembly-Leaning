.MODEL SMALL
.DATA
.CODE
        START:  MOV  AX,@DATA
                MOV  DS,AX

    
        HOUR:   
                MOV  AH,2CH
                INT  21H
                MOV  AL,CH
                AAM
                MOV  BX,AX
                CALL DISP

                MOV  DL,':'
                MOV  AH,02H
                INT  21H

    
        MINUTES:
                MOV  AH,2CH
                INT  21H
                MOV  AL,CL
                AAM
                MOV  BX,AX
                CALL DISP

                MOV  DL,':'
                MOV  AH,02H
                INT  21H

    
        Seconds:
                MOV  AH,2CH
                INT  21H
                MOV  AL,DH
                AAM
                MOV  BX,AX
                CALL DISP


    

                MOV  AH,4CH
                INT  21H

    
DISP PROC
                MOV  DL,BH
                ADD  DL,30H
                MOV  AH,02H
                INT  21H
                MOV  DL,BL
                ADD  DL,30H
                MOV  AH,02H
                INT  21H
                RET
DISP ENDP


END START      