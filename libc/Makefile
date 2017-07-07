HOST = i686-elf
SUB_PROS = stdio stdlib string
OBJS = $(addsuffix .o,$(SUB_PROS))
OBJS_DIR = $(addprefix bin/,$(OBJS))
TARGET = libk.a
SUB_BIN_DIR = $(shell pwd)/bin
SUB_CLEAN  = $(addprefix clean_,$(SUB_PROS))

include $(PWD)/make.config

.PHONY: all
all: $(TARGET)

$(TARGET) : cp_headers create_bin_dir $(OBJS_DIR)
	$(AR) rcs $@ $(OBJS_DIR)
	cp -f $@ $(SYSROOT)$(LIBDIR)/$@

.PHONY: create_bin_dir
create_bin_dir :
	-@mkdir bin > /dev/null 2>&1 | true

.PHONY: copy_hander
copy_hander : cp_headers

.PHONY: cp_headers
cp_headers :
	cp -f -r include/* $(SYSROOT)$(INCLUDEDIR)/

$(OBJS_DIR) : $(SUB_PROS)

.PHONY: $(SUB_PROS)
.ONESHELL: $(SUB_PROS)
$(SUB_PROS) :
	$(MAKE) -C $@ PRN_BIN_DIR=$(SUB_BIN_DIR)

.PHONY: clean $(SUB_CLEAN)
clean : $(SUB_CLEAN)
	-rm -r bin
	-rm $(TARGET)

$(SUB_CLEAN) :
	-$(MAKE) -C $(subst clean_,,$@) clean
