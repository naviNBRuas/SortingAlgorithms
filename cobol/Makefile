# GnuCOBOL (https://gnucobol.sourceforge.io): `make test` compiles every program with the test driver and runs it.
COBC ?= cobc

test_runner: $(wildcard *.cob)
	$(COBC) -x -free -O -o $@ test.cob $(filter-out test.cob,$(wildcard *.cob))

test: test_runner
	./test_runner

clean:
	rm -f test_runner *.o *.c.l.h *.c

.PHONY: test clean
