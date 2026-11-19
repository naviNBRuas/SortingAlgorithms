// GENERATED from kernels/algos/quick_sort_3way.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class QuickSort3way {
    private QuickSort3way() {}

    static void quick_sort_3way_x_qs(int[] a, long lo, long hi) {
        long pivot = 0;
        long lt = 0;
        long i = 0;
        long gt = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        while ((lo < hi)) {
            pivot = ((long)a[(int)(((lo + hi) / 2L))]);
            lt = lo;
            i = lo;
            gt = hi;
            while ((i <= gt)) {
                if ((((long)a[(int)(i)]) < pivot)) {
                    _i1 = lt;
                    _i2 = i;
                    _t1 = ((long)a[(int)(_i1)]);
                    a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                    a[(int)(_i2)] = (int)(_t1);
                    lt = (lt + 1L);
                    i = (i + 1L);
                } else {
                    if ((((long)a[(int)(i)]) > pivot)) {
                        _i1 = i;
                        _i2 = gt;
                        _t1 = ((long)a[(int)(_i1)]);
                        a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                        a[(int)(_i2)] = (int)(_t1);
                        gt = (gt - 1L);
                    } else {
                        i = (i + 1L);
                    }
                }
            }
            if (((lt - lo) < (hi - gt))) {
                quick_sort_3way_x_qs(a, lo, (lt - 1L));
                lo = (gt + 1L);
            } else {
                quick_sort_3way_x_qs(a, (gt + 1L), hi);
                hi = (lt - 1L);
            }
        }
    }

    static void quick_sort_3way_impl(int[] a, long n) {
        quick_sort_3way_x_qs(a, 0L, (n - 1L));
    }

    public static void sort(int[] a) {
        quick_sort_3way_impl(a, a.length);
    }
}
