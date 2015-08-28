#.PHONY: m

export LD_LIBRARY_PATH := .

#b: ; gcc -fPIC -shared b.c -o libb.so; echo bbb
#f: ; gcc -fPIC -shared f.c -o libf.so; echo fff
b: ; gcc -fPIC -shared b.c -o libb.so
f: ; gcc -fPIC -shared f.c -o libf.so

# OK, but won't add shared library dependencies into output file
a1: ; gcc -fPIC -shared a.c -o liba.so
# won't work
a2: ; gcc -fPIC -shared a.c -o liba.so -Wl,-z,defs
# OK
a3: ; gcc -fPIC -shared a.c -o liba.so -L. -lb -lf
# OK
a4: ; gcc -fPIC -shared a.c -o liba.so -Wl,-z,defs -L. -lb -lf

# won't work
m1: ; gcc m.c -o m
# won't work
m2: ; gcc m.c -o m.out -L. -la
# OK
m3: ; gcc m.c -o m.out -L. -la -lb -lf

ddd: ; gcc ddd.c -o ddd.out -ldl

clean: ; rm -f lib*.so *.out

#run1: ; make b f a1 m3 ddd; LD_LIBRARY_PATH=. ./m.out; LD_LIBRARY_PATH=. ./ddd.out
run1: ; make b f a1 m3 ddd; ldd liba.so; ./m.out; ./ddd.out
run2: ; make b f a4 m3 ddd; ldd liba.so; ./m.out; ./ddd.out
