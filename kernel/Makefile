AS  = i686-elf-as
GCC = i686-elf-gcc

Monadic.elf : boot.o kernel.o linker.ld
	$(GCC) -T linker.ld -o Monadic.elf -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

boot.o : boot.s
	$(AS) boot.s -o boot.o

kernel.o : kernel.c
	$(GCC) -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

run : Monadic.elf
	qemu-system-i386 -kernel Monadic.elf

clean :
	rm *.o
