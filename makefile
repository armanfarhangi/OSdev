# makefile format is:
# name_of_rule: dependencies
# script

# first rule is run by default
run: os-image.bin
	qemu-system-x86_64 os-image.bin

# join boot sector and kernel binary
os-image.bin: boot_sect.bin kernel.bin
	cat boot_sect.bin kernel.bin > os-image.bin

# create boot sector binary
boot_sect.bin:
	nasm -i src/ -f bin src/boot/boot_sect.asm -o boot_sect.bin

# create kernel binary by linking its object files
kernel.bin: kernel_objects
	i386-elf-ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary

# compile kernel source into object files
kernel_objects:
	i386-elf-gcc -ffreestanding -c src/kernel/kernel.c -o kernel.o
	nasm src/kernel/entry.asm -f elf -o kernel_entry.o

clean:
	rm *.bin *.o
