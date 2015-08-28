#include <stdio.h>
#include <sqlite3.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char** args)
{
    int retval;
    char query[100];
	char input[100];
    sqlite3_stmt *stmt;
    sqlite3 *handle;
    
input:
	fgets(input, sizeof(input), stdin);
	input[strlen(input)-1] = '\0'; // remove '\n'
	switch(input[0]) {
	default: goto input;
	case 'q': goto quit;
	case 'i': goto insert;
	case 'd': goto dump;
	}

insert:
	goto input;

dump:
	goto input;

quit:
    return 0;
}
