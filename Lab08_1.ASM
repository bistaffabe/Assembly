;ENTRADA BINÁRIA 

title exercicio1
.model small
.code 
main proc 
;contador recebe 16, apenas 16 bytes serão lidos   
mov cx,16 
;zera o registrador que recebera os numero binarios  
xor bx,bx 
;funcao 1 para ler caracteres 
mov ah,01

escreve:
;executa a funcao  
int 21h 
;compara o caracter lido com o carriage return
cmp al,13 
;se for igual, salta para o rótulo fim
je fim

;subtrai 30h do caracter lido, transformando-o em numero 
and al,0fh
;desloca o registrador uma casa para a esquerda 
shl bx,1 
;faz o OR para passar o numero binario para o byte menos significativo do bx
or bl,al
loop escreve ;decrementa de cx

fim: 
;finaliza o programa 
mov ah,04ch 
int 21h
    
main endp 
end main