title vetor4
.model small
.data
    VETOR DB 1,1,1,2,2,2
.code
main proc
          MOV  AX,@data        ;acesso as variaveis
          MOV  DS,AX
        CALL PROGRAMA
        MOV  AH,4CH
          INT  21h
main endp
PROGRAMA PROC 
     XOR  DL,DL           ;zera o registrador
          MOV  CX,6            ;adiciona 6 ao contador
          XOR  DI,DI           ;zera o registrador

    VOLTA:
          MOV  DL,VETOR[DI]    ;dl recebe o elemento do vetor
          INC  DI              ;incrementa em bx
          OR   DL,30H          ;transforma o numero em caracter OR DL,30h
          MOV  AH,02           ;funcao dois: para imprimir caracter
          INT  21H             ;realiza a funcao
          LOOP VOLTA           ;decrementa de dx
          RET
PROGRAMA ENDP 
end main 