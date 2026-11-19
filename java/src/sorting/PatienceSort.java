// GENERATED from kernels/algos/patience_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class PatienceSort {
    private PatienceSort() {}

    static void patience_sort_impl(int[] a, long n) {
        long i = 0;
        long piles = 0;
        long lo = 0;
        long hi = 0;
        long mid = 0;
        long out = 0;
        long best = 0;
        long p = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        long _e4 = 0;
        int[] vals = null;
        int[] prev = null;
        int[] top = null;
        if ((n < 2L)) {
            return;
        }
        vals = new int[(int)Math.max(1L, n)];
        prev = new int[(int)Math.max(1L, n)];
        top = new int[(int)Math.max(1L, n)];
        i = 0L;
        _e1 = n;
        while ((i < _e1)) {
            vals[(int)(i)] = (int)(((long)a[(int)(i)]));
            i = (i + 1);
        }
        piles = 0L;
        i = 0L;
        _e2 = n;
        while ((i < _e2)) {
            lo = 0L;
            hi = piles;
            while ((lo < hi)) {
                mid = ((lo + hi) / 2L);
                if ((((long)vals[(int)((((long)top[(int)(mid)]) - 1L))]) < ((long)vals[(int)(i)]))) {
                    lo = (mid + 1L);
                } else {
                    hi = mid;
                }
            }
            prev[(int)(i)] = (int)(((long)top[(int)(lo)]));
            top[(int)(lo)] = (int)((i + 1L));
            if ((lo == piles)) {
                piles = (piles + 1L);
            }
            i = (i + 1);
        }
        out = 0L;
        _e3 = n;
        while ((out < _e3)) {
            best = (-1L);
            p = 0L;
            _e4 = piles;
            while ((p < _e4)) {
                if ((((long)top[(int)(p)]) != 0L)) {
                    if (((best < 0L) || (((long)vals[(int)((((long)top[(int)(p)]) - 1L))]) < ((long)vals[(int)((((long)top[(int)(best)]) - 1L))])))) {
                        best = p;
                    }
                }
                p = (p + 1);
            }
            a[(int)(out)] = (int)(((long)vals[(int)((((long)top[(int)(best)]) - 1L))]));
            top[(int)(best)] = (int)(((long)prev[(int)((((long)top[(int)(best)]) - 1L))]));
            out = (out + 1);
        }
    }

    public static void sort(int[] a) {
        patience_sort_impl(a, a.length);
    }
}
