// GENERATED from kernels/algos/quick_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class QuickSort {
    private QuickSort() {}

    static void quick_sort_x_qs(int[] a, long lo, long hi) {
        long pivot = 0;
        long i = 0;
        long j = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        while ((lo < hi)) {
            pivot = ((long)a[(int)(hi)]);
            i = lo;
            j = lo;
            while ((j < hi)) {
                if ((((long)a[(int)(j)]) <= pivot)) {
                    _i1 = i;
                    _i2 = j;
                    _t1 = ((long)a[(int)(_i1)]);
                    a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                    a[(int)(_i2)] = (int)(_t1);
                    i = (i + 1L);
                }
                j = (j + 1L);
            }
            _i1 = i;
            _i2 = hi;
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
            if (((i - lo) < (hi - i))) {
                quick_sort_x_qs(a, lo, (i - 1L));
                lo = (i + 1L);
            } else {
                quick_sort_x_qs(a, (i + 1L), hi);
                hi = (i - 1L);
            }
        }
    }

    static void quick_sort_impl(int[] a, long n) {
        quick_sort_x_qs(a, 0L, (n - 1L));
    }

    public static void sort(int[] a) {
        quick_sort_impl(a, a.length);
    }
}
