title lab05_02.ASM
.model small
.stack 100h
.code
main proc
             mov  bh,10       ;move para bh o 10, para pular linha
             mov  cx,50       ;50 para o contador
             mov  ah,2        ;funcao 2: imprime caracter(SEMPRE USA DL)
             mov  dl,'*'

    imprime1:
             int  21h         ;imprime o caracter
             loop imprime1
    
    ; mov ah,1
    ; int 21h
    ; mov ah,2

             xchg dl,bh       ;troca bh para dl, e dl para bh
             int  21h         ; imprime o "pular linha"
             xchg dl,bh       ;troca bh para dl, e dl para bh
             mov  cx,50       ;50 de novo para o contador
    
    imprime2:

             int  21h         ;imprime o caractere
             xchg dl, bh      ;troca
             int  21h         ;pula linha
             xchg dl,bh       ;troca
             loop imprime2

             mov  ah,4ch      ;finaliza o programa
             int  21h
            
main endp
end main
