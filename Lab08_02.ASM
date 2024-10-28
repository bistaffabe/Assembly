
;SAÍDA BINÁRIA 
title exercicio2
.model small
.code       
main proc       
;move para o contador 16
mov cx,16 
;incializa bx com o numero 25
mov bx,25
;funcao dois para imprimir caracter 
mov ah,02 

imprime: 
;rotação de BX à esquerda 1 casa binária (MSB vai para o CF) 
rol bx,1
;se o carry for igual a um 
jc um 
;se nao imprime 0
mov dl,30h
; mov dl,0
; or dl,30h
int 21h 
loop imprime   ;decrementa em cx

um: 
;imprime o caracter um 
mov dl,31h
; mov dl,1
; or dl,30h 
int 21h
loop imprime 

mov ah,04ch 
int 21h
main endp 
end main 