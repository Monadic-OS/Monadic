OBJS = terminal.o
TARGET = tty.o

include $(PWD)/make.config

CFLAG += -Iinclude

.PHONY: all
all : cp_headers $(TARGET)

.PHONY: cp_headers
cp_headers :
	cp -f include/* $(SYSROOT)$(INCLUDEDIR)/

$(TARGET) : $(OBJS)
	ld -r -s -o $@ $(OBJS)
	cp -f $@ $(BIN_DIR)/$@

.s.o :
	$(AS) $< -o $@

.c.o :
	$(CC) -c $< -o $@ $(CFLAG) $(CPPFLAG)

.PHONY: clean
clean :
	-rm *.o
