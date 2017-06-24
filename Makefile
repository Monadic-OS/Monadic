HOST = i686-elf
PWD = $(shell pwd)
MAKE = make PWD=$(PWD)
SUB_PROS = kernel
OBJS = kernel.o
OBJS_DIR = $(addprefix $(BIN_DIR)/,$(OBJS))

include $(PWD)/make.config

.PHONY: all
all: Monadic.elf

Monadic.elf : $(OBJS_DIR) kernel/linker.ld
	$(GCC) -T kernel/linker.ld -o $@ -nostdlib $(OBJS_DIR) -lgcc $(CFLAG)

$(OBJS_DIR) : $(SUB_PROS)

.PHONY: $(SUB_PROS)
.ONESHELL: $(SUB_PROS)
$(SUB_PROS) :
	$(MAKE) -C $@

.PHONY: run
run : Monadic.elf
	qemu-system-i386 -kernel Monadic.elf

.PHONY: clean
clean :
	@for sub_target in $(SUB_PROS); do (\
		$(MAKE) -C $$sub_target clean \
	) done
	-rm $(BIN_DIR)/*.o
