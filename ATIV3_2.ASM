title checagem
.model small
.stack 100h
.data
    msg1 db "Digite um caractere: $"
    msg2 db 10,13,"O caractere digitado eh um numero$"
    msg3 db 10,13,"O caractere digitado eh uma letra$"
    msg4 db 10,13,"O caractere digitado eh um caractere desconhecido$"

.code
main proc

              mov ax, @data
              mov ds,ax        ;acesso as variaveis

              mov ah,9
              lea dx,msg1      ;imprime a primeira string, pedindo para digitar caracter
              int 21h

              mov ah,1         ;lê um caractere e salva em al
              int 21h

              mov bl,al
 
              cmp bl,48        ;se for menor ja vai ser diferente
              jb  Diferente

              cmp bl,57        ;se for maior que 57 vai para um teste, pois pode ser diferente ou letra
              ja  teste

              mov ah,9
              lea dx,msg2      ;imprime a segunda mensagem
              int 21h

              JMP fim          ;pula para o rotulo fim

    teste:    
              cmp bl,64        ;se ele for menor igual a 64= diferente
              jbe diferente

              cmp bl,90        ;se ele for menor igual a 90=letra
              jbe letra

              cmp bl,96        ;se ele for menor igual a 96=diferente
              jbe Diferente

              cmp bl,122       ;se ele for menor igual a 122=letra
              jbe letra

              jmp diferente    ;pula para o rótulo diferente

    letra:    

              mov ah,9
              lea dx,msg3
              int 21h

              jmp fim          ;pula para o rótulo fim

    diferente:
              mov ah,9
              lea dx,msg4
              int 21h
    fim:      
              mov ah,4ch       ;finaliza o programa
              int 21h

main endp
end main      