OBJS = boot.o kernel.o

include $(CONFIG)

all : $(OBJS)
	for target in $(OBJS); do \
		(cp -f $$target $(BIN_DIR)/) \
	done

.s.o :
	$(AS) $< -o $@

.c.o :
	$(GCC) -c $< -o $@ $(CFLAG) $(CPPFLAG)

clean :
	rm $(BIN_DIR)/*.o
	rm *.o
