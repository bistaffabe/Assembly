; Escreva um programa que inverta a ordem de um vetor de 7 posições, isto é, o primeiro
; elemento se tornará o último, o último se tornará o primeiro e assim sucessivamente. Ler o vetor
; e imprimir depois de inverter a ordem. NÃO UTILIZAR UM VETOR AUXILIAR. Utilizar BX, SI e DI
; nas diversas manipulação de vetor (ler, inverter e imprimir)

TITLE VETOR5
.MODEL SMALL     
.DATA          
    VETOR DB 7 DUP('*')
.CODE        
MAIN PROC     
    MOV AX,@DATA  
    MOV DS,AX  

    LEA BX, VETOR
    MOV CX, 7       
    CALL LEIA
    call imprime          
    CALL INVERTA
    CALL IMPRIME
    MOV AH,4CH 
    INT 21H 
MAIN ENDP

 LEIA PROC 
    XOR BX,BX
    MOV AH,01
LER:  
    INT 21H 
    MOV [BX],AL              
    INC BX 
    LOOP LER
    RET 
LEIA ENDP 

INVERTA PROC
    XOR BX,BX 
    MOV SI,6
    MOV CX,3

 INVERT: 

    MOV AL,VETOR[BX]
    XCHG AL,VETOR[SI]
    MOV VETOR[BX],AL
    DEC SI
    INC BX
    LOOP INVERT
    RET

INVERTA ENDP 

IMPRIME PROC 
    XOR BX,BX
    MOV AH,02 
    mov dl,10
    int 21h
    MOV CX,7
 IMPR:
    MOV DL,VETOR[BX] 
    INT 21H 
    inc BX 
    LOOP IMPR 
    RET
IMPRIME ENDP  
END MAIN          