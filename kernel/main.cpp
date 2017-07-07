#include <stdio.h>
#include <tty.h>

#ifdef __cplusplus
extern "C" {
#endif
void kernel_main(void) {
	terminal_initialize();

	printf("Kernel initialized!\n");
	printf("Hello, kernel World!\n");

}

#ifdef __cplusplus
}
#endif
