HOST = i686-elf
PWD = $(shell pwd)
MAKE = make PWD=$(PWD)
SUB_PROS = stdio stdlib string
OBJS = $(addsuffix .o,$(SUB_PROS))
OBJS_DIR = $(addprefix bin/,$(OBJS))
TARGET = libk.a

include $(PWD)/make.config

.PHONY: all
all: $(TARGET)

$(TARGET) : cp_headers $(OBJS_DIR)
	$(AR) rcs $@ $(OBJS_DIR)
	cp -f $@ $(SYSROOT)$(LIBDIR)/$@

.PHONY: cp_headers
cp_headers :
	cp -f -r include/* $(SYSROOT)$(INCLUDEDIR)/

$(OBJS_DIR) : $(SUB_PROS)

.PHONY: $(SUB_PROS)
.ONESHELL: $(SUB_PROS)
$(SUB_PROS) :
	$(MAKE) -C $@

.PHONY: clean
clean :
	@for sub_target in $(SUB_PROS); do (\
		$(MAKE) -C $$sub_target clean \
	) done
	-rm bin/*.o
