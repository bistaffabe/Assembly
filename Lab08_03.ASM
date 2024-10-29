
;ENTRADA HEXADECIMAL 
title exercicio3 
.model small
.code      
main proc      
;zera o registrador de armazenamento bx 
xor bx,bx
;funcao para ler caracter 
mov ah,01h 
;contador recebe 4 
mov cx,4 
LE:
;realiza a funcao 
int 21h 
;comparacao com o carriage return 
cmp al,13
;se for igual vai pro fim 
je fim
;transforma para caracter 
and al,0fh
;desloca 4 casas decimais para esquerda 
shl bx,4
;faz o OR para passar o numero para o byte menos significativo do bx
or bl,al
loop LE

fim: 
;finaliza o programa 
mov ah,04ch 
int 21h
main endp
end main