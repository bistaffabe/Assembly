title letra
.model small
.data
    texto  db "Digite um caractere: $"
    texto1 db "A letra maiscula correspodente eh: $"
.code
main proc

         mov ax, @data    ;acesso as variaveis
         mov ds,ax

         mov ah,9         ;utilizando a funcao 9 para imprimir uma string
         lea dx,texto
         int 21h

         mov ah,1         ;Funcao 1: ler um caractere e salvando em al
         int 21h

         mov bl,al        ;movendo o caractere lido para bl

         Sub bl,20h       ;subtraindo 20hexadecimal do caractere para se tornar maisculo
         int 21h

         mov ah,2         ;utiliza a funcao (2) junto o código ASC Line Feed pra ""pular uma linha"
         mov dl,10
         int 21h

         mov ah,2         ;utiliza a funcao (2) junto com o caracter Carriage Return para mover o cursor para o lado esquerdo da tela
         mov dl,13
         int 21h

         mov ah,9
         lea dx,texto1    ;função 9 para imprimir uma string
         int 21h

         mov ah,2
         mov dl,bl        ;Funcao (2) para imprimir o caractere que foi digitado pelo usuario
         int 21h


         mov ah,4ch       ;encerrando o programa
         int 21h








main endp
end main

