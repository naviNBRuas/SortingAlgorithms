// GENERATED from kernels/algos/flash_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class FlashSort {
    private FlashSort() {}

    static void flash_sort_impl(int[] a, long n) {
        long mn = 0;
        long mx = 0;
        long i = 0;
        long m = 0;
        long rng = 0;
        long s = 0;
        long c = 0;
        long b = 0;
        long d = 0;
        long key = 0;
        long j = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        long _e4 = 0;
        long _e5 = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        int[] count = null;
        int[] starts = null;
        int[] nxt = null;
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
        if ((mn == mx)) {
            return;
        }
        m = Math.max(2L, ((43L * n) / 100L));
        rng = (mx - mn);
        count = new int[(int)Math.max(1L, m)];
        starts = new int[(int)Math.max(1L, (m + 1L))];
        nxt = new int[(int)Math.max(1L, m)];
        i = 0L;
        _e2 = n;
        while ((i < _e2)) {
            count[(int)((((((long)a[(int)(i)]) - mn) * (m - 1L)) / rng))] = (int)((((long)count[(int)((((((long)a[(int)(i)]) - mn) * (m - 1L)) / rng))]) + 1L));
            i = (i + 1);
        }
        s = 0L;
        c = 0L;
        _e3 = m;
        while ((c < _e3)) {
            starts[(int)(c)] = (int)(s);
            nxt[(int)(c)] = (int)(s);
            s = (s + ((long)count[(int)(c)]));
            c = (c + 1);
        }
        starts[(int)(m)] = (int)(s);
        b = 0L;
        _e4 = m;
        while ((b < _e4)) {
            while ((((long)nxt[(int)(b)]) < ((long)starts[(int)((b + 1L))]))) {
                d = (((((long)a[(int)(((long)nxt[(int)(b)]))]) - mn) * (m - 1L)) / rng);
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
        i = 1L;
        _e5 = n;
        while ((i < _e5)) {
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
        flash_sort_impl(a, a.length);
    }
}
