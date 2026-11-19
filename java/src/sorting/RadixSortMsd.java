// GENERATED from kernels/algos/radix_sort_msd.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class RadixSortMsd {
    private RadixSortMsd() {}

    static void radix_sort_msd_x_rec(int[] a, int[] tmp, long mn, long lo, long hi, long exp) {
        long i = 0;
        long d = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        long _e4 = 0;
        long _e5 = 0;
        long _e6 = 0;
        int[] count = null;
        int[] start = null;
        if ((((hi - lo) < 2L) || (exp == 0L))) {
            return;
        }
        count = new int[(int)Math.max(1L, 11L)];
        i = lo;
        _e1 = hi;
        while ((i < _e1)) {
            count[(int)(((((((long)a[(int)(i)]) - mn) / exp) % 10L) + 1L))] = (int)((((long)count[(int)(((((((long)a[(int)(i)]) - mn) / exp) % 10L) + 1L))]) + 1L));
            i = (i + 1);
        }
        d = 1L;
        _e2 = 11L;
        while ((d < _e2)) {
            count[(int)(d)] = (int)((((long)count[(int)(d)]) + ((long)count[(int)((d - 1L))])));
            d = (d + 1);
        }
        start = new int[(int)Math.max(1L, 11L)];
        d = 0L;
        _e3 = 11L;
        while ((d < _e3)) {
            start[(int)(d)] = (int)(((long)count[(int)(d)]));
            d = (d + 1);
        }
        i = lo;
        _e4 = hi;
        while ((i < _e4)) {
            d = (((((long)a[(int)(i)]) - mn) / exp) % 10L);
            tmp[(int)((lo + ((long)count[(int)(d)])))] = (int)(((long)a[(int)(i)]));
            count[(int)(d)] = (int)((((long)count[(int)(d)]) + 1L));
            i = (i + 1);
        }
        i = lo;
        _e5 = hi;
        while ((i < _e5)) {
            a[(int)(i)] = (int)(((long)tmp[(int)(i)]));
            i = (i + 1);
        }
        d = 0L;
        _e6 = 10L;
        while ((d < _e6)) {
            radix_sort_msd_x_rec(a, tmp, mn, (lo + ((long)start[(int)(d)])), (lo + ((long)start[(int)((d + 1L))])), (exp / 10L));
            d = (d + 1);
        }
    }

    static void radix_sort_msd_impl(int[] a, long n) {
        long mn = 0;
        long mx = 0;
        long i = 0;
        long top = 0;
        long _e1 = 0;
        int[] tmp = null;
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
        tmp = new int[(int)Math.max(1L, n)];
        top = 1L;
        while ((((mx - mn) / top) >= 10L)) {
            top = (top * 10L);
        }
        radix_sort_msd_x_rec(a, tmp, mn, 0L, n, top);
    }

    public static void sort(int[] a) {
        radix_sort_msd_impl(a, a.length);
    }
}
