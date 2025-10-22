CC = gcc
CFLAGS = -Wall -Wextra -std=c11 -O2

SRCS = bubble_sort.c insertion_sort.c selection_sort.c merge_sort.c quick_sort.c bogo_sort.c cocktail_shaker_sort.c shell_sort.c bucket_sort.c radix_sort.c

# Add your C test source files here
TEST_SRCS = tests/c/test_bubble_sort.c tests/c/test_insertion_sort.c tests/c/test_selection_sort.c tests/c/test_merge_sort.c tests/c/test_quick_sort.c tests/c/test_bogo_sort.c tests/c/test_cocktail_shaker_sort.c tests/c/test_shell_sort.c tests/c/test_bucket_sort.c tests/c/test_radix_sort.c

# Executable names
TARGETS = $(SRCS:.c=.out)
TEST_TARGETS = tests/c/test_bubble_sort.test tests/c/test_insertion_sort.test tests/c/test_selection_sort.test tests/c/test_merge_sort.test tests/c/test_quick_sort.test tests/c/test_bogo_sort.test tests/c/test_cocktail_shaker_sort.test tests/c/test_shell_sort.test tests/c/test_bucket_sort.test tests/c/test_radix_sort.test

.PHONY: all clean tests

all: $(TARGETS)

tests: $(TEST_TARGETS)

# Rule to build executables
%.out: src/c/%.c
	$(CC) $(CFLAGS) -DSTANDALONE_APP -o $@ $<

# Explicit rule to build test_bubble_sort.test
tests/c/test_bubble_sort.test: tests/c/test_bubble_sort.c src/c/bubble_sort.c
	$(CC) $(CFLAGS) -o $@ tests/c/test_bubble_sort.c src/c/bubble_sort.c

# Explicit rule to build test_insertion_sort.test
tests/c/test_insertion_sort.test: tests/c/test_insertion_sort.c src/c/insertion_sort.c
	$(CC) $(CFLAGS) -o $@ tests/c/test_insertion_sort.c src/c/insertion_sort.c

# Explicit rule to build test_selection_sort.test
tests/c/test_selection_sort.test: tests/c/test_selection_sort.c src/c/selection_sort.c
	$(CC) $(CFLAGS) -o $@ tests/c/test_selection_sort.c src/c/selection_sort.c

# Explicit rule to build test_merge_sort.test
tests/c/test_merge_sort.test: tests/c/test_merge_sort.c src/c/merge_sort.c
	$(CC) $(CFLAGS) -o $@ tests/c/test_merge_sort.c src/c/merge_sort.c

# Explicit rule to build test_quick_sort.test
tests/c/test_quick_sort.test: tests/c/test_quick_sort.c src/c/quick_sort.c
	$(CC) $(CFLAGS) -o $@ tests/c/test_quick_sort.c src/c/quick_sort.c

# Explicit rule to build test_bogo_sort.test
tests/c/test_bogo_sort.test: tests/c/test_bogo_sort.c src/c/bogo_sort.c
	$(CC) $(CFLAGS) -o $@ tests/c/test_bogo_sort.c src/c/bogo_sort.c

# Explicit rule to build test_cocktail_shaker_sort.test
tests/c/test_cocktail_shaker_sort.test: tests/c/test_cocktail_shaker_sort.c src/c/cocktail_shaker_sort.c
	$(CC) $(CFLAGS) -o $@ tests/c/test_cocktail_shaker_sort.c src/c/cocktail_shaker_sort.c

# Explicit rule to build test_shell_sort.test
tests/c/test_shell_sort.test: tests/c/test_shell_sort.c src/c/shell_sort.c
	$(CC) $(CFLAGS) -o $@ tests/c/test_shell_sort.c src/c/shell_sort.c

# Explicit rule to build test_bucket_sort.test
tests/c/test_bucket_sort.test: tests/c/test_bucket_sort.c src/c/bucket_sort.c
	$(CC) $(CFLAGS) -o $@ tests/c/test_bucket_sort.c src/c/bucket_sort.c

# Explicit rule to build test_radix_sort.test
tests/c/test_radix_sort.test: tests/c/test_radix_sort.c src/c/radix_sort.c
	$(CC) $(CFLAGS) -o $@ tests/c/test_radix_sort.c src/c/radix_sort.c

clean:
	rm -f $(TARGETS) $(TEST_TARGETS) *.o
