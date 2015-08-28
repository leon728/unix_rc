
all: libb.so liba.so main

libcommon.so:
	gcc -g -shared -fPIC -o $@ common.c

libb.so:
	#gcc -g -shared -fPIC -o $@ b.c -L. -lcommon
	gcc -g -shared -fPIC -o $@ b.c common.c -Dkk=5

liba.so:
	#gcc -g -shared -fPIC -o $@ a.c -L. -lcommon
	gcc -g -shared -fPIC -o $@ a.c common.c -Dkk=10

main: main.c
	#gcc -g -o $@ $^ -L. -la -lb
	gcc -g -o $@ $^ -L. -lb -la

run:
	LD_LIBRARY_PATH=$(CURDIR) ./main

clean:
	rm -f libcommon.so liba.so libb.so main
