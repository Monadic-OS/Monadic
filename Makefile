PWD = $(shell pwd)

SUB_PROS = libc tty kernel
OBJS = kernel.o
LIBS = libk.a libtty.a

SUB_BIN_DIR = $(PWD)/bin

LIBS_DIR = $(addprefix $(SYSROOT)$(LIBDIR)/,$(LIBS))
OBJS_DIR = $(addprefix $(SUB_BIN_DIR)/,$(OBJS))

SUB_HANDER = $(addprefix copy_hander_,$(SUB_PROS))
SUB_CLEAN  = $(addprefix clean_,$(SUB_PROS))

include $(PWD)/make.config

.PHONY: all
all: create_sysroot copy_hander_all create_bin_dir Monadic.elf

.PHONY: create_bin_dir
create_bin_dir :
	-@mkdir bin > /dev/null 2>&1 | true

.PHONY: copy_hander_all $(SUB_HANDER)
copy_hander_all : $(SUB_HANDER)
	@echo "======================="
	@echo "|   End copy hander   |"
	@echo "======================="

$(SUB_HANDER) :
	$(MAKE) -C $(subst copy_hander_,,$@) copy_hander

.PHONY: create_sysroot
create_sysroot:
	-@mkdir $(SYSROOT)
	-@mkdir $(SYSROOT)$(PREFIX)
	-@mkdir $(SYSROOT)$(EXEC_PREFIX)
	-@mkdir $(SYSROOT)$(BOOTDIR)
	-@mkdir $(SYSROOT)$(LIBDIR)
	-@mkdir $(SYSROOT)$(INCLUDEDIR)
	@echo "========================"
	@echo "|  End create sysroot  |"
	@echo "========================"	

Monadic.elf : $(OBJS_DIR) kernel/linker.ld  $(SYSROOT)$(LIBDIR)/libk.a
	$(CC) -T kernel/linker.ld -o $@ -nostdlib $(OBJS_DIR) -lgcc -lk -ltty $(CFLAG)

$(filter-out $(LIBS_DIR) $(OBJS_DIR), $(SYSROOT)$(LIBDIR)/libk.a) : $(SYSROOT)$(LIBDIR)/libk.a
$(LIBS_DIR) $(OBJS_DIR) : $(SUB_PROS)

.PHONY: $(SUB_PROS)
.ONESHELL: $(SUB_PROS)
$(SUB_PROS) :
	$(MAKE) -C $@ PRN_BIN_DIR=$(SUB_BIN_DIR)

.PHONY: run
run : Monadic.elf
	qemu-system-i386 -kernel Monadic.elf

.PHONY: debug
debug : Monadic.elf
	nohup qemu-system-i386 -kernel Monadic.elf -gdb tcp::12345 -S &
	$(GDB) Monadic.elf
	killall -9 qemu-system-i386

.PHONY: clean $(SUB_CLEAN)
clean : $(SUB_CLEAN)
	-rm -r bin

$(SUB_CLEAN) :
	-$(MAKE) -C $(subst clean_,,$@) clean
