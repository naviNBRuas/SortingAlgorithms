# Header-only C++17 sorts (generated). `make test` builds and runs the test driver.
CXX ?= g++
CXXFLAGS ?= -std=c++17 -O2 -Wall -Wextra -Iinclude

test_runner: tests/tests.cpp $(wildcard include/sorting/*.hpp)
	$(CXX) $(CXXFLAGS) tests/tests.cpp -o $@

test: test_runner
	./test_runner

clean:
	rm -f test_runner

.PHONY: test clean
