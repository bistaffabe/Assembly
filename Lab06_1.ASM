; Implementar um programa em assembly que leia n caracteres enquanto for
; diferente de CR. Contar o número de caracteres e imprimir tantos “*” quanto for este número
title lab06_1
.model small
.stack 100h
.code 
main proc 
xor cx,cx
conta: 
    MOV AH,01 
    INT 21H
    CMP AL,13 
    JE asterisco
    inc cx
    jmp conta

asterisco: 

    mov ah,02 
    mov dl,'*'
    int 21h 
    loop asterisco

    mov ah,4ch 
    int 21h
main endp 
end main