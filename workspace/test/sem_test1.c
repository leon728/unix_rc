#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>           /* For O_* constants */
#include <sys/stat.h>        /* For mode constants */
#include <semaphore.h>

#define dbgloc(msg)	fprintf(stderr, "(%s:%d, %s) " msg, __func__, __LINE__, __FILE__)
#define SEM_NAME	"/leont1"

int main(int argc, char **argv) {
	int rc;
	sem_t *s1;
	int sv;

	//s1 = sem_open(SEM_NAME, O_CREAT | O_EXCL, O_RDWR, 5);
	//s1 = sem_open(SEM_NAME, 5);
	s1 = sem_open(SEM_NAME, O_CREAT, 00777, 5);
	if(s1 == NULL)
		perror("ff1\n");

	if(argv[1][0] == 'g') {
		rc = sem_wait(s1); if(rc != 0) dbgloc("\n");
	}
	else if(argv[1][0] == 'p') {
		rc = sem_post(s1); if(rc != 0) dbgloc("\n");
	}
	else if(argv[1][0] == 'v') {
		rc = sem_getvalue(s1, &sv); if(rc != 0) dbgloc("\n");
		printf("sv: %d\n", sv);
	}
	else if(argv[1][0] == 'c') {
		rc = sem_close(s1); if(rc != 0) dbgloc("\n");
	}

	return 0;
}
