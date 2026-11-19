// GENERATED from kernels/algos/shell_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class ShellSort {
    private ShellSort() {}

    static void shell_sort_impl(int[] a, long n) {
        long gap = 0;
        long i = 0;
        long key = 0;
        long j = 0;
        long _e1 = 0;
        gap = (n / 2L);
        while ((gap > 0L)) {
            i = gap;
            _e1 = n;
            while ((i < _e1)) {
                key = ((long)a[(int)(i)]);
                j = i;
                while (((j >= gap) && (((long)a[(int)((j - gap))]) > key))) {
                    a[(int)(j)] = (int)(((long)a[(int)((j - gap))]));
                    j = (j - gap);
                }
                a[(int)(j)] = (int)(key);
                i = (i + 1);
            }
            gap = (gap / 2L);
        }
    }

    public static void sort(int[] a) {
        shell_sort_impl(a, a.length);
    }
}
