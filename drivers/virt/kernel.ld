/* drivers/virt/kernel.ld */
ENTRY(_inicio)

UART_BASE = 0x09000000;
FR_TXFF = 0x20;
FR_RXFE = 0x10;
UART_DR = 0x00;
UART_FR = 0x18;
UART_CR = 0x30;

SECTIONS {
    . = 0x40200000;
    
    .text : {
        *(.text)
        *(.text.*)
    } :text
    .rodata : {
        *(.rodata)
        *(.rodata.*)
    } :rodata
    .data : { 
        *(.data)
        *(.data.*)
    } :data
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
    . += 0x4000; /* 16 KB de pilha */
    _pilha_fim = .;
}
/* definição dos segmentos */
PHDRS {
    text PT_LOAD FLAGS(5);    /* R-X (ler + executar) */
    rodata PT_LOAD FLAGS(4);  /* R-- (so ler) */
    data PT_LOAD FLAGS(6);    /* RW- (ler + escrever) */
}