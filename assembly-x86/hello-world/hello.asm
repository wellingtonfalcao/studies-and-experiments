SECTION .data
    LF          equ 0xA ; Pular linha
    NULL        equ 0xD ; Final da string
    SYS_CALL    equ 0x80 ; Envia informação ao SO   
    
    ; COMANDOS DO EAX (Registradores x86 de 32bits)
    SYS_EXIT    equ 0x1 ; Código de chamada para finalizar
    SYS_READ    equ 0x3 ; Operação de leitura
    SYS_WRITE   equ 0x4 ; Operação de escrita
    
    ; COMANDOS DO EBX (Registradores x86 de 32bits)
    RET_EXIT    equ 0x0 ; Operação realizada com sucesso
    STD_IN      equ 0x0 ; Entrada padrão
    STD_OUT     equ 0x1 ; Saída padrão

    ; Constantes
    x dd 50
    y dd 10
    msg1 db 'X maior que Y', LF, NULL
    tam1 equ $- msg1
    msg2 db 'Y maior que X', LF, NULL
    tam2 equ $- msg2
    msg3 db 'Y e X são iguais', LF, NULL
    tam3 equ $- msg3

SECTION .text

global _start ; label de inicio obrigatória (tem que ser minúsculo)

_start:
    mov EAX, [x]
    mov EBX, [y]
    ; if em assembly
    cmp EAX, EBX ; instrução de comparação
    ; Instruções de salto condicional 
    ; je = | jg > | jge >= | jl < | jle <= | jne !=
    ; Instruções de salto incondicional 
    ; jmp
    jg maior ;EAX > EBX
    je igual ;EAX = EBX
   
    mov ECX, msg2
    mov EDX, tam2
    jmp final

maior:
    mov ECX, msg1
    mov EDX, tam1
    jmp final

igual:
    mov ECX, msg3
    mov EDX, tam3

final: ;Encerra o programa 
    mov EAX, SYS_WRITE
    mov EBX, STD_OUT
    int SYS_CALL

    mov EAX, SYS_EXIT
    xor EBX, EBX
    int SYS_CALL