title soma
.model small
.stack 100h
.data
    mens1     db "Digite o 1 numero: $"
    mens2     db "Digite o 2 numero: $"
    mens3     db "Digite o 3 numero: $"
    mens4     db "Digite o 4 numero: $"
    mens5     db "Digite o 5 numero: $"
    resultado db 0

.code
main proc
         mov ax, @data
         mov ds, ax
    
         mov cx, 0        ; Inicializa a soma em 0

    ; Lê e soma o 1º número
         mov ah, 9
         lea dx, mens1
         int 21h          ; Exibe mensagem "Digite o 1 numero:"

         mov ah, 1        ; Função de leitura de um caractere
         int 21h          ; Lê o número (caractere)
         sub al,30h       ; Converte caractere ASCII para valor numérico
         add cx, ax       ; Soma o valor lido à soma total

    ; Lê e soma o 2º número
         mov ah, 9
         lea dx, mens2
         int 21h          ; Exibe mensagem "Digite o 2 numero:"

         mov ah, 1        ; Lê o próximo caractere
         int 21h
         sub al,30h       ; Converte ASCII para número
         add cx, ax       ; Soma o valor lido



    ; Lê e soma o 3º número
         mov ah, 9
         lea dx, mens3
         int 21h          ; Exibe mensagem "Digite o 3 numero:"

         mov ah, 1        ; Lê o próximo caractere
         int 21h
         sub al, 30h
         add cx, ax

    ; Lê e soma o 4º número
         mov ah, 9
         lea dx, mens4
         int 21h          ; Exibe mensagem "Digite o 4 numero:"

         mov ah, 1
         int 21h
         sub al, 30h
         add cx, ax

    ; Lê e soma o 5º número
         mov ah, 9
         lea dx, mens5
         int 21h          ; Exibe mensagem "Digite o 5 numero:"

         mov ah, 1
         int 21h
         sub al, 30h
         add cx, ax

    ; Exibe a soma total
         add cx, 30h      ; Converte o número de volta para ASCII
         mov dl, cl       ; Move o resultado para DL (registrador para impressão)
         mov ah, 2        ; Função de impressão de caractere
         int 21h          ; Exibe a soma total

    ; Finaliza o programa
         mov ah, 4Ch      ; Termina o programa
         int 21h

main endp
end main

