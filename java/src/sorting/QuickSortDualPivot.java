// GENERATED from kernels/algos/quick_sort_dual_pivot.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class QuickSortDualPivot {
    private QuickSortDualPivot() {}

    static void quick_sort_dual_pivot_x_qs(int[] a, long lo, long hi) {
        long p = 0;
        long q = 0;
        long lt = 0;
        long gt = 0;
        long k = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        while ((lo < hi)) {
            if ((((long)a[(int)(lo)]) > ((long)a[(int)(hi)]))) {
                _i1 = lo;
                _i2 = hi;
                _t1 = ((long)a[(int)(_i1)]);
                a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                a[(int)(_i2)] = (int)(_t1);
            }
            p = ((long)a[(int)(lo)]);
            q = ((long)a[(int)(hi)]);
            lt = (lo + 1L);
            gt = (hi - 1L);
            k = (lo + 1L);
            while ((k <= gt)) {
                if ((((long)a[(int)(k)]) < p)) {
                    _i1 = k;
                    _i2 = lt;
                    _t1 = ((long)a[(int)(_i1)]);
                    a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                    a[(int)(_i2)] = (int)(_t1);
                    lt = (lt + 1L);
                } else {
                    if ((((long)a[(int)(k)]) > q)) {
                        while (((k < gt) && (((long)a[(int)(gt)]) > q))) {
                            gt = (gt - 1L);
                        }
                        _i1 = k;
                        _i2 = gt;
                        _t1 = ((long)a[(int)(_i1)]);
                        a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                        a[(int)(_i2)] = (int)(_t1);
                        gt = (gt - 1L);
                        if ((((long)a[(int)(k)]) < p)) {
                            _i1 = k;
                            _i2 = lt;
                            _t1 = ((long)a[(int)(_i1)]);
                            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                            a[(int)(_i2)] = (int)(_t1);
                            lt = (lt + 1L);
                        }
                    }
                }
                k = (k + 1L);
            }
            lt = (lt - 1L);
            gt = (gt + 1L);
            _i1 = lo;
            _i2 = lt;
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
            _i1 = hi;
            _i2 = gt;
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
            quick_sort_dual_pivot_x_qs(a, lo, (lt - 1L));
            quick_sort_dual_pivot_x_qs(a, (gt + 1L), hi);
            lo = (lt + 1L);
            hi = (gt - 1L);
        }
    }

    static void quick_sort_dual_pivot_impl(int[] a, long n) {
        quick_sort_dual_pivot_x_qs(a, 0L, (n - 1L));
    }

    public static void sort(int[] a) {
        quick_sort_dual_pivot_impl(a, a.length);
    }
}
