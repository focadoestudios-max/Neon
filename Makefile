AS=as
LD=ld
OBJCOPY=objcopy

CODIGOS= \
	arquiteturas/arm64/boot.asm \
	nucleo/kernel.asm \
	biblis/ns.asm \
	drivers/qemu/terminal.asm
OBJETOS=$(CODIGOS:.asm=.o)

bootloader.bin: bootloader.elf
	$(OBJCOPY) -O binary $< $@

bootloader.elf: $(OBJETOS)
	$(LD) -nostdlib -T drivers/qemu/linker.ld $^ -o $@

%.o: %.asm
	$(AS) $< -o $@

limpar:
	rm -f $(OBJETOS) bootloader.elf bootloader.bin

qemu: bootloader.bin
	qemu-system-aarch64 \
	-machine virt \
	-cpu cortex-a53 \
	-m 128M \
	-kernel bootloader.bin \
	-nographic \
	-serial pty \
	-monitor none
.PHONY: limpar qemu