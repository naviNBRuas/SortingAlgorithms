// GENERATED from kernels/algos/stooge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class StoogeSort {
    private StoogeSort() {}

    static void stooge_sort_x_st(int[] a, long i, long j) {
        long t = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        if ((((long)a[(int)(i)]) > ((long)a[(int)(j)]))) {
            _i1 = i;
            _i2 = j;
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
        }
        if ((((j - i) + 1L) > 2L)) {
            t = (((j - i) + 1L) / 3L);
            stooge_sort_x_st(a, i, (j - t));
            stooge_sort_x_st(a, (i + t), j);
            stooge_sort_x_st(a, i, (j - t));
        }
    }

    static void stooge_sort_impl(int[] a, long n) {
        if ((n > 1L)) {
            stooge_sort_x_st(a, 0L, (n - 1L));
        }
    }

    public static void sort(int[] a) {
        stooge_sort_impl(a, a.length);
    }
}
