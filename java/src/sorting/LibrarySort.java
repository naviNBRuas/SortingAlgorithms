// GENERATED from kernels/algos/library_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class LibrarySort {
    private LibrarySort() {}

    static long library_sort_x_locate(int[] vals, int[] s, long size, long x) {
        long lo = 0;
        long hi = 0;
        long mid = 0;
        long m = 0;
        lo = 0L;
        hi = (size - 1L);
        while ((lo <= hi)) {
            mid = ((lo + hi) / 2L);
            m = mid;
            while (((m <= hi) && (((long)s[(int)(m)]) == 0L))) {
                m = (m + 1L);
            }
            if ((m > hi)) {
                hi = (mid - 1L);
            } else {
                if ((x < ((long)vals[(int)((((long)s[(int)(m)]) - 1L))]))) {
                    hi = (mid - 1L);
                } else {
                    lo = (m + 1L);
                }
            }
        }
        return lo;
    }

    static void library_sort_impl(int[] a, long n) {
        long size = 0;
        long i = 0;
        long nextpow = 0;
        long k = 0;
        long cnt = 0;
        long j = 0;
        long lo = 0;
        long p = 0;
        long q = 0;
        long g = 0;
        long out = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        long _e4 = 0;
        long _e5 = 0;
        long _e6 = 0;
        int[] vals = null;
        int[] s = null;
        int[] tmp = null;
        if ((n < 2L)) {
            return;
        }
        size = ((2L * n) + 2L);
        vals = new int[(int)Math.max(1L, n)];
        s = new int[(int)Math.max(1L, size)];
        tmp = new int[(int)Math.max(1L, n)];
        i = 0L;
        _e1 = n;
        while ((i < _e1)) {
            vals[(int)(i)] = (int)(((long)a[(int)(i)]));
            i = (i + 1);
        }
        nextpow = 1L;
        k = 0L;
        _e2 = n;
        while ((k < _e2)) {
            if ((k == nextpow)) {
                nextpow = (nextpow * 2L);
                cnt = 0L;
                i = 0L;
                _e3 = size;
                while ((i < _e3)) {
                    if ((((long)s[(int)(i)]) != 0L)) {
                        tmp[(int)(cnt)] = (int)(((long)s[(int)(i)]));
                        cnt = (cnt + 1L);
                        s[(int)(i)] = (int)(0L);
                    }
                    i = (i + 1);
                }
                j = 0L;
                _e4 = cnt;
                while ((j < _e4)) {
                    s[(int)(((j * size) / cnt))] = (int)(((long)tmp[(int)(j)]));
                    j = (j + 1);
                }
            }
            lo = library_sort_x_locate(vals, s, size, ((long)vals[(int)(k)]));
            p = (lo - 1L);
            while (((p >= 0L) && (((long)s[(int)(p)]) == 0L))) {
                p = (p - 1L);
            }
            q = lo;
            while (((q < size) && (((long)s[(int)(q)]) == 0L))) {
                q = (q + 1L);
            }
            if (((q - p) > 1L)) {
                s[(int)(((p + q) / 2L))] = (int)((k + 1L));
            } else {
                g = q;
                while (((g < size) && (((long)s[(int)(g)]) != 0L))) {
                    g = (g + 1L);
                }
                if ((g < size)) {
                    j = g;
                    while ((j > q)) {
                        s[(int)(j)] = (int)(((long)s[(int)((j - 1L))]));
                        j = (j - 1L);
                    }
                    s[(int)(q)] = (int)((k + 1L));
                } else {
                    g = p;
                    while ((((long)s[(int)(g)]) != 0L)) {
                        g = (g - 1L);
                    }
                    j = g;
                    while ((j < p)) {
                        s[(int)(j)] = (int)(((long)s[(int)((j + 1L))]));
                        j = (j + 1L);
                    }
                    s[(int)(p)] = (int)((k + 1L));
                }
            }
            k = (k + 1);
        }
        out = 0L;
        i = 0L;
        _e5 = size;
        while ((i < _e5)) {
            if ((((long)s[(int)(i)]) != 0L)) {
                tmp[(int)(out)] = (int)(((long)vals[(int)((((long)s[(int)(i)]) - 1L))]));
                out = (out + 1L);
            }
            i = (i + 1);
        }
        i = 0L;
        _e6 = n;
        while ((i < _e6)) {
            a[(int)(i)] = (int)(((long)tmp[(int)(i)]));
            i = (i + 1);
        }
    }

    public static void sort(int[] a) {
        library_sort_impl(a, a.length);
    }
}
