#include <stdio.h>

#if defined(_is_libk)
#include <tty.h>
#endif

int putchar(const int ic) {
#if defined(_is_libk)
	char c = (char) ic;
	terminal_putchar(c);
#else
	// TODO: Implement stdio and the write system call.
#endif
	return ic;
}
