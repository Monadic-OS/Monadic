OBJS = $(patsubst %.c,%.o,$(wildcard *.c))
TARGET = stdio.o

include $(PWD)/make.config

CFLAG += -Iinclude -D_is_libk
BIN_DIR = $(PWD)/libc/bin

.PHONY: all
all : $(TARGET)

$(TARGET) : $(OBJS)
	ld -r -s -o $@ $(OBJS)
	cp -f $@ $(BIN_DIR)/$@

.c.o :
	$(CC) -c $< -o $@ $(CFLAG) $(CPPFLAG)

.PHONY: clean
clean :
	-rm *.o
