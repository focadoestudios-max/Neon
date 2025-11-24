// arquiteturas/arm64/boot.asm
.section .text.boot
.global inicio

inicio:
    // inicia pilha
    ldr x0, = _pilha_fim
    mov sp, x0
    // bebug: boot iniciado
    ldr x0, = msg_boot
    bl _escrever_tex
    // limpa BSS
    ldr x0, = _bss_inicio
    ldr x1, = _bss_fim
    bl zero_mem
    // chama o kernel
    bl principal
    // se retornar, para
    b parar_sistema
zero_mem:
    cmp x0, x1
    b.eq 2f
    str xzr, [x0], 8
    b zero_mem
2:
    ret
parar_sistema:
    wfe
    b parar_sistema

msg_boot: .asciz "Bootloader ARM64 iniciado\r\n"
