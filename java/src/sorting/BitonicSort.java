// GENERATED from kernels/algos/bitonic_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class BitonicSort {
    private BitonicSort() {}

    static void bitonic_sort_x_cmp_swap(int[] a, long i, long j) {
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        if ((((long)a[(int)(i)]) > ((long)a[(int)(j)]))) {
            _i1 = i;
            _i2 = j;
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
        }
    }

    static void bitonic_sort_impl(int[] a, long n) {
        long size = 0;
        long k = 0;
        long blk = 0;
        long t = 0;
        long j = 0;
        long i = 0;
        long _e1 = 0;
        long _e2 = 0;
        size = 1L;
        while ((size < n)) {
            size = (size * 2L);
        }
        k = 2L;
        while ((k <= size)) {
            blk = 0L;
            while ((blk < size)) {
                t = 0L;
                _e1 = (k / 2L);
                while ((t < _e1)) {
                    j = (((blk + k) - 1L) - t);
                    if ((j < n)) {
                        bitonic_sort_x_cmp_swap(a, (blk + t), j);
                    }
                    t = (t + 1);
                }
                blk = (blk + k);
            }
            j = (k / 4L);
            while ((j >= 1L)) {
                i = 0L;
                _e2 = size;
                while ((i < _e2)) {
                    if (((((i / j) % 2L) == 0L) && ((i + j) < n))) {
                        bitonic_sort_x_cmp_swap(a, i, (i + j));
                    }
                    i = (i + 1);
                }
                j = (j / 2L);
            }
            k = (k * 2L);
        }
    }

    public static void sort(int[] a) {
        bitonic_sort_impl(a, a.length);
    }
}
