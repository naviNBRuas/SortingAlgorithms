// GENERATED from kernels/algos/insertion_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class InsertionSort {
    private InsertionSort() {}

    static void insertion_sort_impl(int[] a, long n) {
        long i = 0;
        long key = 0;
        long j = 0;
        long _e1 = 0;
        i = 1L;
        _e1 = n;
        while ((i < _e1)) {
            key = ((long)a[(int)(i)]);
            j = (i - 1L);
            while (((j >= 0L) && (((long)a[(int)(j)]) > key))) {
                a[(int)((j + 1L))] = (int)(((long)a[(int)(j)]));
                j = (j - 1L);
            }
            a[(int)((j + 1L))] = (int)(key);
            i = (i + 1);
        }
    }

    public static void sort(int[] a) {
        insertion_sort_impl(a, a.length);
    }
}
