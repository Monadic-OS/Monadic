OBJS = terminal.o
TARGET = libtty.a

include $(PWD)/make.config

CFLAG += -Iinclude

.PHONY: all
all : cp_headers $(TARGET)

.PHONY: copy_hander
copy_hander : cp_headers

.PHONY: cp_headers
cp_headers :
	cp -f include/* $(SYSROOT)$(INCLUDEDIR)/

$(TARGET) : $(OBJS)
	$(AR) rcs $@ $(OBJS)
	cp -f $@ $(SYSROOT)$(LIBDIR)/$@

.s.o :
	$(AS) $< -o $@

.c.o :
	$(CC) -c $< -o $@ $(CFLAG) $(CPPFLAG)

.PHONY: clean
clean :
	-rm $(TARGET)
	-rm *.o
