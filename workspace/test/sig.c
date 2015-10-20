#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>           /* For O_* constants */
#include <sys/stat.h>        /* For mode constants */
#include <semaphore.h>
#include <signal.h>
#include <unistd.h>
#include <sys/syslog.h>
#include <sys/wait.h>
#include <errno.h>

#define dbgloc(msg)	fprintf(stderr, "(%s:%d, %s) " msg, __func__, __LINE__, __FILE__)
#define SEM_NAME	"/leont1"

void childHandler(int sig)
{
	while(waitpid(-1, NULL, WNOHANG) > 0)
	{
		;
	}
}

void myHandler(int sig)
{
	printf("-- pid[%d], tid[%d], sig: %d\n", getpid(), pthread_self(), sig);
	while(1)
	{
		sleep(1);

		int pid = waitpid(-1, NULL, WNOHANG);
		printf("rrr: %d\n", pid);

		if(pid < 0)
			perror("");
		if(pid <= 0)
			break;
	}
	printf("-- pid[%d], tid[%d], sig: %d ----\n", getpid(), pthread_self(), sig);
}

#include <execinfo.h>
#include <stdio.h>
#include <stdlib.h>

void dummyFork()
{
	int child_pid = fork();
	if(child_pid > 0) {
		// parent
		return;
	}
	else {
		printf("child: pid[%d], tid[%d]\n", getpid(), pthread_self());

		sleep(2);

		execl("ls", "", (char*)NULL);
		//execlp("ls", (char*)NULL);
		exit(0);
	}
}

int main(int argc, char **argv)
{
	setbuf(stdout, NULL);
	setbuf(stderr, NULL);

	printf("main: pid[%d], tid[%d]\n", getpid(), pthread_self());

	if(argc > 1 && argv[1][0] == '1')
	{
		struct sigaction childAct;

		childAct.sa_handler = SIG_DFL;
		childAct.sa_handler = SIG_IGN;
		childAct.sa_handler = myHandler;

		childAct.sa_flags = SA_NOCLDSTOP | SA_NOCLDWAIT;
		childAct.sa_flags = SA_NOCLDSTOP;

		sigemptyset(&childAct.sa_mask);

		sigaction(SIGCHLD, &childAct, NULL);
	}

#if 1
	dummyFork();
	dummyFork();
	dummyFork();
	while(1)
	{
		sleep(1);
	}
#endif

#if 0
	int child_pid = fork();
	
	if(child_pid > 0) {
		// parnt
		//printf("parent: pid[%d], tid[%d]\n", getpid(), pthread_self());
		
		while(1)
		{
			sleep(1);
		}

		exit(456);
	}
	else {
		// child
		printf("child: pid[%d], tid[%d]\n", getpid(), pthread_self());

		sleep(3);
		exit(123);
	}
#endif

#if 0
	while(1)
	{
		int r = system("sleep 3");
		printf("r=%d\n", r);

		getchar();
	}
#endif
}
