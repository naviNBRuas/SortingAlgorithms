// GENERATED from kernels/algos/smooth_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class SmoothSort {
    private SmoothSort() {}

    static long smooth_sort_x_tz(long x) {
        long c = 0;
        c = 0L;
        while (((x % 2L) == 0L)) {
            x = (x / 2L);
            c = (c + 1L);
        }
        return c;
    }

    static long smooth_sort_x_pow2(long k) {
        long r = 0;
        long i = 0;
        long _e1 = 0;
        r = 1L;
        i = 0L;
        _e1 = k;
        while ((i < _e1)) {
            r = (r * 2L);
            i = (i + 1);
        }
        return r;
    }

    static void smooth_sort_x_sift(int[] a, int[] lp, long head, long pshift) {
        long val = 0;
        long going = 0;
        long rt = 0;
        long lf = 0;
        val = ((long)a[(int)(head)]);
        going = 1L;
        while (((pshift > 1L) && (going == 1L))) {
            rt = (head - 1L);
            lf = ((head - 1L) - ((long)lp[(int)((pshift - 2L))]));
            if (((val >= ((long)a[(int)(lf)])) && (val >= ((long)a[(int)(rt)])))) {
                going = 0L;
            } else {
                if ((((long)a[(int)(lf)]) >= ((long)a[(int)(rt)]))) {
                    a[(int)(head)] = (int)(((long)a[(int)(lf)]));
                    head = lf;
                    pshift = (pshift - 1L);
                } else {
                    a[(int)(head)] = (int)(((long)a[(int)(rt)]));
                    head = rt;
                    pshift = (pshift - 2L);
                }
            }
        }
        a[(int)(head)] = (int)(val);
    }

    static void smooth_sort_x_trinkle(int[] a, int[] lp, long head, long p, long pshift, long trusty) {
        long val = 0;
        long going = 0;
        long stepson = 0;
        long stop = 0;
        long rt = 0;
        long lf = 0;
        long trail = 0;
        val = ((long)a[(int)(head)]);
        going = 1L;
        while (((p != 1L) && (going == 1L))) {
            stepson = (head - ((long)lp[(int)(pshift)]));
            if ((((long)a[(int)(stepson)]) <= val)) {
                going = 0L;
            } else {
                stop = 0L;
                if (((trusty == 0L) && (pshift > 1L))) {
                    rt = (head - 1L);
                    lf = ((head - 1L) - ((long)lp[(int)((pshift - 2L))]));
                    if (((((long)a[(int)(rt)]) >= ((long)a[(int)(stepson)])) || (((long)a[(int)(lf)]) >= ((long)a[(int)(stepson)])))) {
                        stop = 1L;
                    }
                }
                if ((stop == 1L)) {
                    going = 0L;
                } else {
                    a[(int)(head)] = (int)(((long)a[(int)(stepson)]));
                    head = stepson;
                    trail = smooth_sort_x_tz((p - (p % 2L)));
                    p = (p / smooth_sort_x_pow2(trail));
                    pshift = (pshift + trail);
                    trusty = 0L;
                }
            }
        }
        if ((trusty == 0L)) {
            a[(int)(head)] = (int)(val);
            smooth_sort_x_sift(a, lp, head, pshift);
        }
    }

    static void smooth_sort_impl(int[] a, long n) {
        long i = 0;
        long hi = 0;
        long head = 0;
        long p = 0;
        long pshift = 0;
        long trail = 0;
        long _e1 = 0;
        int[] lp = null;
        if ((n < 2L)) {
            return;
        }
        lp = new int[(int)Math.max(1L, 64L)];
        lp[(int)(0L)] = (int)(1L);
        lp[(int)(1L)] = (int)(1L);
        i = 2L;
        _e1 = 64L;
        while ((i < _e1)) {
            lp[(int)(i)] = (int)(((((long)lp[(int)((i - 1L))]) + ((long)lp[(int)((i - 2L))])) + 1L));
            i = (i + 1);
        }
        hi = (n - 1L);
        head = 0L;
        p = 1L;
        pshift = 1L;
        while ((head < hi)) {
            if (((p % 4L) == 3L)) {
                smooth_sort_x_sift(a, lp, head, pshift);
                p = (p / 4L);
                pshift = (pshift + 2L);
            } else {
                if ((((long)lp[(int)((pshift - 1L))]) >= (hi - head))) {
                    smooth_sort_x_trinkle(a, lp, head, p, pshift, 0L);
                } else {
                    smooth_sort_x_sift(a, lp, head, pshift);
                }
                if ((pshift == 1L)) {
                    p = (p * 2L);
                    pshift = 0L;
                } else {
                    p = (p * smooth_sort_x_pow2((pshift - 1L)));
                    pshift = 1L;
                }
            }
            p = ((p + 1L) - (p % 2L));
            head = (head + 1L);
        }
        smooth_sort_x_trinkle(a, lp, head, p, pshift, 0L);
        while (((pshift != 1L) || (p != 1L))) {
            if ((pshift <= 1L)) {
                trail = smooth_sort_x_tz((p - (p % 2L)));
                p = (p / smooth_sort_x_pow2(trail));
                pshift = (pshift + trail);
            } else {
                p = (p * 4L);
                if ((((p / 4L) % 2L) == 0L)) {
                    p = (p + 7L);
                } else {
                    p = (p - 1L);
                }
                pshift = (pshift - 2L);
                smooth_sort_x_trinkle(a, lp, ((head - ((long)lp[(int)(pshift)])) - 1L), (p / 2L), (pshift + 1L), 1L);
                smooth_sort_x_trinkle(a, lp, (head - 1L), p, pshift, 1L);
            }
            head = (head - 1L);
        }
    }

    public static void sort(int[] a) {
        smooth_sort_impl(a, a.length);
    }
}
