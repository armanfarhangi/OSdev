# makefile format is:
# name_of_rule: dependencies
# script

# first rule is run by default
run: boot_sect.bin
	qemu-system-x86_64 -fda boot_sect.bin

boot_sect.bin:
	nasm -i src/ -f bin src/boot/boot_sect.asm -o boot_sect.bin

clean:
	rm *.bin
