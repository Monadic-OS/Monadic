OBJS = boot.o main.o crtn.o crti.o crtbegin.o crtend.o
TARGET = kernel.o

include $(PWD)/make.config

CFLAG += -Iinclude

.PHONY: all
all : $(TARGET)

$(TARGET) : $(OBJS)
	ld -r -s -o $@ $(OBJS)
	cp -f $@ $(BIN_DIR)/$@

crtbegin.o crtend.o:
	OBJ=`$(CC) $(CFLAG) -print-file-name=$(@F)` && cp "$$OBJ" $@

.s.o :
	$(AS) $< -o $@

.c.o :
	$(CC) -c $< -o $@ $(CFLAG) $(CPPFLAG)

.PHONY: clean
clean :
	-rm *.o
