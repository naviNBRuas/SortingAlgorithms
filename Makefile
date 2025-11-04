CC = gcc
CFLAGS = -Wall -Wextra -std=c11 -O2 -Isrc/c -lm

SRCS = bubble_sort.c insertion_sort.c selection_sort.c merge_sort.c quick_sort.c bogo_sort.c cocktail_shaker_sort.c shell_sort.c bucket_sort.c radix_sort.c counting_sort.c heap_sort.c comb_sort.c gnome_sort.c timsort.c introsort.c src/c/cjson/cJSON.c

# Add your C test source files here
TEST_SRCS = tests/c/test_bubble_sort.c tests/c/test_insertion_sort.c tests/c/test_selection_sort.c tests/c/test_merge_sort.c tests/c/test_quick_sort.c tests/c/test_bogo_sort.c tests/c/test_cocktail_shaker_sort.c tests/c/test_shell_sort.c tests/c/test_bucket_sort.c tests/c/test_radix_sort.c tests/c/test_counting_sort.c tests/c/test_heap_sort.c tests/c/test_comb_sort.c tests/c/test_gnome_sort.c tests/c/test_timsort.c

# Executable names
TARGETS = $(SRCS:.c=.out)
TEST_TARGETS = tests/c/test_bubble_sort.test tests/c/test_insertion_sort.test tests/c/test_selection_sort.test tests/c/test_merge_sort.test tests/c/test_quick_sort.test tests/c/test_bogo_sort.test tests/c/test_cocktail_shaker_sort.test tests/c/test_shell_sort.test tests/c/test_bucket_sort.test tests/c/test_radix_sort.test tests/c/test_counting_sort.test tests/c/test_heap_sort.test tests/c/test_comb_sort.test tests/c/test_gnome_sort.test tests/c/test_timsort.test

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

# Explicit rule to build test_counting_sort.test
tests/c/test_counting_sort.test: tests/c/test_counting_sort.c src/c/counting_sort.c
	$(CC) $(CFLAGS) -o $@ tests/c/test_counting_sort.c src/c/counting_sort.c

# Explicit rule to build test_heap_sort.test
tests/c/test_heap_sort.test: tests/c/test_heap_sort.c src/c/heap_sort.c
	$(CC) $(CFLAGS) -o $@ tests/c/test_heap_sort.c src/c/heap_sort.c

# Explicit rule to build test_comb_sort.test
tests/c/test_comb_sort.test: tests/c/test_comb_sort.c src/c/comb_sort.c src/c/cjson/cJSON.c
	$(CC) $(CFLAGS) -o $@ tests/c/test_comb_sort.c src/c/comb_sort.c src/c/cjson/cJSON.c

# Explicit rule to build test_gnome_sort.test
tests/c/test_gnome_sort.test: tests/c/test_gnome_sort.c src/c/gnome_sort.c src/c/cjson/cJSON.c
	$(CC) $(CFLAGS) -o $@ tests/c/test_gnome_sort.c src/c/gnome_sort.c src/c/cjson/cJSON.c

# Explicit rule to build test_timsort.test
tests/c/test_timsort.test: tests/c/test_timsort.c src/c/timsort.c
	$(CC) $(CFLAGS) -o $@ tests/c/test_timsort.c src/c/timsort.c

# Explicit rule to build test_introsort.test
tests/c/test_introsort.test: tests/c/test_introsort.c src/c/introsort.c
	$(CC) $(CFLAGS) -o $@ tests/c/test_introsort.c src/c/introsort.c -lm

clean:
	rm -f $(TARGETS) $(TEST_TARGETS) *.o
