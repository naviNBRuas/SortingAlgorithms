// GENERATED from kernels/algos/radix_sort_lsd.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class RadixSortLsd {
    private RadixSortLsd() {}

    static void radix_sort_lsd_impl(int[] a, long n) {
        long mn = 0;
        long mx = 0;
        long i = 0;
        long exp = 0;
        long d = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        long _e4 = 0;
        long _e5 = 0;
        long _e6 = 0;
        int[] out = null;
        int[] count = null;
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
        out = new int[(int)Math.max(1L, n)];
        count = new int[(int)Math.max(1L, 11L)];
        exp = 1L;
        while ((((mx - mn) / exp) > 0L)) {
            d = 0L;
            _e2 = 11L;
            while ((d < _e2)) {
                count[(int)(d)] = (int)(0L);
                d = (d + 1);
            }
            i = 0L;
            _e3 = n;
            while ((i < _e3)) {
                count[(int)(((((((long)a[(int)(i)]) - mn) / exp) % 10L) + 1L))] = (int)((((long)count[(int)(((((((long)a[(int)(i)]) - mn) / exp) % 10L) + 1L))]) + 1L));
                i = (i + 1);
            }
            d = 1L;
            _e4 = 11L;
            while ((d < _e4)) {
                count[(int)(d)] = (int)((((long)count[(int)(d)]) + ((long)count[(int)((d - 1L))])));
                d = (d + 1);
            }
            i = 0L;
            _e5 = n;
            while ((i < _e5)) {
                d = (((((long)a[(int)(i)]) - mn) / exp) % 10L);
                out[(int)(((long)count[(int)(d)]))] = (int)(((long)a[(int)(i)]));
                count[(int)(d)] = (int)((((long)count[(int)(d)]) + 1L));
                i = (i + 1);
            }
            i = 0L;
            _e6 = n;
            while ((i < _e6)) {
                a[(int)(i)] = (int)(((long)out[(int)(i)]));
                i = (i + 1);
            }
            exp = (exp * 10L);
        }
    }

    public static void sort(int[] a) {
        radix_sort_lsd_impl(a, a.length);
    }
}
