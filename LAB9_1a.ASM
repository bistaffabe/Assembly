title vetor1
.model small
.data
    VETOR DB 1,1,1,2,2,2    ;vetor double bit
.code
main proc
          MOV  AX,@data    ;acesso as variaveis
          MOV  DS,AX
          CALL PROGRAMA 
          MOV  AH,4CH
          INT  21H
main endp

PROGRAMA PROC 
          XOR  DL,DL       ;zera o registrador
          MOV  CX,6        ;contador recebe 6
          LEA  BX,VETOR    ;bx aponta para o primeiro elemento do VETOR

    VOLTA:
          MOV  DL,[BX]     ;dl recebe o elemento do vetor
          INC  BX          ;incrementa um em bx
          OR DL,30H      ;transforma o numero em caracter OR DL,30h
          MOV  AH,02       ;funcao dois: para imprimir caracter
          INT  21H         ;realiza a funcao
          LOOP VOLTA       ;decrementa de dx
          RET
PROGRAMA ENDP 
END MAIN