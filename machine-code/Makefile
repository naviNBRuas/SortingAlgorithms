# Raw x86-64 machine-code images for every sort (see README.md).
all:
	python3 build.py

test_runner: test.c table.h
	$(CC) -std=gnu17 -O1 -Wall test.c -o $@

test: all test_runner
	./test_runner

clean:
	rm -rf bin hex MANIFEST.txt test_runner

.PHONY: all test clean
