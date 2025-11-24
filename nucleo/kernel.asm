// nucleo/inicio.asm
.global principal

principal:
    // kernel principal
    ldr x0, = msg_kernel
    bl _escrever_tex
    ldr x0, = msg_memoria
    bl _escrever_tex
    // iniciando biblioteca script padrão
    ldr x0, = msg_ns
    bl _escrever_tex
    bl ns_abrir
    ret
msg_kernel: .asciz "Kernel carregado\r\n"
msg_memoria: .asciz "Memória iniciada\r\n"
msg_ns: .asciz "Abrindo processo NS (Neon Script)\r\n"
