#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern void gogo();
extern void s1f1();

int main()
{
	gogo();
//	s1f1();
	
	return 0;
}

/*

gcc -shared -fPIC -o mylibs/libgo.so snew.c && \
gcc -shared -fPIC -o libs/libgo.so s1.c && \
gcc -o main main.c -L libs -l go && \
ll main libs/libgo.so mylibs/libgo.so

LD_LIBRARY_PATH=libs ./main
LD_LIBRARY_PATH=mylibs:libs ./main

*/
