#include <stdio.h>
extern void fb();
void fa() {
	printf("== a\n");
	fb();
}
