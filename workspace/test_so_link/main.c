#include <stdio.h>
#include <dlfcn.h>
#include <stdlib.h>

extern void fa();

int main() {
	printf("== main\n");
#if 1
	fa();
#else
	{
		void *handle;
		void (*func)(void);
		
		handle = dlopen("liba.so", RTLD_LAZY);
		if(handle == NULL) {
			printf("%s\n", dlerror());
			exit(-1);
		}
		
		dlerror();    /* Clear any existing error */
		
		*(void **)&func = dlsym(handle, "fa");
		//func = dlsym(handle, "fa");
		
		if(dlerror() != NULL) {
			dlclose(handle);
			printf("load sym error\n");
			exit(-1);
		}
		
		func();
		dlclose(handle);
	}
#endif
	return 0;
}
