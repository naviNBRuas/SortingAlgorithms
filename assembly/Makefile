# Pure-assembly sorts (GNU as, Intel syntax, x86-64 Linux, no libc dependency).
AS=as
CC=gcc
SRC=$(filter-out util.s,$(wildcard *.s)) $(wildcard generated/*.s)
OBJ=$(SRC:.s=.o) util.o

all: libsortasm.a

%.o: %.s
	$(AS) --64 -o $@ $<

libsortasm.a: $(OBJ)
	ar rcs $@ $^

test_runner: test.c libsortasm.a
	$(CC) -std=c17 -O1 -g -Wall test.c -L. -lsortasm -o $@

test: test_runner
	./test_runner

# Links the sorts with no libc whatsoever (raw syscalls only) and runs them.
freestanding: freestanding.c libsortasm.a
	$(CC) -std=gnu17 -O1 -nostdlib -static -ffreestanding -fno-stack-protector freestanding.c libsortasm.a -o freestanding_runner
	./freestanding_runner

# Same suite under Valgrind (detects reads/writes outside the caller's array)
memcheck: test_runner
	valgrind -q --error-exitcode=9 ./test_runner

clean:
	rm -f *.o generated/*.o *.a test_runner freestanding_runner

.PHONY: all test freestanding memcheck clean
