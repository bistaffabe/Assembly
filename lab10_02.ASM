; Escreva um programa que leia todos os elementos de uma matriz 4 X 4 de números inteiros
; entre 0 e 6, inclusive. O programa deverá ler a matriz, imprimir a matriz lida, fazer a soma dos
; elementos, armazenar e imprimir esta soma. Usar um procedimento para ler, outro para somar
; e outro para imprimir. Usar procedimentos e macros.

title matriz2 
.model small 
pula_linha MACRO
               pop  ax
               pop  dx
               mov  ah,02
               mov  dl,10
               int  21h
               push ax
               push dx
endm

.data
    matriz db 16 dup ('?')
    mens1  db 'soma= $'
.code

main proc
                    mov        ax,@data
                    mov        ds,ax

                    xor        bx,bx                 ;zera o registrador
                    call       leia_matriz           ;chama a funcao
                    xor        bx,bx                 ;zera o registrador
                    call       imprime_matriz        ;chama a funcao
                    call       soma_matriz           ;chama a funcao
                    call       imprime_matriz        ;chama a funcao
    
                    mov        ah,4ch                ;finaliza o programa
                    int        21h
main endp



leia_matriz proc

                    mov        di,4                  ;registrador que é decrementado para que imprima 4 linhas
                    mov        ah,01                 ;funcao para imprimir
    pre:            
                    mov        cx,4                  ;contador para imprimir 4 elementos da linha
                    xor        si,si                 ;zera registrador da linha
    lendo:          
                    int        21h                   ;realiza a funcao
                    and        al,0fh                ;transforma em numero
                    cmp        al,6                  ;compara para ver se é maior que 6
                    ja         denovo
                    cmp        al,0                  ;compara para ver se é menor que 0
                    jb         denovo
                    mov        matriz[bx][si],al     ;se estiver dentro das condições o numero é inserido na matriz
                    inc        si                    ;incrementa o registrador das colunas
                    loop       lendo
                    add        bx,4                  ;adiciona 4 ao registrador das linhas
                    dec        di                    ;decrementa o contador de linhas
                    jz         sai                   ;se for zero sai
                    jmp        pre                   ;se nao volta ao pré-requisito
    denovo:         
                    jmp        lendo                 ;se for maior que 6 ou menor que 0, volta para ler

    sai:            
                    ret
leia_matriz endp



imprima_matriz proc
                    xor        bx,bx                 ;zera o registrador das colunas
                    mov        di,4                  ;registrador que é decrementado para que imprima 4 linhas
                    mov        ah,02                 ;funcao para imprimir

    teste:          
                    mov        cx,4                  ;contador para que seja impresso 4 elementos
                    pula_linha
                    xor        si,si                 ;registrador zerado
    im:             
                    mov        dl, matriz[bx][si]    ;manipulação de matriz
                    or         dl,30h                ;transforma em caracter
                    int        21h
                    inc        si                    ;incrementa o registrador de colunas
                    loop       im
                    add        bx,4                  ;adiciona ao registrador de linhas 4
                    dec        di                    ;decrementa o registrador, ja que uma linha foi impressa
                    jz         teste2                ;se for zero sai
                    jmp        teste
    teste2:         
                    ret
imprimir_matriz endp



soma_matriz proc
                    xor        ax,ax                 ;zera o registrador
                    xor        bl,bl                 ;zera bl
                    mov        di,4                  ;registrador que é decrementado para que imprima 4 linhas
    pre2:           
                    xor        si,si                 ;registrador zerado
                    mov        cx,4                  ;contador para que seja impresso 4 elementos
    sm:             
                    add        al,matriz[bx][si]     ;al<- al+ elemento da matriz
                    inc        si                    ;incrementa uma coluna
                    loop       sm
                    add        bx,4                  ;adiciona ao registrador de linhas 4
                    dec        di                    ;decrementa registrador, que faz imprimir as 4 linhas
                    jz         sai2                  ;se for zero sai do programa
                    jmp        pre2
    sai2:           
                    ret
soma_matriz endp

    ;impressão de numeros decimais

imprime_result proc
                    mov        bx,10                 ;move 10 para bx
                    xor        cx,cx                 ;registrador zerado
    divide:         
                    xor        dx,dx                 ;regtrador zerado
                    div        bx                    ;ax/bx resto=dx
                    push       dx                    ;empilha dx
                    inc        cx                    ;incrementa no contator
                    cmp        ax,0                  ;se o quociente for zero sai do programa
                    je         sai6                  ;se for igual sai do programa
                    jmp        divide                ;se nao fica no loop
    sai6:           
                    mov        ah,02                 ;funcao de impressao
                    mov        dl,10
                    int        21h                   ;funcao é executada
    vai3:           
                    pop        dx                    ;desempilha o resto
                    or         dl,30h                ;transforma em caracter
                    int        21h                   ;imprime
                    loop       vai3                  ;decrementa em cx
                    ret
imprime_result endp

end main 