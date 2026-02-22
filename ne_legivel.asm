// ne_legivel.asm
// Cabeçalho do formato NE (Necessário)
//
// IMPORTANTE: este arquivo pertence ao KERNEL, não ao bootloader.
// É compilado junto com os outros objetos do kernel e linkado via kernel.ld.
// O linker resolve _ne_fim e _inicio em link-time — o bootloader apenas lê
// os bytes do disco, sem referenciar esses símbolos diretamente.
//
// Layout do cabeçalho (32 bytes, offset 0x00 do binário):
//   0x00  [4 bytes] assinatura: 'N','E',0x00,0x01
//   0x04  [4 bytes] tamanho total do binário em bytes
//   0x08  [8 bytes] endereço do ponto de entrada (_inicio)
//   0x10  [4 bytes] versão do formato NE
//   0x14  [4 bytes] reservado
//   0x18  [8 bytes] reservado

.extern _inicio
.extern _ne_fim

.section .ne_legivel
.global ne_cabecalho

ne_cabecalho:
    // assinatura "NE\x00\x01"
    .byte 'N', 'E', 0x00, 0x01

    // tamanho total em bytes — resolvido pelo linker
    .word (_ne_fim - 0x40200000)

    // endereço do ponto de entrada — resolvido pelo linker
    .quad _inicio

    // versão do formato
    .word 0x00000001

    // reservado
    .word 0x00000000
    .quad 0x0000000000000000
