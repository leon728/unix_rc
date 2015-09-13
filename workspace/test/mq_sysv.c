#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/msg.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(int argc, char** argv)
{
	int mqId;
	int rt;
	char data[32];

	open("/tmp/alarmAction.mq", O_CREAT | O_RDWR, 00666);
	key_t mqKey = ftok("/tmp/alarmAction.mq", 'b');
	mqId = msgget(mqKey, IPC_CREAT | 00666);
	printf("msg queue for alarm action: key=0x%08x, id=%d\n", (int)mqKey, mqId);
//	msgctl(mqId, IPC_RMID, NULL);

if(argc > 1) {
	strcpy(data, argv[1]);
	rt = msgsnd(mqId, data, strlen(data)+1, 0);
	printf("rt=%d\n", rt);
} else {
	rt = msgrcv(mqId, data, 16, 0, 0);
	printf("rt=%d\n", rt);
	printf("%s\n", data);
}
	return 0;
}

