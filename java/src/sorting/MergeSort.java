// GENERATED from kernels/algos/merge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class MergeSort {
    private MergeSort() {}

    static void merge_sort_x_rec(int[] a, int[] tmp, long lo, long hi) {
        long mid = 0;
        long x = 0;
        long i = 0;
        long j = 0;
        long k = 0;
        long _e1 = 0;
        if (((hi - lo) < 2L)) {
            return;
        }
        mid = ((lo + hi) / 2L);
        merge_sort_x_rec(a, tmp, lo, mid);
        merge_sort_x_rec(a, tmp, mid, hi);
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
    }

    static void merge_sort_impl(int[] a, long n) {
        int[] tmp = null;
        tmp = new int[(int)Math.max(1L, n)];
        merge_sort_x_rec(a, tmp, 0L, n);
    }

    public static void sort(int[] a) {
        merge_sort_impl(a, a.length);
    }
}
