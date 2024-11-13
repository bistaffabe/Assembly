title Lab11_01
.model small
.stack 0100h
pula_linha macro     ; macro que pula linha
    push dx
    push ax
    mov ah, 2
    mov dl, 10
    int 21h
    pop ax
    pop dx
endm
.data
    entrada db 10, 13, 'Qual base sera a entrada? (d/h/b)$'
    saida db 10, 13, 'Qual base sera a saida? (d/h/b)$'
.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 9
    lea dx, entrada
    int 21h
    mov ah, 1
    int 21h
    pula_linha                  ;usuário escolhe a base da entrada atraves das iniciais
    cmp al, 'd'
    je decimal
    cmp al, 'h'
    je hexadecimal
    cmp al, 'b'
    je binario
jmp saidas

decimal:                          ; caso seja decimal chama essa funcao
    call _decimal
jmp saidas

hexadecimal:                      ; caso seja hexadecimal chama essa funcao
    call _hexa
jmp saidas

binario:                            ; caso seja binario chama essa funcao
    call _binario
jmp saidas
saidas:
    mov ah, 9                          ; usuario insere qual base ele quer que seja a saida
    lea dx, saida
    int 21h
    mov ah, 1
    int 21h
    pula_linha
    cmp al, 'd'
    je sdecimal
    cmp al, 'h'
    je shexadecimal
    cmp al, 'b'
    je sbinario
jmp fim
sdecimal:                           ; chama a funcao de saida decimal
    call @decimal
jmp fim

shexadecimal:                       ; chama a funcao de saida hexa
   call @hexa
jmp fim

sbinario:                          ; chama a funcao de saida binario
  call @binario 
jmp fim

fim:
    mov ah, 4ch
    int 21h

main endp

_decimal proc           ; funcao para leitura de decimal
    xor bx,bx
le_dec:
    mov ah,1
    int 21h
    cmp al,13
    je fim_le
    and al,0Fh
    xor ah,ah
    push ax
    mov ax,10
    mul bx
    pop bx
    add bx,ax

    jmp le_dec
fim_le:
    ret

_decimal endp

_hexa proc                      ; funcao para leitura de hexadecimal
    xor bx, bx
hexa:
    mov ah, 1
    int 21h
    cmp al, 13
    je saih
    and al, 0Fh
    shl bx, 4
    or bl, al
jmp hexa
saih:
    ret
_hexa endp
_binario proc                   ; funcao para leitura de binario
    xor bx, bx
    mov cx, 16
bin:
    mov ah, 1
    int 21h
    cmp al, 13
    je saib
    and al, 0Fh
    shl bx, 1
    or bl, al
loop bin
saib:
    ret
_binario endp
@decimal proc                   ; funcao que imprime decimal
    mov ax, bx
    mov bx, 10
    xor cx, cx
@deci:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    je imprimed
jmp @deci
imprimed:
    mov ah, 2
    pop dx
    or dl, 30h
    int 21h
loop imprimed
    ret
@decimal endp
@hexa proc                      ; funcao que imprime hexadecimal
    mov cx, 4
    mov ah, 2
@hex:
    mov dl, bh
    shr dl, 4
    cmp dl, 10
    jae letra
    or dl, 30h
    int 21h
    rol bx, 4
loop @hex
    jmp imprimeh
letra:
    add dl, 37h
    int 21h
loop @hex
imprimeh:
    ret
@hexa endp
@binario proc                     ; funcao que imprime binario
    mov cx, 16
    mov ah, 2
@bin:
    rol bx, 1
    jc um
    mov dl, 0
    or dl, 30h
    int 21h
loop @bin
    jmp imprimeb
um:
    mov dl, 1
    or dl, 30h
    int 21h
loop @bin
imprimeb:
    ret
@binario endp
end main