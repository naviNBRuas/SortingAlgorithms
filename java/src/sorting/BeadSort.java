// GENERATED from kernels/algos/bead_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class BeadSort {
    private BeadSort() {}

    static void bead_sort_x_fallback(int[] a, long n) {
        long gap = 0;
        long i = 0;
        long key = 0;
        long j = 0;
        long _e1 = 0;
        gap = (n / 2L);
        while ((gap > 0L)) {
            i = gap;
            _e1 = n;
            while ((i < _e1)) {
                key = ((long)a[(int)(i)]);
                j = i;
                while (((j >= gap) && (((long)a[(int)((j - gap))]) > key))) {
                    a[(int)(j)] = (int)(((long)a[(int)((j - gap))]));
                    j = (j - gap);
                }
                a[(int)(j)] = (int)(key);
                i = (i + 1);
            }
            gap = (gap / 2L);
        }
    }

    static void bead_sort_impl(int[] a, long n) {
        long mn = 0;
        long mx = 0;
        long i = 0;
        long maxv = 0;
        long r = 0;
        long level = 0;
        long k = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        long _e4 = 0;
        long _e5 = 0;
        int[] ge = null;
        int[] rods = null;
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
        maxv = (mx - mn);
        if ((maxv > 20000L)) {
            bead_sort_x_fallback(a, n);
            return;
        }
        ge = new int[(int)Math.max(1L, (maxv + 2L))];
        rods = new int[(int)Math.max(1L, n)];
        i = 0L;
        _e2 = n;
        while ((i < _e2)) {
            ge[(int)((((long)a[(int)(i)]) - mn))] = (int)((((long)ge[(int)((((long)a[(int)(i)]) - mn))]) + 1L));
            i = (i + 1);
        }
        r = maxv;
        while ((r > 0L)) {
            r = (r - 1L);
            ge[(int)(r)] = (int)((((long)ge[(int)(r)]) + ((long)ge[(int)((r + 1L))])));
        }
        level = 1L;
        _e3 = (maxv + 1L);
        while ((level < _e3)) {
            k = 0L;
            _e4 = ((long)ge[(int)(level)]);
            while ((k < _e4)) {
                rods[(int)(((n - 1L) - k))] = (int)((((long)rods[(int)(((n - 1L) - k))]) + 1L));
                k = (k + 1);
            }
            level = (level + 1);
        }
        i = 0L;
        _e5 = n;
        while ((i < _e5)) {
            a[(int)(i)] = (int)((((long)rods[(int)(i)]) + mn));
            i = (i + 1);
        }
    }

    public static void sort(int[] a) {
        bead_sort_impl(a, a.length);
    }
}
