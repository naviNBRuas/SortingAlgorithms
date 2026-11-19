// GENERATED from kernels/algos/counting_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class CountingSort {
    private CountingSort() {}

    static void counting_sort_x_fallback(int[] a, long n) {
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

    static void counting_sort_impl(int[] a, long n) {
        long mn = 0;
        long mx = 0;
        long i = 0;
        long rng = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        long _e4 = 0;
        long _e5 = 0;
        int[] count = null;
        int[] out = null;
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
            counting_sort_x_fallback(a, n);
            return;
        }
        count = new int[(int)Math.max(1L, (rng + 1L))];
        out = new int[(int)Math.max(1L, n)];
        i = 0L;
        _e2 = n;
        while ((i < _e2)) {
            count[(int)(((((long)a[(int)(i)]) - mn) + 1L))] = (int)((((long)count[(int)(((((long)a[(int)(i)]) - mn) + 1L))]) + 1L));
            i = (i + 1);
        }
        i = 1L;
        _e3 = (rng + 1L);
        while ((i < _e3)) {
            count[(int)(i)] = (int)((((long)count[(int)(i)]) + ((long)count[(int)((i - 1L))])));
            i = (i + 1);
        }
        i = 0L;
        _e4 = n;
        while ((i < _e4)) {
            out[(int)(((long)count[(int)((((long)a[(int)(i)]) - mn))]))] = (int)(((long)a[(int)(i)]));
            count[(int)((((long)a[(int)(i)]) - mn))] = (int)((((long)count[(int)((((long)a[(int)(i)]) - mn))]) + 1L));
            i = (i + 1);
        }
        i = 0L;
        _e5 = n;
        while ((i < _e5)) {
            a[(int)(i)] = (int)(((long)out[(int)(i)]));
            i = (i + 1);
        }
    }

    public static void sort(int[] a) {
        counting_sort_impl(a, a.length);
    }
}
