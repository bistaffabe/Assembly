title projeto1
.model small
.stack 0100h
pula_linha MACRO            ;macro que pula linha
    push ax
    push dx
    mov ah,02
    mov dl,10
    int 21h
    pop dx
    pop ax
ENDM
espaco MACRO                ;macro para dar espaço
    push ax
    push dx
    mov ah,02
    mov dl,' '
    int 21h
    pop dx
    pop ax
ENDM
resultado macro numero      ;macro para imprimir a string quando uma embarcação for atingida 
    push ax
    push dx
    mov ah, 9
    lea dx, numero
    int 21h
    pop dx
    pop ax
ENDM
.data
    v_impressaocolunas db  1 , 2, 3, 4, 5, 6, 7, 8, 9, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0
    impressaolinhas db 0
    ;matriz das posicoes das embarcacoes, ela será utilizada na conferencia
    m_embarcacoes db  20 DUP (0)                
                  db  0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
                  db  20 DUP (0)
                  db  20 DUP (0)
                  db  20 DUP (0)
                  db  0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0
                  db  20 DUP (0)
                  db  20 DUP (0)
                  db  0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  
                  db  20 DUP (0)
                  db  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0  
                  db  0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                  db  0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0  
                  db  0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                  db  20 DUP (0)
                  db  20 DUP (0)
                  db  6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                  db  6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                  db  6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                  db  20 DUP (0)
    ;matriz que será impressa com as posições que foram salvas pois ja foram atingidas
    m_tiros db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
            db  20 DUP (0)
    ;declaracão de strings e vetores 
    l_digite_linha db 10, 13, 'Informe a linha desejada para atirar, entre 1 e 20: $'
    l_digite_coluna db 10, 13, 'Informe a coluna desejada para atirar, entre 1 e 20: $'
    l_digite_novamente db 10, 13, 'Esse nao esta no intervalo, digite novamente: $'
    l_arcertou_encouracado db 10, 13, 'Voce acertou um encouracado!!!$'
    l_arcertou_fragata db 10, 13, 'Voce acertou uma fragata!!!$'
    l_arcertou_subma db 10, 13, 'Voce acertou um submarino!!!$'
    l_arcertou_hidroaviao db 10, 13, 'Voce acertou um hidroaviao!!!$'
    l_errou db 10, 13, 'Voce nao acertou nenhuma embarcacao!!!$'
    l_continua db 10, 13, 'Deseja atirar novamente? (s/n)$'
    l_eliminou_encouracado db 10, 13, 'Voce eliminou a embarcacao de encouracado.$'
    l_eliminou_fragata db 10, 13, 'Voce eliminou a embarcacao de fragata.$'
    l_eliminou_submarino db 10, 13, 'Voce eliminou uma embarcacao de submarino.$'
    l_eliminou_hidroaviao db 10, 13, 'Voce eliminou uma embarcacao de hidroaviao.$'
    v_acertos db 6 dup (0)
    l_essaposicaojafoiacertada db 10,13, 'Essa posicao ja foi acertada :($'
    l_venceu db 10,13, 'Todas embarcacoes foram afundadas, voce venceu!!!!$'

.code
main proc 
    mov ax, @data                       ;acesso ao segmento de dados 
    mov ds, ax                              

r_jogo:
    mov ah, 9                           ;impressao da string para leitura da linha 
    lea dx, l_digite_linha
    int 21h
    xor bx, bx

r_linha_leitura:                        ;leitura decimal de linha
    mov ah,1                                
    int 21h
    cmp al,13                           ;Se CR o numero (linha) irá para conferencia  
    je r_confere_linha
    and al,0Fh
    xor ah,ah
    push ax
    mov ax,10
    mul bx
    pop bx
    add bx,ax
jmp r_linha_leitura

r_confere_linha:                        ;confere se a linha digitada está dentro do intervalo 
    sub bx, 1                           ;subtrai 1, por causa das posiçoes matriz (MATRIZ COMECA NO 0, LEITURA DE 1 AO 20)
    cmp bx, 19
    jbe r_linha_leitura_fim             ;se estiver dentro do intervalo, vai para a leitura da coluna
    mov ah, 9                           
    lea dx, l_digite_novamente
    int 21h                             ;se nao volta para a leitura decimal da linha
    xor bx, bx
    jmp r_linha_leitura

r_linha_leitura_fim:                   
    mov ax, 20                         ;adicona 20 para multiplicar com a linha e dar o endereço de onde a matriz esta realmente alocada na memoria 
    mul bx
    mov bx, ax
    push bx                             ;EMPILHA LINHA
    mov ah, 9
    lea dx, l_digite_coluna         ;inicialização leitura da coluna
    int 21h
    xor bx,bx

r_coluna_leitura:                       ;leitura decimal de coluna
    mov ah,1
    int 21h
    cmp al,13                           ;Se CR o numero (coluna) irá para conferencia  
    je r_confere_coluna                
    and al,0Fh
    xor ah,ah
    push ax
    mov ax,10
    mul bx
    pop bx
    add bx,ax
jmp r_coluna_leitura

r_confere_coluna:                       ;confere se a coluna digitada está dentro do intervalo 
    sub bx, 1                           ;subtrai 1, por causa das posiçoes matriz (MATRIZ COMECA NO 0, LEITURA DE 1 AO 20)
    cmp bx, 19                          ;se estiver dentro do intervalo, vai para a conferencia se essa posicao ja foi acertada
    jbe confere_se_ja
    mov ah, 9
    lea dx, l_digite_novamente          ;se nao volta para a leitura decimal da coluna
    int 21h
    xor bx, bx
    jmp r_coluna_leitura

confere_se_ja: 
    mov si, bx                              ;move a coluna para si 
    pop bx                                  ;desempilha a linha 
    cmp m_tiros[bx][si], 0                  ;compara a posicao da matriz de tiros
    jne r_continua2                         ;se nao for zero esta posicao ja foi atingida 
    jmp r_coluna_leitura_fim                ;se for zero volta vai para conferencia se esta posicao possui alguma embarcacao

r_continua2:                                ;caso a posicao ja tenha sido atingida, você voltara para o comeco do jogo 
    mov ah,09 
    lea dx,l_essaposicaojafoiacertada
    int 21h 
    jmp r_continua    

;EXPLICAÇÃO DA LÓGICA: 
;1 foi utilizado para a contagem do encouracado 
;2 para a fragata
;3 para o primeiro submarino 
;4 para o segundo submarino 
;5 para o primeiro hidroaviao 
;6 para o segundo hidroaviao  

r_coluna_leitura_fim:                       ;confere se a posição digitada contém uma embarcação
    mov ch, m_embarcacoes[bx][si]           ;aqui iremos mover para ch o que contem na combinacao linha/coluna    
    cmp ch, 1                               ;e ir para o devido rotulo caso tiver algum dos numeros 
    je r_acertou_encouracado
    cmp ch, 2
    je r_eliminou_fragata
    cmp ch, 3
    je r_eliminou_submarino_1
    cmp ch, 4
    je r_eliminou_submarino_2
    cmp ch, 5
    je r_eliminou_hidroaviao_1
    cmp ch, 6
    je r_eliminou_hidroaviao_2
    call p_erro                             ;se nenhuma das celulas das embarcacoes foram atingida, vai para este procedimento 
    jmp r_saida

r_acertou_encouracado:                          ;ACERTO DA CELULA DE UM ENCOURACADO
    call p_encouracado
    cmp cl, 4                                   ;O v_acertos[0] armazena quantos 1's ja foram atingidos, se for igual a 4 o encouracado foi afundado 
    jne r_saida                                 ;impressao da matriz de tiros
    resultado l_eliminou_encouracado            ;Se cl=4 imprime que a embarcacao foi afundada
    jmp r_saida                                  

r_eliminou_fragata:                             ;ACERTO DA CELULA DE UMA FRATA
    call p_fragata
    cmp cl, 3                                   ;se for igual a 3 a fragata foi afundada 
    jne r_saida                                 ;impressao da matriz de tiros 
    resultado l_eliminou_fragata                ;impressao que a fragat foi afundada 
    jmp r_saida                                  

r_eliminou_submarino_1:                         ;ACERTO DA CELULA DO PRIMEIRO SUBMARINO
    call p_submarino_1
    cmp cl, 2                                   ;se for igual a 2 o submarino foi afundado 
    jne r_saida                                 ;impressao da matriz de tiros 
    resultado l_eliminou_submarino              ;imprime que o submarino foi afundado
    jmp r_saida

r_eliminou_submarino_2:                         ;ACERTO DA CELULA DO SEGUNDO SUBMARINO 
    call p_submarino_2
    cmp cl, 2                                   ;se for igual a 2 o submarino foi afundado
    jne r_saida                                 ;impressao da matriz de tiros 
    resultado l_eliminou_submarino              ;imprime que o submarino foi afundado
    jmp r_saida

r_eliminou_hidroaviao_1:                        ;ACERTO DA CELULA DO PRIMEIRO HIDROAVIÃO
    call p_hidroaviao_1
    cmp cl, 4                                   ;se  for igual a 4 o hidroaviao foi afundado 
    jne r_saida                                 ;impressao da matriz de tiros
    resultado l_eliminou_hidroaviao             ;imprime que o hidroaviao foi afundado 
    jmp r_saida

r_eliminou_hidroaviao_2:                        ;ACERTO DA CELULA DO SEGUNDO HIDROAVIÃO
    call p_hidroaviao_2                         
    cmp cl, 4                                   ;se for igual a 4 o hidroaviao foi afundado
    jne r_saida                                 ;impressao da matriz de tiros
    resultado l_eliminou_hidroaviao             ;imprime que o hidroaviao foi afundado 

r_saida:                            ;impressão da matriz atualizada com os tiros dados
    pula_linha
    mov cx,20
    mov ah,02
    xor bl,bl
    espaco

imp:
    mov ah,02
    mov dl,v_impressaocolunas[bx]
    or dl,30h
    int 21h
    espaco
    inc bl
    loop imp
    

    xor bx, bx
    mov di, 20
    pula_linha

r_linha_impressao:
    mov ah, 2
    mov dl, impressaolinhas
    or dl,30h
    int 21h
    inc impressaolinhas
    xor si, si
    mov cx, 20
r_coluna_impressao:
    espaco
    mov dl, m_tiros[bx][si]
    or dl, 30h
    int 21h
    
    inc si
loop r_coluna_impressao
    pula_linha
    add bx, 20
    dec di
jnz r_linha_impressao
mov di,6 
mov al, v_acertos[di]                   ;v_acertos[6] armazena as celulas corretas de todas as embarcacoes
cmp al,19                               ;se for igual a 19, fim do jo 
je fim_do_jogo 
jmp r_continua

fim_do_jogo:                            ;impressao que o usuario venceu 
    mov ah,9 
    lea dx,l_venceu         
    int 21h 
    jmp r_fim

r_continua:                             ;Pergunta se o usuario deseja continuar 
    mov ah, 9
    lea dx, l_continua       
    int 21h
    mov ah, 1
    int 21h
    cmp al, 's'
    je r_volta_jogo
    jmp r_fim
r_volta_jogo:                           ;se sim, volta ao jogo 
    jmp r_jogo

r_fim:                                  ;se nao, finaliza o programa 
    mov ah, 4ch
    int 21h
main endp

p_encouracado proc                      ;procedimento para atualizar a matriz de tiros e checar se o encouracado foi totalmente atingido/afundado
    mov m_tiros[bx][si], 1              ;matriz de tiros atualizada
    mov ah, 9           
    lea dx, l_arcertou_encouracado      ;impressao de que uma posicao do encouracado foi atingida 
    int 21h
    xor di, di                          ;zera di, pois a posicao 0 do vetor de acertos guarda quantos 1's
    inc v_acertos[di]                   ;Ou seja, quantas celulas já foram atingidas e passa para cl
    mov cl, v_acertos[di]               
    mov di,6                            ;A posicao 6 do vetor de acertos, guarda quantas celulas corretas ja foram atingidadas
    add v_acertos[di], 1                ;Pois quando tiver 19 todas as embarcacoes terão sido afundadas 
    ret
p_encouracado endp

p_fragata proc                          ;procedimento para atualizar a matriz de tiros e checar se o encouracado foi totalmente atingido/afundado        ;matriz de tiros atualizada
    mov m_tiros[bx][si], 2              ;move 2 para a combinacao de linha/coluna da matriz de tiros 
    mov ah, 9
    lea dx, l_arcertou_fragata          ;impressao caso uma celula da fragata for atingida 
    int 21h
    mov di, 1                       
    inc v_acertos[di]                   ;v_acertos[1] armazena a quantidade de celulas atingidadas da fragata
    mov cl, v_acertos[di]               ;e move para cl 
    mov di,6
    add v_acertos[di], 1                ;adiciona a posicao que armazena a celulas corretas de todas as embarcacoes 
    ret
p_fragata  endp

p_submarino_1 proc
    mov m_tiros[bx][si], 3              ;move 3 para a combinacao de linha/coluna da matriz de tiros
    mov ah, 9
    lea dx, l_arcertou_subma           ;impressao caso uma celula do submarino for atingida  
    int 21h
    mov di, 2                   
    inc v_acertos[di]                  ;v_acertos[2] armazena a quantidade de celulas atingidadas do PRIMEIRO submarino 
    mov cl, v_acertos[di]
    mov di,6
    add v_acertos[di], 1               ;adiciona a posicao que armazena a celulas corretas de todas as embarcacoes 
    ret
p_submarino_1 endp

p_submarino_2 proc 
    mov m_tiros[bx][si], 4              ;move 4 para a combinacao de linha/coluna da matriz de tiros
    mov ah, 9
    lea dx, l_arcertou_subma            ;impressao caso uma celula do submarino for atingida 
    int 21h
    mov di, 3
    inc v_acertos[di]                   ;v_acertos[3] armazena a quantidade de celulas atingidadas do SEGUNDO submarino 
    mov cl, v_acertos[di]
    mov di,6
    add v_acertos[di], 1                ;adiciona a posicao que armazena a celulas corretas de todas as embarcacoes 
    ret
p_submarino_2 endp

p_hidroaviao_1 proc
    mov m_tiros[bx][si], 5              ;move 5 para a combinacao de linha/coluna da matriz de tiros
    mov ah, 9
    lea dx, l_arcertou_hidroaviao       ;impressao caso uma celula do submarino for atingida 
    int 21h
    mov di, 4
    inc v_acertos[di]                   ;v_acertos[4] armazena a quantidade de celulas atingidadas do PRIMEIRO hidroaviao 
    mov cl, v_acertos[di]
     mov di,6
    add v_acertos[di], 1                ;adiciona a posicao que armazena a celulas corretas de todas as embarcacoes
    ret
p_hidroaviao_1 endp

p_hidroaviao_2 proc 
    mov m_tiros[bx][si], 6              ;move 6 para a combinacao de linha/coluna da matriz de tiros
    mov ah, 9
    lea dx, l_arcertou_hidroaviao       ;impressao caso uma celula do submarino for atingida
    int 21h
    mov di, 5
    inc v_acertos[di]                   ;v_acertos[5] armazena a quantidade de celulas atingidadas do PRIMEIRO hidroaviao 
    mov cl, v_acertos[di]
     mov di,6
    add v_acertos[di], 1                ;adiciona a posicao que armazena a celulas corretas de todas as embarcacoes
    ret 
p_hidroaviao_2 endp

p_erro proc
    mov ah, 9                       ;procedimento que move X para a matriz de tiros, ja que nenhuma posicao foi acertada 
    lea dx, l_errou
    int 21h
    mov m_tiros[bx][si], 'X'
    ret
p_erro endp
end main

    

;linhas e colunas 
   ; xor bl,bl
;     xor bx,bx
;     espaco
;     mov di,20
; loop_impd:
;     mov bl, impressaocolunas[0]
; imp:
;     mov ax,bx
;     mov bx,10
;     xor cx,cx
; vai_imp:
;     xor dx,dx 
;     div bx
;     push dx
;     inc cx
;     cmp ax,0
;     je imprimedecimal
;     jmp vai_imp

; imprimedecimal:
     
;     mov ah, 2
;     pop dx
;     or dl, 30h
;     int 21h
;     dec di
;     jz sai

    ; mov ah,02
    ; mov dl,v_impressaocolunas[bx]
    ; or dl,30h
    ; int 21h
    ; espaco
    ; inc bl
    ; loop imp
    

;     @decimal proc                   ; funcao que imprime decimal
;     mov ax, bx
;     mov bx, 10
;     xor cx, cx
; @deci:
;     xor dx, dx
;     div bx
;     push dx
;     inc cx
;     cmp ax, 0
;     je imprimed
; jmp @deci

;     xor bx, bx
;     mov di, 20
;     pula_linha