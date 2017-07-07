OBJS = $(patsubst %.c,%.o,$(wildcard *.c))
TARGET = stdio.o
SUB_BIN_DIR = bin
OBJS_DIR = $(addprefix $(SUB_BIN_DIR)/,$(OBJS))

include $(PWD)/make.config

CFLAG += -Iinclude -D_is_libk

.PHONY: all
all : create_bin_dir $(TARGET)

.PHONY: create_bin_dir
create_bin_dir :
	-@mkdir bin > /dev/null 2>&1 | true

$(TARGET) : $(OBJS_DIR)
	ld -r -s -o $@ $^
	cp -f $@ $(PRN_BIN_DIR)/$@

$(SUB_BIN_DIR)/%.o : %.c
	$(C) -c $< -o $@ $(CFLAG)

.PHONY: clean
clean :
	-rm -r bin
	-rm $(TARGET)
