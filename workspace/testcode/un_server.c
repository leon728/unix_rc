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

    remove(SERVERSOCK_PATH);
    err = bind(sock, (struct sockaddr *)&servaddr, sizeof(servaddr)); check("bind", err);

    // err = listen(sock, 10); check("listen", err);
    // sock = accept(sock, NULL, NULL); check("accept", sock);

    // read, recv, recvfrom
    // write, send, sendto

    err = read(sock, messagebuf, MAX_MSGLEN); check("recv", err);
    err = recv(sock, messagebuf, MAX_MSGLEN, 0); check("recv", err);
    err = recvfrom(sock, messagebuf, MAX_MSGLEN, 0, NULL, NULL); check("recv", err);

    while(1) {
        printf("press ENTER\n"); getchar();
        err = read(sock, messagebuf, MAX_MSGLEN); check("recv", err);
    }

    // close(sock);

    return 0;
}
