ENTRY(_inicio)

UART_BASE = 0x09000000;
FR_TXFF = 0x20;
FR_RXFE = 0x10;
UART_DR = 0x00;
UART_FR = 0x18;
UART_CR = 0x30;

SECTIONS {
    . = 0x40200000;

    .ne_legivel : {
        BYTE(0x4E) BYTE(0x45) BYTE(0x00) BYTE(0x01) /* assinatura NE */
        LONG(_ne_tamanho) /* tamanho do binário */
        QUAD(_inicio) /* ponto de entrada */
        LONG(0x00000001) /* versão */
        LONG(0x00000000) /* reservado */
        QUAD(0x00000000) /* reservado */
    }

    . = 0x40200020; /* força o .text imediatamente depois dos 32 bytes do cabeçalho */

    .text : {
        *(.text.kernel)
        *(.text)
        *(.text.*)
    }
    .rodata : {
        *(.rodata)
        *(.rodata.*)
    }
    .data : {
        *(.data)
        *(.data.*)
    }
    _ne_tamanho = . - 0x40200000;

    .bss : {
        _bss_inicio = .;
        *(.bss)
        *(.bss.*)
        *(COMMON)
        . = ALIGN(4096);
        _bss_fim = .;
    }
    . = ALIGN(16);
    _pilha_inicio = .;
    . += 0x100000;
    _pilha_fim = .;
}
