// GENERATED from kernels/algos/enumeration_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class EnumerationSort {
    private EnumerationSort() {}

    static void enumeration_sort_impl(int[] a, long n) {
        long i = 0;
        long rank = 0;
        long j = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        int[] out = null;
        out = new int[(int)Math.max(1L, n)];
        i = 0L;
        _e1 = n;
        while ((i < _e1)) {
            rank = 0L;
            j = 0L;
            _e2 = n;
            while ((j < _e2)) {
                if (((((long)a[(int)(j)]) < ((long)a[(int)(i)])) || ((((long)a[(int)(j)]) == ((long)a[(int)(i)])) && (j < i)))) {
                    rank = (rank + 1L);
                }
                j = (j + 1);
            }
            out[(int)(rank)] = (int)(((long)a[(int)(i)]));
            i = (i + 1);
        }
        i = 0L;
        _e3 = n;
        while ((i < _e3)) {
            a[(int)(i)] = (int)(((long)out[(int)(i)]));
            i = (i + 1);
        }
    }

    public static void sort(int[] a) {
        enumeration_sort_impl(a, a.length);
    }
}
