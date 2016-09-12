
SRC = main.c s1.c snew.c
OBJ = $(SRC:%.c=objs/%.o)

#$(warning $(SRC))
#$(warning $(OBJ))


all: main
#all: $(OBJ)
	make listdir

listdir:
	ls -l -rt *

clean:
	rm -f main *.o libs/* mylibs/* objs/*
	make listdir

##########
run_s1: main
	LD_LIBRARY_PATH=libs ./main

run_snew: main
	LD_LIBRARY_PATH=mylibs ./main

##########
main: objs/main.o libs/libgo.so mylibs/libgo.so
	gcc -o $@ $< -L libs -l go
	#gcc -o $@ $< -L mylibs -l go

libs/libgo.so: objs/s1.o
	gcc -o $@ $^ -shared

mylibs/libgo.so: objs/snew.o
	gcc -o $@ $^ -shared

##########
objs/%.o: %.c
	gcc -MMD -MP -c -o $@ $^ -fPIC

-include $(OBJ:.o=.d)
