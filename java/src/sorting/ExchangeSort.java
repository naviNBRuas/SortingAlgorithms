// GENERATED from kernels/algos/exchange_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class ExchangeSort {
    private ExchangeSort() {}

    static void exchange_sort_impl(int[] a, long n) {
        long i = 0;
        long j = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        i = 0L;
        _e1 = (n - 1L);
        while ((i < _e1)) {
            j = (i + 1L);
            _e2 = n;
            while ((j < _e2)) {
                if ((((long)a[(int)(j)]) < ((long)a[(int)(i)]))) {
                    _i1 = i;
                    _i2 = j;
                    _t1 = ((long)a[(int)(_i1)]);
                    a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                    a[(int)(_i2)] = (int)(_t1);
                }
                j = (j + 1);
            }
            i = (i + 1);
        }
    }

    public static void sort(int[] a) {
        exchange_sort_impl(a, a.length);
    }
}
