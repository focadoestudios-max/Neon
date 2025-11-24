/* drivers/qemu/linker.ld */
ENTRY(inicio)

SECTIONS
{
    . = 0x40080000;
    
    .text : {
        *(.text.boot)
        *(.text)
    }
    .data : { *(.data) }
    
    .bss : {
        _bss_inicio = .;
        *(.bss)
        _bss_fim = .;
    }
    . = ALIGN(16);
    _pilha_inicio = .;
    . += 0x4000; /* 16KB stack */
    _pilha_fim = .;
    
    _heap_inicio = .;
    . += 0x10000; /* 64KB heap */
    _heap_fim = .;
}