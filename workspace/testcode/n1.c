#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    int pipe;
    char ch;
    
    /* we expect a named pipe has been created in /tmp/named_pipe .
     * The command is a friend to get to this point
     *   $ mkfifo /tmp/named_pipe
     */
    pipe = open("/tmp/named_pipe", O_RDONLY);
    if (pipe < 0) {
        perror("Opening pipe");
        exit(1);
    }
    printf("opened\n");
        
    printf("Waiting data from the pipe... \n");
    /* reading one char a time from the pipe */
    while (1) {
		int r = read(pipe, &ch, 1);
        if (r < 0) {
            perror("Read the pipe");
            exit(2);
        }
		if(r == 0) {
			sleep(1);
			continue;
		}

        printf("%c", ch);
    }
    
    close(pipe);
    
    return 0;
}

