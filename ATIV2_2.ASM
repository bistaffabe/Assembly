title numero
.model small
.data
    texto  db "Digite um numero primeiro: $"
    texto1 db "Digite um segundo numero: $"
    texto2 db "A soma dos dois numeros eh: $"
.code
main proc

         mov ax, @data    ;acesso as variaveis
         mov ds,ax

         mov ah,9         ;utilizando a função 9 para imprimir uma string
         lea dx,texto
         int 21h

         mov ah,1         ;Funcao 1: ler um caractere e salvando em al
         int 21h          ;lendo primeiro numero

         mov bl,al        ;movendo o caractere lido para bl

         Sub bl,30h       ;subtraindo 30 hexadecimal para que seja transformado em decimal

         mov ah,2         ;utiliza a funcao (2) junto o código ASC Line Feed pra ""pular uma linha"
         mov dl,10
         int 21h

         mov ah,2         ;utiliza a funcao (2) junto com o caracter Carriage Return para mover o cursor para o lado esquerdo da tela
         mov dl,13
         int 21h

         mov ah,9         ;função 9 para imprimir uma string
         lea dx,texto1
         int 21h

         mov ah,1         ;função 1 para ler um carctere e salva em al
         int 21h          ;lendo o segundo numero

         mov bh,al        ;movendo o caractere para bh, para que ele fique salvo

         Sub bh,30h       ;subtraindo 30 hexadecimal para que o numero se torne decimal


         ADD bl,bh        ;somando os dois numeros que foram salvos em bh e em bl
         int 21h          ;a soma ficara salva em bl

         mov ah,9         ;função 9 para imprimir uma string
         lea dx,texto2
         int 21h

         add bl,30h       ;removendo 30hexadecimal para que a soma fique em decimal

         mov ah,2
         mov dl,bl        ;imprimindo o caracter (soma dos numeros)
         int 21h

         mov ah,4ch       ;encerrando o programa
         int 21h

main endp
end main