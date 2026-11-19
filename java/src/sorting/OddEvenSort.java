// GENERATED from kernels/algos/odd_even_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class OddEvenSort {
    private OddEvenSort() {}

    static void odd_even_sort_impl(int[] a, long n) {
        long done = 0;
        long start = 0;
        long i = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        done = 0L;
        while ((done == 0L)) {
            done = 1L;
            start = 1L;
            while ((start >= 0L)) {
                i = start;
                while (((i + 1L) < n)) {
                    if ((((long)a[(int)(i)]) > ((long)a[(int)((i + 1L))]))) {
                        _i1 = i;
                        _i2 = (i + 1L);
                        _t1 = ((long)a[(int)(_i1)]);
                        a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                        a[(int)(_i2)] = (int)(_t1);
                        done = 0L;
                    }
                    i = (i + 2L);
                }
                start = (start - 1L);
            }
        }
    }

    public static void sort(int[] a) {
        odd_even_sort_impl(a, a.length);
    }
}
