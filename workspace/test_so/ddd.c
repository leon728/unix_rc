#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>

int
main(int argc, char **argv)
{
	void *handle;
	void (*cosine)(void);
	char *error;

	handle = dlopen("liba.so", RTLD_LAZY);
	if (!handle) {
		fprintf(stderr, "%s\n", dlerror());
		exit(EXIT_FAILURE);
	}

	dlerror();    /* Clear any existing error */

	cosine = dlsym(handle, "func_a");

	if ((error = dlerror()) != NULL)  {
		fprintf(stderr, "%s\n", error);
		exit(EXIT_FAILURE);
	}

	puts("this is ddd");
	cosine();
	dlclose(handle);
	exit(EXIT_SUCCESS);
}
