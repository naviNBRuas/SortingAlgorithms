// GENERATED from kernels/algos/ford_johnson_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class FordJohnsonSort {
    private FordJohnsonSort() {}

    static void ford_johnson_sort_x_fj(int[] key, int[] ids, long m) {
        long h = 0;
        long k = 0;
        long x = 0;
        long y = 0;
        long total = 0;
        long size = 0;
        long prev = 0;
        long kk = 0;
        long t = 0;
        long pw = 0;
        long c = 0;
        long top = 0;
        long i = 0;
        long bound = 0;
        long lo = 0;
        long hi = 0;
        long mid = 0;
        long j = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        long _e4 = 0;
        int[] small = null;
        int[] big = null;
        int[] bk = null;
        int[] order = null;
        int[] chain = null;
        int[] bs = null;
        if ((m < 2L)) {
            return;
        }
        h = (m / 2L);
        small = new int[(int)Math.max(1L, h)];
        big = new int[(int)Math.max(1L, h)];
        k = 0L;
        _e1 = h;
        while ((k < _e1)) {
            x = ((long)ids[(int)((2L * k))]);
            y = ((long)ids[(int)(((2L * k) + 1L))]);
            if ((((long)key[(int)(y)]) < ((long)key[(int)(x)]))) {
                small[(int)(k)] = (int)(y);
                big[(int)(k)] = (int)(x);
            } else {
                small[(int)(k)] = (int)(x);
                big[(int)(k)] = (int)(y);
            }
            k = (k + 1);
        }
        bk = new int[(int)Math.max(1L, h)];
        order = new int[(int)Math.max(1L, h)];
        k = 0L;
        _e2 = h;
        while ((k < _e2)) {
            bk[(int)(k)] = (int)(((long)key[(int)(((long)big[(int)(k)]))]));
            order[(int)(k)] = (int)(k);
            k = (k + 1);
        }
        ford_johnson_sort_x_fj(bk, order, h);
        total = h;
        if (((m % 2L) == 1L)) {
            total = (h + 1L);
        }
        chain = new int[(int)Math.max(1L, m)];
        bs = new int[(int)Math.max(1L, (total + 1L))];
        chain[(int)(0L)] = (int)(((long)small[(int)(((long)order[(int)(0L)]))]));
        k = 0L;
        _e3 = h;
        while ((k < _e3)) {
            chain[(int)((k + 1L))] = (int)(((long)big[(int)(((long)order[(int)(k)]))]));
            bs[(int)((k + 1L))] = (int)(((long)small[(int)(((long)order[(int)(k)]))]));
            k = (k + 1);
        }
        size = (h + 1L);
        if (((m % 2L) == 1L)) {
            bs[(int)((h + 1L))] = (int)(((long)ids[(int)((m - 1L))]));
        }
        prev = 1L;
        kk = 2L;
        while ((prev < total)) {
            t = 1L;
            pw = 1L;
            c = 0L;
            while ((c < (kk + 1L))) {
                pw = (pw * 2L);
                c = (c + 1L);
            }
            if (((kk % 2L) == 0L)) {
                t = ((pw + 1L) / 3L);
            } else {
                t = ((pw - 1L) / 3L);
            }
            top = Math.min(t, total);
            i = top;
            while ((i > prev)) {
                bound = size;
                if ((i <= h)) {
                    bound = 0L;
                    while ((((long)chain[(int)(bound)]) != ((long)big[(int)(((long)order[(int)((i - 1L))]))]))) {
                        bound = (bound + 1L);
                    }
                }
                lo = 0L;
                hi = bound;
                while ((lo < hi)) {
                    mid = ((lo + hi) / 2L);
                    if ((((long)key[(int)(((long)bs[(int)(i)]))]) < ((long)key[(int)(((long)chain[(int)(mid)]))]))) {
                        hi = mid;
                    } else {
                        lo = (mid + 1L);
                    }
                }
                j = size;
                while ((j > lo)) {
                    chain[(int)(j)] = (int)(((long)chain[(int)((j - 1L))]));
                    j = (j - 1L);
                }
                chain[(int)(lo)] = (int)(((long)bs[(int)(i)]));
                size = (size + 1L);
                i = (i - 1L);
            }
            prev = top;
            kk = (kk + 1L);
        }
        k = 0L;
        _e4 = m;
        while ((k < _e4)) {
            ids[(int)(k)] = (int)(((long)chain[(int)(k)]));
            k = (k + 1);
        }
    }

    static void ford_johnson_sort_impl(int[] a, long n) {
        long i = 0;
        long _e1 = 0;
        long _e2 = 0;
        int[] key = null;
        int[] ids = null;
        if ((n < 2L)) {
            return;
        }
        key = new int[(int)Math.max(1L, n)];
        ids = new int[(int)Math.max(1L, n)];
        i = 0L;
        _e1 = n;
        while ((i < _e1)) {
            key[(int)(i)] = (int)(((long)a[(int)(i)]));
            ids[(int)(i)] = (int)(i);
            i = (i + 1);
        }
        ford_johnson_sort_x_fj(key, ids, n);
        i = 0L;
        _e2 = n;
        while ((i < _e2)) {
            a[(int)(i)] = (int)(((long)key[(int)(((long)ids[(int)(i)]))]));
            i = (i + 1);
        }
    }

    public static void sort(int[] a) {
        ford_johnson_sort_impl(a, a.length);
    }
}
