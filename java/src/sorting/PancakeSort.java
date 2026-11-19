// GENERATED from kernels/algos/pancake_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class PancakeSort {
    private PancakeSort() {}

    static void pancake_sort_x_flip(int[] a, long k) {
        long i = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        i = 0L;
        while ((i < k)) {
            _i1 = i;
            _i2 = k;
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
            i = (i + 1L);
            k = (k - 1L);
        }
    }

    static void pancake_sort_impl(int[] a, long n) {
        long size = 0;
        long mx = 0;
        long i = 0;
        size = n;
        while ((size > 1L)) {
            mx = 0L;
            i = 1L;
            while ((i < size)) {
                if ((((long)a[(int)(i)]) > ((long)a[(int)(mx)]))) {
                    mx = i;
                }
                i = (i + 1L);
            }
            if ((mx != (size - 1L))) {
                if ((mx > 0L)) {
                    pancake_sort_x_flip(a, mx);
                }
                pancake_sort_x_flip(a, (size - 1L));
            }
            size = (size - 1L);
        }
    }

    public static void sort(int[] a) {
        pancake_sort_impl(a, a.length);
    }
}
