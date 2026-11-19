// GENERATED from kernels/algos/heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class HeapSort {
    private HeapSort() {}

    static void heap_sort_x_sift(int[] a, long root, long size) {
        long going = 0;
        long child = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        going = 1L;
        while ((going == 1L)) {
            child = ((2L * root) + 1L);
            if ((child >= size)) {
                going = 0L;
            } else {
                if ((((child + 1L) < size) && (((long)a[(int)(child)]) < ((long)a[(int)((child + 1L))])))) {
                    child = (child + 1L);
                }
                if ((((long)a[(int)(root)]) < ((long)a[(int)(child)]))) {
                    _i1 = root;
                    _i2 = child;
                    _t1 = ((long)a[(int)(_i1)]);
                    a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                    a[(int)(_i2)] = (int)(_t1);
                    root = child;
                } else {
                    going = 0L;
                }
            }
        }
    }

    static void heap_sort_impl(int[] a, long n) {
        long s = 0;
        long end = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        s = (n / 2L);
        while ((s > 0L)) {
            s = (s - 1L);
            heap_sort_x_sift(a, s, n);
        }
        end = (n - 1L);
        while ((end > 0L)) {
            _i1 = 0L;
            _i2 = end;
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
            heap_sort_x_sift(a, 0L, end);
            end = (end - 1L);
        }
    }

    public static void sort(int[] a) {
        heap_sort_impl(a, a.length);
    }
}
