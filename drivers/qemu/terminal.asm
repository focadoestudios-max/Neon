// drivers/qemu/terminal.asm
.global _escrever_tex
.global _escrever_car
.global _obter_car
// endereço base do PL011 UART
.equ UART_BASE, 0x09000000
// posicao do registrador de dados(DR) pra ler e escrever
.equ UART_DR, 0x00
// posicao do registrador de marcação(FR)
.equ UART_FR, 0x18
// bit '4' do FR: RXFE "1" significa que não tem dados novos
.equ FR_RXFE, (1 << 4)
// bit '5' do FR: TXFF "1" significa que o buffer de envio ta cheio
.equ FR_TXFF, (1 << 5)

// w0 = retorna o caractere lido
_obter_car:
    ldr x1, = UART_BASE // x1 = endereço base do UART
    b 1f
1:
    ldr w0, [x1, UART_FR] // w0 = valor do FR
    ands w0, w0, FR_RXFE // testa se o bit "RXFE" ta definido
    b.ne 1b // se ta vazio, espera
    ldr w0, [x1, UART_DR] // w0 = le o caractere(DR)
    ret
// w0 = caractere pra imprimir
_escrever_car:
    ldr x1, = UART_BASE // x1 = endereço base do UART
    b 1f
1:
    ldr w2, [x1, UART_FR] // w2 = valor do FR
    ands w2, w2, FR_TXFF // testa se o bit "TXFF" ta definido
    b.ne 1b // se estiver cheio, espera
    str w0, [x1, UART_DR] // escreve o caractere(DR)
    ret
// x0 = texto pra imprimir
_escrever_tex:
    stp x29, x30, [sp, -16]!
    mov x29, sp

    mov x3, x0
    ldr x2, = UART_BASE
    b 1f
1:
    ldrb w4, [x3], 1
    cbz w4, 3f
2:
    ldr w5, [x2, UART_FR]
    tst w5, FR_TXFF
    b.ne 2b

    str w4, [x2, UART_DR]
    b 1b
3:
    ldp x29, x30, [sp], 16
    ret
    