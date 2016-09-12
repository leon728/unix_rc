#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void gogo()
{
	//printf("gogo of s1\n");
	printf("[%s] %s@%d\n", __FILE__, __func__, __LINE__);
}

void s1f1()
{
	printf("[%s] %s@%d\n", __FILE__, __func__, __LINE__);
}
