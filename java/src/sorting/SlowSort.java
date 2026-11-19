// GENERATED from kernels/algos/slow_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class SlowSort {
    private SlowSort() {}

    static void slow_sort_x_slow(int[] a, long i, long j) {
        long m = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        if ((i >= j)) {
            return;
        }
        m = ((i + j) / 2L);
        slow_sort_x_slow(a, i, m);
        slow_sort_x_slow(a, (m + 1L), j);
        if ((((long)a[(int)(m)]) > ((long)a[(int)(j)]))) {
            _i1 = m;
            _i2 = j;
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
        }
        slow_sort_x_slow(a, i, (j - 1L));
    }

    static void slow_sort_impl(int[] a, long n) {
        slow_sort_x_slow(a, 0L, (n - 1L));
    }

    public static void sort(int[] a) {
        slow_sort_impl(a, a.length);
    }
}
