title exercicio4
.model small
.code               
main proc
;inicializa bx com o numero 32 
mov bx,32
;contador recebe 4 
mov cx,4
;funcao dois para imprimir caracter 
mov ah,02 

imprime: 
;move para dl bh
mov dl,bh
;desloca para direita 4 casa decimais 
shr dl,4 
;cmp com 10
cmp dl,10
;se for menor vai para o rótulo numero 
jbe numero 
;adiciona 37h para transf em letra
add dl,37h 
;realiza a funcao2
int 21h 
;rotaciona 4 casas decimais para esquerda
rol bx,4
loop imprime  ;decrementa de cx 
jmp fim     ;salta para fim 

numero: 
;transforma em caracter 
or dl,30h 
;realiza a funcao 2 
int 21h
;rotaciona 4 casas decimais para esquerda 
rol bx,4 
loop imprime

fim: 
;finaliza o programa 
mov ah,4ch
int 21h

main endp
end main
