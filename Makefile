HOST = i686-elf
PWD = $(shell pwd)
MAKE = make PWD=$(PWD)
SUB_PROS = libc tty kernel
OBJS = kernel.o
LIBS = libk.a libtty.a
LIBS_DIR = $(addprefix $(SYSROOT)$(LIBDIR)/,$(LIBS))
OBJS_DIR = $(addprefix $(BIN_DIR)/,$(OBJS))

include $(PWD)/make.config

.PHONY: all
all: create_sysroot Monadic.elf

.PHONY: create_sysroot
create_sysroot:
	-@mkdir $(SYSROOT)
	-@mkdir $(SYSROOT)$(PREFIX)
	-@mkdir $(SYSROOT)$(EXEC_PREFIX)
	-@mkdir $(SYSROOT)$(BOOTDIR)
	-@mkdir $(SYSROOT)$(LIBDIR)
	-@mkdir $(SYSROOT)$(INCLUDEDIR)

Monadic.elf : $(OBJS_DIR) kernel/linker.ld  $(SYSROOT)$(LIBDIR)/libk.a
	$(CC) -T kernel/linker.ld -o $@ -nostdlib $(OBJS_DIR) -lgcc -lk -ltty $(CFLAG)

$(filter-out $(LIBS_DIR) $(OBJS_DIR), $(SYSROOT)$(LIBDIR)/libk.a) : $(SYSROOT)$(LIBDIR)/libk.a
$(LIBS_DIR) $(OBJS_DIR) : $(SUB_PROS)

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
