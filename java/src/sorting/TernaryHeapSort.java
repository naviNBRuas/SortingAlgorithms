// GENERATED from kernels/algos/ternary_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class TernaryHeapSort {
    private TernaryHeapSort() {}

    static void ternary_heap_sort_x_sift(int[] a, long root, long size) {
        long going = 0;
        long first = 0;
        long best = 0;
        long c = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        going = 1L;
        while ((going == 1L)) {
            first = ((3L * root) + 1L);
            if ((first >= size)) {
                going = 0L;
            } else {
                best = first;
                c = (first + 1L);
                while (((c < (first + 3L)) && (c < size))) {
                    if ((((long)a[(int)(best)]) < ((long)a[(int)(c)]))) {
                        best = c;
                    }
                    c = (c + 1L);
                }
                if ((((long)a[(int)(root)]) < ((long)a[(int)(best)]))) {
                    _i1 = root;
                    _i2 = best;
                    _t1 = ((long)a[(int)(_i1)]);
                    a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                    a[(int)(_i2)] = (int)(_t1);
                    root = best;
                } else {
                    going = 0L;
                }
            }
        }
    }

    static void ternary_heap_sort_impl(int[] a, long n) {
        long s = 0;
        long end = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        if ((n < 2L)) {
            return;
        }
        s = (((n - 2L) / 3L) + 1L);
        while ((s > 0L)) {
            s = (s - 1L);
            ternary_heap_sort_x_sift(a, s, n);
        }
        end = (n - 1L);
        while ((end > 0L)) {
            _i1 = 0L;
            _i2 = end;
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
            ternary_heap_sort_x_sift(a, 0L, end);
            end = (end - 1L);
        }
    }

    public static void sort(int[] a) {
        ternary_heap_sort_impl(a, a.length);
    }
}
