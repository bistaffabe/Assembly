title lab06_02
.model small
.stack 100h 
.code
main proc
              xor  cx,cx
    conta:    
              MOV  AH,01
              INT  21H
    ; CMP AL,13
    ; JE asterisco
              inc  cx
              CMP  AL,13
              JNZ  conta

    asterisco:

              mov  ah,02
              mov  dl,'*'
              int  21h
              loop asterisco

              mov  ah,4ch


main endp
end main 