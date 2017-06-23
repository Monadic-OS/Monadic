HOST = i686-elf
CONFIG = $(shell pwd)/make.config
BIN_DIR = $(shell pwd)/bin
MAKE = make CONFIG=$(CONFIG)
SUB_PROS = kernel
OBJS = boot.o kernel.o

include $(CONFIG)

all: Monadic.elf

Monadic.elf : $(addprefix $(BIN_DIR)/,$(OBJS)) kernel/linker.ld
	$(GCC) -T kernel/linker.ld -o $@ -nostdlib $(addprefix $(BIN_DIR)/,$(OBJS)) -lgcc $(CFLAG)

$(addprefix $(BIN_DIR)/,$(OBJS)) :
	for sub_target in $(SUB_PROS); do \
		(cd $$sub_target && $(MAKE) BIN_DIR=$(BIN_DIR)) \
	done

run : Monadic.elf
	qemu-system-i386 -kernel Monadic.elf

clean :
	for sub_target in $(SUB_PROS); do \
		(cd $$sub_target && $(MAKE) BIN_DIR=$(BIN_DIR) clean) \
	done
