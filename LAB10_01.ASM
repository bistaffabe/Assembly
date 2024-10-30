; Faça um programa que imprima a matriz abaixo, como uma matriz (linhas e colunas). Usar
; procedimentos e macros
TITLE MATRIZ1
.MODEL SMALL 
pula_linha MACRO
               pop  ax
               pop  dx
               mov  ah,02
               mov  dl,10
               int  21h
               push ax
               push dx
endm

.DATA
    MATRIZ DB 1,2,3,4
           DB 4,3,2,1
           DB 5,6,7,8
           DB 8,7,6,5
.CODE

MAIN PROC
          MOV        AX,@DATA             ;acesso das variáveis
          MOV        DS,AX

          XOR        BX,BX                ;zera o registrador das colunas
          XOR        SI,SI                ;zera o resgitrador das linhas
          CALL       LENDO                ;chama a função

          MOV        AH,4CH               ;finaliza o programa
          INT        21H
MAIN ENDP

LENDO PROC
          MOV        AH,02                ;funcao para imprimir
          MOV        DI,4                 ;registrador que é decrementado para que imprima 4 linhas
    PRE:  
          XOR        SI,SI                ;registrador zerado
          MOV        CX,4                 ;contador para que seja impresso 4 elementos
          pula_linha
    ; MOV DL,10   ;pula linha
    ; INT 21H
    
    LER:  
          MOV        DL,MATRIZ[BX][SI]    ;manipulação de matriz
          OR         DL,30H               ;transforma em caracter
          INT        21H
          INC        SI                   ;incrementa o registrador de colunas
          LOOP       LER

          ADD        BX,4                 ;adiciona ao registrador de linhas 4
          DEC        DI                   ;decrementa o registrador, ja que uma linha foi impressa
          JZ         SAI                  ;se for zero sai
          JMP        PRE
    SAI:  
          RET
LENDO ENDP
END MAIN 