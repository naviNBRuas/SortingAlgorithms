// GENERATED from kernels/algos/strand_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class StrandSort {
    private StrandSort() {}

    static void strand_sort_impl(int[] a, long n) {
        long i = 0;
        long left = 0;
        long o = 0;
        long s = 0;
        long keep = 0;
        long j = 0;
        long k = 0;
        long x = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        long _e4 = 0;
        int[] rem = null;
        int[] strand = null;
        int[] out = null;
        int[] tmp = null;
        if ((n < 2L)) {
            return;
        }
        rem = new int[(int)Math.max(1L, n)];
        strand = new int[(int)Math.max(1L, n)];
        out = new int[(int)Math.max(1L, n)];
        tmp = new int[(int)Math.max(1L, n)];
        i = 0L;
        _e1 = n;
        while ((i < _e1)) {
            rem[(int)(i)] = (int)(((long)a[(int)(i)]));
            i = (i + 1);
        }
        left = n;
        o = 0L;
        while ((left > 0L)) {
            strand[(int)(0L)] = (int)(((long)rem[(int)(0L)]));
            s = 1L;
            keep = 0L;
            i = 1L;
            _e2 = left;
            while ((i < _e2)) {
                if ((((long)rem[(int)(i)]) >= ((long)strand[(int)((s - 1L))]))) {
                    strand[(int)(s)] = (int)(((long)rem[(int)(i)]));
                    s = (s + 1L);
                } else {
                    rem[(int)(keep)] = (int)(((long)rem[(int)(i)]));
                    keep = (keep + 1L);
                }
                i = (i + 1);
            }
            left = keep;
            i = 0L;
            j = 0L;
            k = 0L;
            while (((i < o) && (j < s))) {
                if ((((long)strand[(int)(j)]) < ((long)out[(int)(i)]))) {
                    tmp[(int)(k)] = (int)(((long)strand[(int)(j)]));
                    j = (j + 1L);
                } else {
                    tmp[(int)(k)] = (int)(((long)out[(int)(i)]));
                    i = (i + 1L);
                }
                k = (k + 1L);
            }
            while ((i < o)) {
                tmp[(int)(k)] = (int)(((long)out[(int)(i)]));
                i = (i + 1L);
                k = (k + 1L);
            }
            while ((j < s)) {
                tmp[(int)(k)] = (int)(((long)strand[(int)(j)]));
                j = (j + 1L);
                k = (k + 1L);
            }
            o = k;
            x = 0L;
            _e3 = o;
            while ((x < _e3)) {
                out[(int)(x)] = (int)(((long)tmp[(int)(x)]));
                x = (x + 1);
            }
        }
        i = 0L;
        _e4 = n;
        while ((i < _e4)) {
            a[(int)(i)] = (int)(((long)out[(int)(i)]));
            i = (i + 1);
        }
    }

    public static void sort(int[] a) {
        strand_sort_impl(a, a.length);
    }
}
