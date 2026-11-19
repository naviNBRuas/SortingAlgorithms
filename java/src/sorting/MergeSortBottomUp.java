// GENERATED from kernels/algos/merge_sort_bottom_up.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class MergeSortBottomUp {
    private MergeSortBottomUp() {}

    static void merge_sort_bottom_up_impl(int[] a, long n) {
        long width = 0;
        long lo = 0;
        long mid = 0;
        long hi = 0;
        long x = 0;
        long i = 0;
        long j = 0;
        long k = 0;
        long _e1 = 0;
        int[] tmp = null;
        tmp = new int[(int)Math.max(1L, n)];
        width = 1L;
        while ((width < n)) {
            lo = 0L;
            while ((lo < n)) {
                mid = Math.min((lo + width), n);
                hi = Math.min((lo + (2L * width)), n);
                x = lo;
                _e1 = mid;
                while ((x < _e1)) {
                    tmp[(int)(x)] = (int)(((long)a[(int)(x)]));
                    x = (x + 1);
                }
                i = lo;
                j = mid;
                k = lo;
                while (((i < mid) && (j < hi))) {
                    if ((((long)a[(int)(j)]) < ((long)tmp[(int)(i)]))) {
                        a[(int)(k)] = (int)(((long)a[(int)(j)]));
                        j = (j + 1L);
                    } else {
                        a[(int)(k)] = (int)(((long)tmp[(int)(i)]));
                        i = (i + 1L);
                    }
                    k = (k + 1L);
                }
                while ((i < mid)) {
                    a[(int)(k)] = (int)(((long)tmp[(int)(i)]));
                    i = (i + 1L);
                    k = (k + 1L);
                }
                lo = (lo + (2L * width));
            }
            width = (width * 2L);
        }
    }

    public static void sort(int[] a) {
        merge_sort_bottom_up_impl(a, a.length);
    }
}
