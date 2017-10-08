nasm -i ../src/ -f bin ../src/boot_sect.asm -o boot_sect.bin\
 && qemu-system-x86_64 -fda boot_sect.bin
