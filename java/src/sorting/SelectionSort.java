// GENERATED from kernels/algos/selection_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class SelectionSort {
    private SelectionSort() {}

    static void selection_sort_impl(int[] a, long n) {
        long i = 0;
        long m = 0;
        long j = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        i = 0L;
        _e1 = (n - 1L);
        while ((i < _e1)) {
            m = i;
            j = (i + 1L);
            _e2 = n;
            while ((j < _e2)) {
                if ((((long)a[(int)(j)]) < ((long)a[(int)(m)]))) {
                    m = j;
                }
                j = (j + 1);
            }
            if ((m != i)) {
                _i1 = i;
                _i2 = m;
                _t1 = ((long)a[(int)(_i1)]);
                a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                a[(int)(_i2)] = (int)(_t1);
            }
            i = (i + 1);
        }
    }

    public static void sort(int[] a) {
        selection_sort_impl(a, a.length);
    }
}
