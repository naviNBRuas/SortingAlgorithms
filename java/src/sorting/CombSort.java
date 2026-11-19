// GENERATED from kernels/algos/comb_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class CombSort {
    private CombSort() {}

    static void comb_sort_impl(int[] a, long n) {
        long gap = 0;
        long swapped = 0;
        long i = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        gap = n;
        swapped = 1L;
        while (((gap > 1L) || (swapped == 1L))) {
            gap = ((gap * 10L) / 13L);
            if ((gap < 1L)) {
                gap = 1L;
            }
            swapped = 0L;
            i = 0L;
            while (((i + gap) < n)) {
                if ((((long)a[(int)(i)]) > ((long)a[(int)((i + gap))]))) {
                    _i1 = i;
                    _i2 = (i + gap);
                    _t1 = ((long)a[(int)(_i1)]);
                    a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                    a[(int)(_i2)] = (int)(_t1);
                    swapped = 1L;
                }
                i = (i + 1L);
            }
        }
    }

    public static void sort(int[] a) {
        comb_sort_impl(a, a.length);
    }
}
