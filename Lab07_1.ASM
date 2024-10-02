title mutiplicacao
.model small
.stack 100h
.data 
    Mens db 10,13,'MULTIPLICANDO: $'
    Mens1 db 10,13,'MULTIPLICADOR: $'
    Mens2 db 10,13,'PRODUTO: $'
.code 
MAIN PROC  
    ;Acesso as variaveis  
    MOV AX,@data
    MOV DS, AX

    ;imprime a string 
    MOV AH,09
    LEA DX,Mens
    INT 21H 

    ;lê um caracter 
    MOV AH,01
    INT 21H 
    ;salva o multiplicando em bl
    MOV Bl,AL

    ;transforma um carcater em um numero 
    AND BL,0Fh

    ;imprime uma string
    MOV AH,09
    LEA DX,Mens1
    INT 21H 

    ;lê um caracter
    MOV AH,01
    INT 21H 
    ;salva o multiplicador em bh 
    MOV BH,AL
    
    ;transforma o caracter em um numero 
    AND BH,0Fh

    ;se o multiplicando for igual a zero já salta para fim 
    CMP BL,'0'
    JE FIM

    ;se o multiplicador for igual a zero já salta para fim 
    CMP BH,'0'
    JE FIM

    ;zera o cl
    XOR CL,CL 

MULTIPLICA: 
    ADD CL,BL   ;adiciona ao contador o mutiplicando
    DEC BH      ;decrementa o multiplicador 
    JNZ MULTIPLICA     ; se o multiplicador nao for igual a zero salta para o rotulo multiplica 

    

FIM: 
    ;imprime uma string 
    MOV AH,09
    LEA DX,Mens2 
    int 21h 

    ;adicona 30h no numero para se transformar em caracter
    OR cl,30h
    
    ;imprime o caracter 
    mov ah,02
    mov dl,cl
    int 21h 

    ;finaliza o programa 
    MOV AH,4ch
    INT 21
    
MAIN ENDP 
END MAIN 