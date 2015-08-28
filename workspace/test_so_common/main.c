#include <stdio.h>
#include <dlfcn.h>
#include <stdlib.h>

extern void fa();
extern void fb();
//extern int cm_add();

int main() {
	fa();
	fa();
	
	fb();
	fb();
	fb();
	
//	printf("main == %d\n", cm_add());
//	printf("main == %d\n", cm_add());
//	printf("main == %d\n", cm_add());
//	printf("main == %d\n", cm_add());

	return 0;
}
