// GENERATED from kernels/algos/pigeonhole_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class PigeonholeSort {
    private PigeonholeSort() {}

    static void pigeonhole_sort_x_fallback(int[] a, long n) {
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

    static void pigeonhole_sort_impl(int[] a, long n) {
        long mn = 0;
        long mx = 0;
        long i = 0;
        long rng = 0;
        long k = 0;
        long h = 0;
        long c = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        int[] holes = null;
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
        rng = ((mx - mn) + 1L);
        if ((rng > 4000000L)) {
            pigeonhole_sort_x_fallback(a, n);
            return;
        }
        holes = new int[(int)Math.max(1L, rng)];
        i = 0L;
        _e2 = n;
        while ((i < _e2)) {
            holes[(int)((((long)a[(int)(i)]) - mn))] = (int)((((long)holes[(int)((((long)a[(int)(i)]) - mn))]) + 1L));
            i = (i + 1);
        }
        k = 0L;
        h = 0L;
        _e3 = rng;
        while ((h < _e3)) {
            c = ((long)holes[(int)(h)]);
            while ((c > 0L)) {
                a[(int)(k)] = (int)((mn + h));
                k = (k + 1L);
                c = (c - 1L);
            }
            h = (h + 1);
        }
    }

    public static void sort(int[] a) {
        pigeonhole_sort_impl(a, a.length);
    }
}
