; Escreva um programa que inverta a ordem de um vetor de 7 posições, isto é, o primeiro
; elemento se tornará o último, o último se tornará o primeiro e assim sucessivamente. Ler o vetor
; e imprimir depois de inverter a ordem. NÃO UTILIZAR UM VETOR AUXILIAR. Utilizar BX, SI e DI
; nas diversas manipulação de vetor (ler, inverter e imprimir)

TITLE VETOR5
.MODEL SMALL     
.DATA          
    VETOR DB 1,2,3,4,5,6,7
.CODE        
MAIN PROC     
    MOV AX,@DATA  
    MOV DS,AX  
    LEA BX, VETOR
    MOV CX, 7       
    CALL PROGRAMA

    MOV AH,4CH 
    INT 21H 
MAIN ENDP 

PROGRAMA PROC 
    ; LEA BX,VETOR 
    ; MOV CX,7

 LEIA: 
    MOV AH,01
    INT 21H 
    MOV VETOR[BX],AL              
    INC BX 
    LOOP LEIA 

    MOV BX,6 
    MOV CX,7

 IMPRIME:
    MOV AH,02 
    MOV DL,VETOR[BX]
    OR DL,30H 
    INT 21H 
    DEC BX 
    LOOP IMPRIME 
    RET
PROGRAMA ENDP        
END MAIN          