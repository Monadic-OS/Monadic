OBJS = boot.o main.o crtn.o crti.o crtbegin.o crtend.o
TARGET = kernel.o

include $(PWD)/make.config

CFLAG += -Iinclude

.PHONY: all
all : $(TARGET)

.PHONY: copy_hander
copy_hander :

$(TARGET) : $(OBJS)
	ld -r -s -o $@ $(OBJS)
	cp -f $@ $(PRN_BIN_DIR)/$@

crtbegin.o crtend.o:
	OBJ=`$(CC) $(CFLAG) -print-file-name=$(@F)` && cp "$$OBJ" $@

.s.o :
	$(AS) $< -o $@

.cpp.o :
	$(CC) -c $< -o $@ $(CFLAG) $(CPPFLAG)

.c.o :
	$(C) -c $< -o $@ $(CFLAG)

.PHONY: clean
clean :
	-rm *.o
