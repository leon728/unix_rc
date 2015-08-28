
all: lib/libb.so lib/liba.so main

lib/libb.so: b.c
	gcc -shared -fPIC -o $@ $^

lib/liba.so: a.c
	#gcc -shared -fPIC -o $@ $^
	#gcc -shared -fPIC -o $@ $^ -Wl,-z,defs
	gcc -shared -fPIC -o $@ $^ -Llib -lb
	#gcc -shared -fPIC -o $@ $^ lib/libb.so

main: main.c
	-cp lib/* lib2
	#gcc -o $@ $^ -Llib2 -lb -la
	gcc -o $@ $^ -Llib2 -la -lb
	#gcc -o $@ $^ -ldl

run:
	LD_LIBRARY_PATH=$(CURDIR)/lib2 ./main

clean:
	rm -f liba.so libb.so main lib/* lib2/*
