// GENERATED from kernels/algos/circle_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class CircleSort {
    private CircleSort() {}

    static long circle_sort_x_circle_pass(int[] a, long lo, long hi) {
        long m = 0;
        long swaps = 0;
        long half = 0;
        long i = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        m = (hi - lo);
        if ((m < 2L)) {
            return 0L;
        }
        swaps = 0L;
        half = (m / 2L);
        i = 0L;
        while ((i < half)) {
            if ((((long)a[(int)(((hi - 1L) - i))]) < ((long)a[(int)((lo + i))]))) {
                _i1 = ((hi - 1L) - i);
                _i2 = (lo + i);
                _t1 = ((long)a[(int)(_i1)]);
                a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                a[(int)(_i2)] = (int)(_t1);
                swaps = (swaps + 1L);
            }
            i = (i + 1L);
        }
        if (((m % 2L) == 1L)) {
            if ((((long)a[(int)((lo + half))]) < ((long)a[(int)(((lo + half) - 1L))]))) {
                _i1 = ((lo + half) - 1L);
                _i2 = (lo + half);
                _t1 = ((long)a[(int)(_i1)]);
                a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                a[(int)(_i2)] = (int)(_t1);
                swaps = (swaps + 1L);
            }
        }
        swaps = (swaps + circle_sort_x_circle_pass(a, lo, (lo + half)));
        swaps = (swaps + circle_sort_x_circle_pass(a, (lo + half), hi));
        return swaps;
    }

    static void circle_sort_impl(int[] a, long n) {
        long s = 0;
        s = 1L;
        while ((s > 0L)) {
            s = circle_sort_x_circle_pass(a, 0L, n);
        }
    }

    public static void sort(int[] a) {
        circle_sort_impl(a, a.length);
    }
}
