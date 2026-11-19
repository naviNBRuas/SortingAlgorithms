// GENERATED from kernels/algos/american_flag_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class AmericanFlagSort {
    private AmericanFlagSort() {}

    static void american_flag_sort_x_rec(int[] a, long mn, long lo, long hi, long exp) {
        long i = 0;
        long s = 0;
        long d = 0;
        long b = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        long _e4 = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        int[] count = null;
        int[] starts = null;
        int[] nxt = null;
        if ((((hi - lo) < 2L) || (exp == 0L))) {
            return;
        }
        count = new int[(int)Math.max(1L, 10L)];
        starts = new int[(int)Math.max(1L, 11L)];
        nxt = new int[(int)Math.max(1L, 10L)];
        i = lo;
        _e1 = hi;
        while ((i < _e1)) {
            count[(int)((((((long)a[(int)(i)]) - mn) / exp) % 10L))] = (int)((((long)count[(int)((((((long)a[(int)(i)]) - mn) / exp) % 10L))]) + 1L));
            i = (i + 1);
        }
        s = lo;
        d = 0L;
        _e2 = 10L;
        while ((d < _e2)) {
            starts[(int)(d)] = (int)(s);
            nxt[(int)(d)] = (int)(s);
            s = (s + ((long)count[(int)(d)]));
            d = (d + 1);
        }
        starts[(int)(10L)] = (int)(s);
        b = 0L;
        _e3 = 10L;
        while ((b < _e3)) {
            while ((((long)nxt[(int)(b)]) < ((long)starts[(int)((b + 1L))]))) {
                d = (((((long)a[(int)(((long)nxt[(int)(b)]))]) - mn) / exp) % 10L);
                if ((d == b)) {
                    nxt[(int)(b)] = (int)((((long)nxt[(int)(b)]) + 1L));
                } else {
                    _i1 = ((long)nxt[(int)(b)]);
                    _i2 = ((long)nxt[(int)(d)]);
                    _t1 = ((long)a[(int)(_i1)]);
                    a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                    a[(int)(_i2)] = (int)(_t1);
                    nxt[(int)(d)] = (int)((((long)nxt[(int)(d)]) + 1L));
                }
            }
            b = (b + 1);
        }
        b = 0L;
        _e4 = 10L;
        while ((b < _e4)) {
            american_flag_sort_x_rec(a, mn, ((long)starts[(int)(b)]), ((long)starts[(int)((b + 1L))]), (exp / 10L));
            b = (b + 1);
        }
    }

    static void american_flag_sort_impl(int[] a, long n) {
        long mn = 0;
        long mx = 0;
        long i = 0;
        long top = 0;
        long _e1 = 0;
        if ((n < 2L)) {
            return;
        }
        mn = ((long)a[(int)(0L)]);
        mx = ((long)a[(int)(0L)]);
        i = 1L;
        _e1 = n;
        while ((i < _e1)) {
            if ((((long)a[(int)(i)]) < mn)) {
                mn = ((long)a[(int)(i)]);
            }
            if ((((long)a[(int)(i)]) > mx)) {
                mx = ((long)a[(int)(i)]);
            }
            i = (i + 1);
        }
        top = 1L;
        while ((((mx - mn) / top) >= 10L)) {
            top = (top * 10L);
        }
        american_flag_sort_x_rec(a, mn, 0L, n, top);
    }

    public static void sort(int[] a) {
        american_flag_sort_impl(a, a.length);
    }
}
