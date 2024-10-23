title caractere             
.model small

.data
    mens1 db "Digite um caractere:$"
    mens2 db "O caractere digitado foi:$"
.code
main proc
         mov ax,@data    ;acesso as variaveis
         mov ds,ax

         mov ah,9
         lea dx,mens1    ;imprime a mensagem 1
         int 21h

         mov ah,1
         int 21h         ;lê um caractere e salva em al

         mov bl,al       ;copia em bl, porque se ficasse em al ele seria perdido

         mov ah,2
         mov dl,10       ;"pular uma linha"
         int 21h

         mov ah,2
         mov dl,13       ;move o cursor para a esquerda
         int 21h

         mov ah,9
         lea dx,mens2    ;imprime a mensagem 2
         int 21h

         mov ah,2
         mov dl,bl       ;imprime o caractere
         int 21h

         mov ah,4ch
         int 21h         ;finaliza o programa


main endp
end main