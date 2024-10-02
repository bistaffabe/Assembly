title lab05_03.ASM
.model small
.stack 100h
.code
main proc
    ; 1 - Programa que exibe todas as letras maiúsculas e depois todas as minúsculas na tela.
    ; Postar o arquivo Lab05_03.ASM dentro da Atividade 5.
    ; 65 ate 90 hexadecimal = letra maiscula
    ; 97 ate 122 hexadecimal = letra minuscula
                      mov  bl,10                ;para pular linha
                      mov  ah,2                 ;funcao 2 para imprimir na tela
                      mov  cx,26                ; contador 26(a-z)
                      mov  dl,'A'               ;Dl comeca com A

    imprime_maiscula: 
                      int  21h                  ;imprime
                      inc  dl                   ;incrementa um no dl
                      loop imprime_maiscula     ;automaticamente decrementa de cx, e salta para o label
    
                      mov  ah,2                 ;funcao 2 de imprimir
                      xchg dl,bh                ;troca os conteudos
                      int  21h                  ;imprime dl, que neste caso é 10 e pula linha
                      xchg dl,bh                ;troca os conteudos
                      mov  cx,26                ;reinicia o contador com 26
                      mov  dl,'a'

    imprime_minuscula:
                      int  21h                  ;imprime em minuscula agr
                      inc  dl                   ;incremnta em dl
                      loop imprime_minuscula    ;automaticamente decrementa de cx, e salta para o label
    FIM:              
                      mov  ah,4ch               ;finaliza o programa
                      int  21h

main endp
end main