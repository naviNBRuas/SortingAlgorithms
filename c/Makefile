CC=gcc
CFLAGS=-std=c17 -Wall -Wextra -O2
SRC=$(wildcard src/*.c)
OBJ=$(SRC:.c=.o)

all: libsort.a example

libsort.a: $(OBJ)
	ar rcs $@ $^

example: example.c libsort.a
	$(CC) $(CFLAGS) example.c -L. -lsort -lm -o $@

clean:
	rm -f $(OBJ) *.a example test_runner

test: libsort.a test.c
	$(CC) $(CFLAGS) test.c -L. -lsort -lm -o test_runner && ./test_runner

.PHONY: all clean test
