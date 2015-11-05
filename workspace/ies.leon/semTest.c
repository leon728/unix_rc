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
	char *semName = SEM_NAME;
	char action = 'v';
	int si;

	if(argc <= 1) {
		printf("Usage: semTest <g|p|v> [sem_name]");
		return 0;
	}

	if(argc > 1)
		action = argv[1][0];

	for(si = 2; si < argc; si++)
	{
		semName = argv[si];

		s1 = sem_open(semName, O_CREAT, 00777, 5);
		if(s1 == NULL)
			perror("ff1\n");

		if(action == 'g') {
			rc = sem_wait(s1); if(rc != 0) dbgloc("\n");
		}
		else if(action == 'p') {
			rc = sem_post(s1); if(rc != 0) dbgloc("\n");
		}
		else if(action == 'v') {
			rc = sem_getvalue(s1, &sv); if(rc != 0) dbgloc("\n");
			// printf("sv[%50s]: %d\n", semName, sv);
			printf("%d,", sv);
		}
		else if(action == 'l') {
			rc = sem_getvalue(s1, &sv); if(rc != 0) dbgloc("\n");
			printf("%4d  %s\n", sv, semName);
		}

		rc = sem_close(s1); if(rc != 0) dbgloc("\n");
	}
	printf("\n");

	return 0;
}
