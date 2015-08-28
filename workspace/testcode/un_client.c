#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

#define MAX_MSGLEN      100
#define SERVERSOCK_PATH     "/tmp/uuss"

#define check(msg, var) {printf(msg ": %d", var); perror(" -- perr");}

int main() {
    setbuf(stdout, NULL); setbuf(stderr, NULL);

    int sock, err;
    char ch, messagebuf[MAX_MSGLEN];
    struct sockaddr_un servaddr;

    // sock = socket(AF_UNIX, SOCK_STREAM, 0); check("socket", sock);
    // sock = socket(AF_UNIX, SOCK_SEQPACKET, 0); check("socket", sock);
    sock = socket(AF_UNIX, SOCK_DGRAM, 0); check("socket", sock);

    servaddr.sun_family = AF_UNIX;
    sprintf(servaddr.sun_path, SERVERSOCK_PATH);

    err = connect(sock, (struct sockaddr *)&servaddr, sizeof(servaddr)); check("connect", err);

    // read, recv, recvfrom
    // write, send, sendto

    char *hello = "hello\n";
    err = write(sock, hello, strlen(hello)); check("send", err);
    err = send(sock, hello, strlen(hello), 0); check("send", err);
    err = sendto(sock, hello, strlen(hello), 0, NULL, 0); check("send", err);

    while(1) {
        printf("press ENTER\n"); getchar();
        err = write(sock, hello, strlen(hello)); check("send", err);
    }

    // close(sock);

    return 0;
}
