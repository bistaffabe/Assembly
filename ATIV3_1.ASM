Title Numero
.model small
.stack 100h
.data
    msg1 db "Digite um caractere: $"
    sim  db 10,13,"O caractere digitado e um numero.$"
    nao  db 10,13,"O caractere digitado nao e um numero.$"
.code
main proc
               mov ax, @data         ;acesso as varíaveis
               mov ds,ax

               mov ah,9
               mov dx,offset msg1    ;imprime a primeira mensagem
               int 21h

               mov ah,1              ;le um caractere e salva em al
               int 21h

               mov bl,al             ;move o caractere que estava salvo em al, para bl

               cmp bl,48             ;compara o caractere lido com o valor 48(na tabela ASCII '0')

               jb  NAOENUMERO        ;se o caracter for menor salta para o rotulo "NAOENUMERO"

               cmp bl,57             ;compara o caractere lido com o valor 57(na tabela ASCII '9')

               ja  NAOENUMERO        ;se o caracter lido for maior salat para o rotulo "NAOENUMERO"
    
               mov ah,9
               mov dx,offset sim     ;imprime a string
               int 21h

               jmp FIM               ;salta para o rótulo "FIM"que finaliza o programa

    NAOENUMERO:
               mov ah,9
               mov dx, offset nao
               int 21h

    FIM:       
               mov ah,4ch
               int 21h

main endp
end main


;Este programa pede para ler um caractere e analiza se este é um numero (de 0 a 9) ou uma letra.
;Primeiro ele utiliza uma comparacao para ver se o numero é menor que 0 e se for menor utiliza salto nao sinalizado 'ja' 
;Se não ele utilizada uma comparacao para ver se o numero é maior que 9 e se for utiliza o salto nao sinalizado 'jb'


