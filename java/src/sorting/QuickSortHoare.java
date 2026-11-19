// GENERATED from kernels/algos/quick_sort_hoare.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class QuickSortHoare {
    private QuickSortHoare() {}

    static void quick_sort_hoare_x_qs(int[] a, long lo, long hi) {
        long pivot = 0;
        long i = 0;
        long j = 0;
        long going = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        while ((lo < hi)) {
            pivot = ((long)a[(int)(((lo + hi) / 2L))]);
            i = (lo - 1L);
            j = (hi + 1L);
            going = 1L;
            while ((going == 1L)) {
                i = (i + 1L);
                while ((((long)a[(int)(i)]) < pivot)) {
                    i = (i + 1L);
                }
                j = (j - 1L);
                while ((((long)a[(int)(j)]) > pivot)) {
                    j = (j - 1L);
                }
                if ((i >= j)) {
                    going = 0L;
                } else {
                    _i1 = i;
                    _i2 = j;
                    _t1 = ((long)a[(int)(_i1)]);
                    a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                    a[(int)(_i2)] = (int)(_t1);
                }
            }
            if (((j - lo) < ((hi - j) - 1L))) {
                quick_sort_hoare_x_qs(a, lo, j);
                lo = (j + 1L);
            } else {
                quick_sort_hoare_x_qs(a, (j + 1L), hi);
                hi = j;
            }
        }
    }

    static void quick_sort_hoare_impl(int[] a, long n) {
        quick_sort_hoare_x_qs(a, 0L, (n - 1L));
    }

    public static void sort(int[] a) {
        quick_sort_hoare_impl(a, a.length);
    }
}
