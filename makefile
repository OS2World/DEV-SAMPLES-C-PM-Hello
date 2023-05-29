# make makefile
#
# Tools used:
#  Compile::Watcom Resource Compiler
#
#  Compile::GNU C
#  Make: GNU make
all : hello.exe

hello.exe : hello.obj hello.res hello.def
	gcc -Zomf hello.obj hello.def -o hello.exe
	wrc hello.res

hello.obj : hello.c hello.h
	gcc -Wall -Zomf -c -O2 hello.c -o hello.obj

hello.res : hello.rc 
	wrc -r hello.rc

clean :
	rm -rf *exe *res *obj
