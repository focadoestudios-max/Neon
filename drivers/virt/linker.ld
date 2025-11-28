/* drivers/virt/linker.ld */
ENTRY(inicio)

UART_BASE = 0x09000000;
FR_TXFF = 0x20;
FR_RXFE = 0x10;
UART_DR = 0x00;
UART_FR = 0x18;
UART_CR = 0x30;

SECTIONS {
    . = 0x40100000;
    
    .text : {
        *(.text.boot)
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
    . = ALIGN(4096);
    .bss : {
        _bss_inicio = .;
        *(.bss)
        *(.bss.*)
        *(COMMON)
        _bss_fim = .;
    }
    
    . = ALIGN(16);
    _pilha_inicio = .;
    . += 0x4000; /* 16 KB de pilha */
    _pilha_fim = .;
}

PHDRS {
    text PT_LOAD FLAGS(5);    /* R-X */
    rodata PT_LOAD FLAGS(4);  /* R-- */  
    data PT_LOAD FLAGS(6);    /* RW- */
}