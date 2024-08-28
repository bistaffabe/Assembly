title Mensagens 
.model small
.data
    mens1 db "Mensagem 1.$"
    mens2 db 10,13,"Mensagem 2.$"
.code

main proc 
mov ax, @data  ;acesso as variaveis 
mov ds,ax

mov ah,9
lea dx, mens1 ;imprime a mensagem 1
int 21h

mov ah,9
lea dx, mens2  ;imprime a mensagem 2
int 21h

mov ah,4ch
int 21h  ;finaliza o programa 

main endp
end main