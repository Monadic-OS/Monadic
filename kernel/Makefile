OBJS = boot.o main.o
TARGET = kernel.o

include $(PWD)/make.config

.PHONY: all
all : $(TARGET)

$(TARGET) : $(OBJS)
	ld -r -s -o $@ $(OBJS)
	cp -f $@ $(BIN_DIR)/$@

.s.o :
	$(AS) $< -o $@

.c.o :
	$(GCC) -c $< -o $@ $(CFLAG) $(CPPFLAG)

.PHONY: clean
clean :
	-rm *.o
