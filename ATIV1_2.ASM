title eco
.model small
.code
main proc

         mov ah,2      ;funcao (2): imprime um caractere na tela
         mov dl,"?"
         int 21h

         mov ah,1      ;lê um caractere e salva em AL
         int 21h

         mov bl,al     ;aqui passa para bl, pq se ficasse al ele seria apagado

         mov ah,2      ;utiliza a funcao (2) junto o código ASC Line Feed pra ""pular uma linha"
         mov dl,10
         int 21h

         mov ah,2      ;utiliza a funcao (2) junto com o caracter Carriage Return para mover o cursor para o lado esquerdo da tela
         mov dl,13
         int 21h

         mov ah,2
         mov dl,bl     ;Funcao (2) para imprimir o caractere que foi digitado pelo usuario
         int 21h

         mov ah,4ch    ;finaliza o programa
         int 21h

main endp
end main

