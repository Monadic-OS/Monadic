#include <cstdlib>
#include <cstdio>

void __assert (const char *msg, const char *file, int line) {
	printf("Assert !");
	abort();
}