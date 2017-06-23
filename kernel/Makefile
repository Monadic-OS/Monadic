OBJS = boot.o kernel.o

include $(CONFIG)

all : $(OBJS)
	for target in $(OBJS); do \
		(mv -f $$target $(BIN_DIR)/) \
	done

.s.o :
	$(AS) $< -o $@

.c.o :
	$(GCC) -c $< -o $@ $(CFLAG) $(CPPFLAG)

run : Monadic.elf
	qemu-system-i386 -kernel Monadic.elf

clean :
	rm *.o
