# Neon
meu bootloader + kernel feito em Assembly ARM64 e FPB.
por que Neon? Sei lá, me pareceu um nome legal kkkkkkk

## drivers:
1. Terminal UART (QEMU).
2. Disco VirtIO.

## bibliotecas:
1. Neon Script: uma biblioteca simples de comandos do terminal (e foi refeita em FPB :D).

# extra:
agora tem suporte a FPB (Fácil Programação Baixo nivel) :D

## comandos básicos do NS:
## no bootloader:
1. e: carrega o kernel do disco e executa
2. s: mostra os status do bootloader, versão, e o tamanho da pilha
## no kernel:
1. -ajuda: exibe todos os comandos disponíveis
2. -status: exibe a versão do kernel e o tamanho da pilha
