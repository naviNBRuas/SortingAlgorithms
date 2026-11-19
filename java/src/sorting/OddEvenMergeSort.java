// GENERATED from kernels/algos/odd_even_merge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class OddEvenMergeSort {
    private OddEvenMergeSort() {}

    static void odd_even_merge_sort_x_cmp_swap(int[] a, long i, long j) {
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        if ((((long)a[(int)(i)]) > ((long)a[(int)(j)]))) {
            _i1 = i;
            _i2 = j;
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
        }
    }

    static void odd_even_merge_sort_impl(int[] a, long n) {
        long p = 0;
        long k = 0;
        long j = 0;
        long lim = 0;
        long i = 0;
        long _e1 = 0;
        p = 1L;
        while ((p < n)) {
            k = p;
            while ((k >= 1L)) {
                j = (k % p);
                while ((j < (n - k))) {
                    lim = Math.min(k, ((n - j) - k));
                    i = 0L;
                    _e1 = lim;
                    while ((i < _e1)) {
                        if ((((i + j) / (2L * p)) == (((i + j) + k) / (2L * p)))) {
                            odd_even_merge_sort_x_cmp_swap(a, (i + j), ((i + j) + k));
                        }
                        i = (i + 1);
                    }
                    j = (j + (2L * k));
                }
                k = (k / 2L);
            }
            p = (p * 2L);
        }
    }

    public static void sort(int[] a) {
        odd_even_merge_sort_impl(a, a.length);
    }
}
