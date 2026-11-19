// GENERATED from kernels/algos/bozo_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class BozoSort {
    private BozoSort() {}

    static long bozo_sort_x_is_sorted(int[] a, long n) {
        long i = 0;
        i = 0L;
        while (((i + 1L) < n)) {
            if ((((long)a[(int)(i)]) > ((long)a[(int)((i + 1L))]))) {
                return 0L;
            }
            i = (i + 1L);
        }
        return 1L;
    }

    static void bozo_sort_impl(int[] a, long n, long max_swaps) {
        long state = 0;
        long count = 0;
        long i = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        state = 987654321L;
        count = 0L;
        while (((bozo_sort_x_is_sorted(a, n) == 0L) && (count < max_swaps))) {
            state = (((state * 1103515245L) + 12345L) % 2147483648L);
            i = ((state / 16L) % n);
            state = (((state * 1103515245L) + 12345L) % 2147483648L);
            _i1 = i;
            _i2 = ((state / 16L) % n);
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
            count = (count + 1L);
        }
    }

    public static void sort(int[] a, long max_swaps) {
        bozo_sort_impl(a, a.length, max_swaps);
    }
}
