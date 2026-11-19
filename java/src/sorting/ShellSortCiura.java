// GENERATED from kernels/algos/shell_sort_ciura.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class ShellSortCiura {
    private ShellSortCiura() {}

    static void shell_sort_ciura_impl(int[] a, long n) {
        long k = 0;
        long gap = 0;
        long i = 0;
        long key = 0;
        long j = 0;
        long _e1 = 0;
        int[] g = null;
        g = new int[(int)Math.max(1L, 10L)];
        g[(int)(0L)] = (int)(1L);
        g[(int)(1L)] = (int)(4L);
        g[(int)(2L)] = (int)(10L);
        g[(int)(3L)] = (int)(23L);
        g[(int)(4L)] = (int)(57L);
        g[(int)(5L)] = (int)(132L);
        g[(int)(6L)] = (int)(301L);
        g[(int)(7L)] = (int)(701L);
        g[(int)(8L)] = (int)(1750L);
        g[(int)(9L)] = (int)(4377L);
        k = 9L;
        while ((k >= 0L)) {
            gap = ((long)g[(int)(k)]);
            if ((gap < n)) {
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
            }
            k = (k - 1L);
        }
    }

    public static void sort(int[] a) {
        shell_sort_ciura_impl(a, a.length);
    }
}
