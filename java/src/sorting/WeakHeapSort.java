// GENERATED from kernels/algos/weak_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class WeakHeapSort {
    private WeakHeapSort() {}

    static long weak_heap_sort_x_gparent(int[] r, long j) {
        while (((j % 2L) == ((long)r[(int)((j / 2L))]))) {
            j = (j / 2L);
        }
        return (j / 2L);
    }

    static void weak_heap_sort_x_join(int[] a, int[] r, long i, long j) {
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        if ((((long)a[(int)(i)]) < ((long)a[(int)(j)]))) {
            _i1 = i;
            _i2 = j;
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
            r[(int)(j)] = (int)((1L - ((long)r[(int)(j)])));
        }
    }

    static void weak_heap_sort_impl(int[] a, long n) {
        long j = 0;
        long g = 0;
        long m = 0;
        long x = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        int[] r = null;
        if ((n < 2L)) {
            return;
        }
        r = new int[(int)Math.max(1L, n)];
        j = (n - 1L);
        while ((j > 0L)) {
            g = weak_heap_sort_x_gparent(r, j);
            weak_heap_sort_x_join(a, r, g, j);
            j = (j - 1L);
        }
        m = (n - 1L);
        while ((m > 1L)) {
            _i1 = 0L;
            _i2 = m;
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
            x = 1L;
            while ((((2L * x) + ((long)r[(int)(x)])) < m)) {
                x = ((2L * x) + ((long)r[(int)(x)]));
            }
            while ((x > 0L)) {
                weak_heap_sort_x_join(a, r, 0L, x);
                x = (x / 2L);
            }
            m = (m - 1L);
        }
        _i1 = 0L;
        _i2 = 1L;
        _t1 = ((long)a[(int)(_i1)]);
        a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
        a[(int)(_i2)] = (int)(_t1);
    }

    public static void sort(int[] a) {
        weak_heap_sort_impl(a, a.length);
    }
}
