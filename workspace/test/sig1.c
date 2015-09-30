#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>

void myHandler(int sig) {
	fprintf(stderr, "sig: %d\n", sig);
	sleep(5);
	fprintf(stderr, "sig: %d done\n", sig);
}

int main(int argc, char **argv) {
	{
		struct sigaction act;

		act.sa_flags = 0;
		act.sa_handler = myHandler;
		sigemptyset(&act.sa_mask);

		//sigaddset(&act.sa_mask, SIGALRM);

		//sigaction(SIGINT, &act, NULL);
		sigaction(SIGHUP, &act, NULL);
		sigaction(SIGKILL, &act, NULL);
		sigaction(SIGALRM, &act, NULL);
		sigaction(SIGTERM, &act, NULL);
	}

	sigset_t mask;
	sigset_t orig_mask;

	sigemptyset (&mask);
	//sigaddset (&mask, SIGINT);  // 2
	sigaddset (&mask, SIGHUP);  // 1
	sigaddset (&mask, SIGKILL); // 9
	sigaddset (&mask, SIGALRM); // 14
	sigaddset (&mask, SIGTERM); // 15

	//sigprocmask(SIG_BLOCK, &mask, &orig_mask);
	//getchar();
	//sigprocmask(SIG_SETMASK, &orig_mask, NULL);

	do {
		printf("hi~\n");
		sleep(1);
	} while(1);

	return 0;
}

