#include <stdio.h>
#include <mqueue.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <string.h>


#define MSGQOBJ_NAME    "/myqueue123"
#define MAX_MSG_LEN     8192

// #define SEND    1


void dump(mqd_t msgq_id) {
    struct mq_attr attr;
    if (mq_getattr(msgq_id, &attr) == -1)
        perror("mq_getattr");
    printf("%ld, %ld, %ld, %ld\n", attr.mq_flags, attr.mq_maxmsg, attr.mq_msgsize, attr.mq_curmsgs);
}

void msend() {

}

int main(int argc, char *argv[]) {
    mqd_t msgq_id;
    unsigned int msgprio = 3;
    char msgcontent[MAX_MSG_LEN];
    unsigned int sender;
    char *mq_name;
    int msgsz;


    mq_name = argv[1];
    msgprio = atoi(argv[2]);

#if SEND
    msgq_id = mq_open(MSGQOBJ_NAME, O_RDWR | O_CREAT, S_IRWXU | S_IRWXG, NULL);
#else
    msgq_id = mq_open(MSGQOBJ_NAME, O_RDWR);
#endif
    if (msgq_id == (mqd_t)-1) {
        perror("In mq_open()");
        exit(1);
    }

    dump(msgq_id);

    snprintf(msgcontent, MAX_MSG_LEN, "Hello from process.");

#if SEND
    mq_send(msgq_id, msgcontent, strlen(msgcontent)+1, msgprio); dump(msgq_id);
    mq_send(msgq_id, msgcontent, strlen(msgcontent)+1, msgprio); dump(msgq_id);

    msgsz = mq_receive(msgq_id, msgcontent, MAX_MSG_LEN, &sender); dump(msgq_id);
    printf("Received message (%d bytes) from %d: %s\n", msgsz, sender, msgcontent);

    msgsz = mq_receive(msgq_id, msgcontent, MAX_MSG_LEN, &sender); dump(msgq_id);
    printf("Received message (%d bytes) from %d: %s\n", msgsz, sender, msgcontent);

    msgsz = mq_receive(msgq_id, msgcontent, MAX_MSG_LEN, &sender); dump(msgq_id);
    printf("Received message (%d bytes) from %d: %s\n", msgsz, sender, msgcontent);
#else
    msgsz = mq_receive(msgq_id, msgcontent, MAX_MSG_LEN, &sender); dump(msgq_id);
    printf("Received message (%d bytes) from %d: %s\n", msgsz, sender, msgcontent);
#endif

    mq_close(msgq_id);
    
    return 0;
}
