// GENERATED from kernels/algos/binary_insertion_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class BinaryInsertionSort {
    private BinaryInsertionSort() {}

    static void binary_insertion_sort_impl(int[] a, long n) {
        long i = 0;
        long key = 0;
        long lo = 0;
        long hi = 0;
        long mid = 0;
        long j = 0;
        long _e1 = 0;
        i = 1L;
        _e1 = n;
        while ((i < _e1)) {
            key = ((long)a[(int)(i)]);
            lo = 0L;
            hi = i;
            while ((lo < hi)) {
                mid = ((lo + hi) / 2L);
                if ((key < ((long)a[(int)(mid)]))) {
                    hi = mid;
                } else {
                    lo = (mid + 1L);
                }
            }
            j = i;
            while ((j > lo)) {
                a[(int)(j)] = (int)(((long)a[(int)((j - 1L))]));
                j = (j - 1L);
            }
            a[(int)(lo)] = (int)(key);
            i = (i + 1);
        }
    }

    public static void sort(int[] a) {
        binary_insertion_sort_impl(a, a.length);
    }
}
