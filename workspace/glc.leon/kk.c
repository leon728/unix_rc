#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <dirent.h>
#include <errno.h>
#include <unistd.h>
#include <sys/un.h>
#include <sys/socket.h>
#include <err.h>
#include <stdarg.h>
#include <pthread.h>


#define CLIENT_SOCK_PATH	"/tmp/aaa"
#define errmsg(msg)	warn("(%s:%d, %s) " msg, __func__, __LINE__, __FILE__)
#define dbgloc(msg)	fprintf(stderr, "(%s:%d, %s) " msg, __func__, __LINE__, __FILE__)



/*
	sock_path:
	recv_timeout: in seconds
*/
int init_socket(char *sock_path, int recv_timeout)
{
	int sockId;
	struct sockaddr_un cli_addr;
	int err;

	//	create socket
	sockId = socket(AF_UNIX, SOCK_DGRAM, 0);

	// set receive timeout
	if(recv_timeout > 0) {
		struct timeval timeout; 	 
		timeout.tv_sec = recv_timeout;
		timeout.tv_usec = 0;
		setsockopt(sockId, SOL_SOCKET, SO_RCVTIMEO, (char *)&timeout, sizeof(timeout));
	}

	// set bind address
	cli_addr.sun_family = AF_UNIX;
	snprintf(cli_addr.sun_path, sizeof(cli_addr.sun_path), "%s", sock_path);

	// set reuse address when binding
    // -- not useful in unix domain socket
	// int on = 1;
	// setsockopt(sockId, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
	// -- unix domain socket should remove the socket file
	unlink(cli_addr.sun_path);

	// bind to the address
	err = bind(sockId, (struct sockaddr *) &cli_addr, sizeof(struct sockaddr_un));
	if(err != 0) {
		errmsg("bind failed\n");
		goto fail;
	}

	return sockId;

fail:	
	close(sockId);
	return -1;
}

int socket_connect(int sock, char *path)
{
	struct sockaddr_un toaddr;
	int err;

	toaddr.sun_family = AF_UNIX;
	snprintf(toaddr.sun_path, sizeof(toaddr.sun_path), "%s", path);

	err = connect(sock, (struct sockaddr *) &toaddr, sizeof(struct sockaddr));
	if(err != 0) {
		errmsg("connect failed\n");
		return -1;
	}

	return 0;
}

int get_client_socket()
{
	static int sockId = -1;

	if(sockId == -1) {
		char spath[64];
		snprintf(spath, sizeof(spath), "%s_%d", CLIENT_SOCK_PATH, getpid());
		sockId = init_socket(spath, 3);
	}

	return sockId;
}

void *myserv(void *arg)
{
	char tmp[64];

	int ss = init_socket("/tmp/kkk", 0);
	int err = read(ss, tmp, sizeof(tmp));

	errmsg("read\n");
	printf("%d\n", err);
	printf("%d\n", errno);
}

void mainServer() {
	char tmp[64];
	struct sockaddr_un addr;
	int addrLen;

	memset(tmp, '-', sizeof(tmp));

	int ss = init_socket("/tmp/kkk", 0);
	while(1) {
		int rt;

		addrLen = sizeof(struct sockaddr_un);
		rt = recvfrom(ss, tmp, sizeof(tmp), 0, (struct sockaddr *)&addr, &addrLen);
		printf("read: %d\n", rt);

		addrLen = sizeof(struct sockaddr_un);
		rt = sendto(ss, tmp, 5, 0, (struct sockaddr *)&addr, addrLen);
		printf("write: %d\n", rt);
	}
}

void mainClient() {
	char tmp[64];
	int cs;
	struct sockaddr_un addr;
	int addrLen;

	cs = get_client_socket();

	// socket_connect(cs, "/tmp/kkk");
	addr.sun_family = AF_UNIX;
	strcpy(addr.sun_path, "/tmp/kkk");

	while(1) {
		int err;
		printf("press ENTER ...");
		getchar();

		addrLen = sizeof(struct sockaddr_un);
		err = sendto(cs, "hi", 3, 0, (struct sockaddr *)&addr, addrLen);
		printf("tx: %d\n", err);

		addrLen = sizeof(struct sockaddr_un);
		err = recvfrom(cs, tmp, sizeof(tmp), 0, (struct sockaddr *)&addr, &addrLen);
		printf("rx: %d\n", err);
	}
}

int main(int argc, char **argv) {
	if(argc > 1) {
		printf("client\n");
		mainClient();
	} else {
		printf("server\n");
		mainServer();
	}
}

int main0()
{
	pthread_t tid;

	errmsg("hi\n");
	dbgloc("yo\n");

	get_client_socket();
	get_client_socket();
	get_client_socket();

	pthread_create(&tid, NULL, myserv, NULL);

	sleep(1);

	int cs = get_client_socket();
	socket_connect(cs, "/tmp/kkk");
	write(cs, "hi", 3);

	while(1) {
		pause();
	}

	return 0;
}
