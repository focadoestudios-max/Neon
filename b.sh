cp -rf /storage/emulated/0/pacotes/neon/ $HOME
cd bootloader
make
make limpar
make qemu
cp b.sh /storage/emulated/0/pacotes/neon/bootloader
