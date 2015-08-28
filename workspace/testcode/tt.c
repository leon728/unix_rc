#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define dprintf(...) {printf("hi~ "); printf(__VA_ARGS__)}
// #define dprintf(...)
// #define dprintf	printf
// #define dprintf(...) printf(__VA_ARGS__)

void main(int argc, char **argv) {
/*	if(argc > 1)
		dprintf("aa: %d\n", argc);
	else
		dprintf("bb: %d\n", argc);

	if(argc > 1) {
		dprintf("cc: %d\n", argc);
	}
	else {
		dprintf("dd: %d\n", argc);
	}*/

	if(argc > 1)
		dprintf("aa=%d\n", argc);
	dprintf("done\n");
}
