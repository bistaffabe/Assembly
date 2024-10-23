title exercicio4_1
.model small
.data
    vetor db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,41h,42h,43h,44h,45h    ;caracter é byte por isso usar db
.code
main proc
    ;acesso as variaveis
            mov  ax,@data
            mov  ds,ax

    ;inicializa bx com o numero 32
            mov  bx,10


    ;contador recebe 4
            mov  cx,4

    ;funcao dois para imprimir caracter
            mov  ah,02

    imprime:

    ;move para dl bh
            mov  dl,bh


    ;desloca para direita 4 casa decimais
            shr  dl,4

    ;troca o conteudo dos registradores
            xchg bx,si
    ;o endereco do primeiro conteudo do vetor esta em bx
            lea  bx,vetor
            mov  al,dl
    ;al <- mem[al+bx]
            xlat

    ;move o que esta salvo em al para dl, para imprimir
            mov  dl,al
    ;realiza a funcao2
            int  21h

    ;troca o conteudo dos registradores
            xchg bx,si

    ;rotaciona 4 casas decimais para esquerda
            rol  bx,4
            loop imprime     ;decrementa de cx


    ;finaliza o programa
            mov  ah,4ch
            int  21h

main endp
end main
