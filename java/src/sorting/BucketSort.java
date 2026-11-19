// GENERATED from kernels/algos/bucket_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class BucketSort {
    private BucketSort() {}

    static void bucket_sort_impl(int[] a, long n) {
        long mn = 0;
        long mx = 0;
        long i = 0;
        long rng = 0;
        long b = 0;
        long lo = 0;
        long hi = 0;
        long key = 0;
        long j = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        long _e4 = 0;
        long _e5 = 0;
        long _e6 = 0;
        long _e7 = 0;
        long _e8 = 0;
        int[] count = null;
        int[] out = null;
        int[] start = null;
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
        rng = (mx - mn);
        if ((rng == 0L)) {
            return;
        }
        count = new int[(int)Math.max(1L, (n + 1L))];
        out = new int[(int)Math.max(1L, n)];
        i = 0L;
        _e2 = n;
        while ((i < _e2)) {
            count[(int)(((((((long)a[(int)(i)]) - mn) * (n - 1L)) / rng) + 1L))] = (int)((((long)count[(int)(((((((long)a[(int)(i)]) - mn) * (n - 1L)) / rng) + 1L))]) + 1L));
            i = (i + 1);
        }
        b = 1L;
        _e3 = (n + 1L);
        while ((b < _e3)) {
            count[(int)(b)] = (int)((((long)count[(int)(b)]) + ((long)count[(int)((b - 1L))])));
            b = (b + 1);
        }
        start = new int[(int)Math.max(1L, (n + 1L))];
        b = 0L;
        _e4 = (n + 1L);
        while ((b < _e4)) {
            start[(int)(b)] = (int)(((long)count[(int)(b)]));
            b = (b + 1);
        }
        i = 0L;
        _e5 = n;
        while ((i < _e5)) {
            b = (((((long)a[(int)(i)]) - mn) * (n - 1L)) / rng);
            out[(int)(((long)count[(int)(b)]))] = (int)(((long)a[(int)(i)]));
            count[(int)(b)] = (int)((((long)count[(int)(b)]) + 1L));
            i = (i + 1);
        }
        b = 0L;
        _e6 = n;
        while ((b < _e6)) {
            lo = ((long)start[(int)(b)]);
            hi = ((long)start[(int)((b + 1L))]);
            i = (lo + 1L);
            _e7 = hi;
            while ((i < _e7)) {
                key = ((long)out[(int)(i)]);
                j = (i - 1L);
                while (((j >= lo) && (((long)out[(int)(j)]) > key))) {
                    out[(int)((j + 1L))] = (int)(((long)out[(int)(j)]));
                    j = (j - 1L);
                }
                out[(int)((j + 1L))] = (int)(key);
                i = (i + 1);
            }
            b = (b + 1);
        }
        i = 0L;
        _e8 = n;
        while ((i < _e8)) {
            a[(int)(i)] = (int)(((long)out[(int)(i)]));
            i = (i + 1);
        }
    }

    public static void sort(int[] a) {
        bucket_sort_impl(a, a.length);
    }
}
