// GENERATED from kernels/algos/bottom_up_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class BottomUpHeapSort {
    private BottomUpHeapSort() {}

    static void bottom_up_heap_sort_x_sift(int[] a, long root, long size) {
        long j = 0;
        long x = 0;
        long cur = 0;
        long c = 0;
        j = root;
        while ((((2L * j) + 2L) < size)) {
            if ((((long)a[(int)(((2L * j) + 1L))]) < ((long)a[(int)(((2L * j) + 2L))]))) {
                j = ((2L * j) + 2L);
            } else {
                j = ((2L * j) + 1L);
            }
        }
        if ((((2L * j) + 1L) < size)) {
            j = ((2L * j) + 1L);
        }
        x = ((long)a[(int)(root)]);
        while ((((long)a[(int)(j)]) < x)) {
            j = ((j - 1L) / 2L);
        }
        cur = root;
        while ((cur != j)) {
            c = j;
            while ((((c - 1L) / 2L) != cur)) {
                c = ((c - 1L) / 2L);
            }
            a[(int)(cur)] = (int)(((long)a[(int)(c)]));
            cur = c;
        }
        a[(int)(j)] = (int)(x);
    }

    static void bottom_up_heap_sort_impl(int[] a, long n) {
        long s = 0;
        long end = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        s = (n / 2L);
        while ((s > 0L)) {
            s = (s - 1L);
            bottom_up_heap_sort_x_sift(a, s, n);
        }
        end = (n - 1L);
        while ((end > 0L)) {
            _i1 = 0L;
            _i2 = end;
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
            bottom_up_heap_sort_x_sift(a, 0L, end);
            end = (end - 1L);
        }
    }

    public static void sort(int[] a) {
        bottom_up_heap_sort_impl(a, a.length);
    }
}
