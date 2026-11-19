// GENERATED from kernels/algos/double_selection_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class DoubleSelectionSort {
    private DoubleSelectionSort() {}

    static void double_selection_sort_impl(int[] a, long n) {
        long lo = 0;
        long hi = 0;
        long mn = 0;
        long mx = 0;
        long j = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        lo = 0L;
        hi = (n - 1L);
        while ((lo < hi)) {
            mn = lo;
            mx = lo;
            j = (lo + 1L);
            while ((j <= hi)) {
                if ((((long)a[(int)(j)]) < ((long)a[(int)(mn)]))) {
                    mn = j;
                } else {
                    if ((((long)a[(int)(j)]) > ((long)a[(int)(mx)]))) {
                        mx = j;
                    }
                }
                j = (j + 1L);
            }
            _i1 = lo;
            _i2 = mn;
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
            if ((mx == lo)) {
                mx = mn;
            }
            _i1 = hi;
            _i2 = mx;
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
            lo = (lo + 1L);
            hi = (hi - 1L);
        }
    }

    public static void sort(int[] a) {
        double_selection_sort_impl(a, a.length);
    }
}
