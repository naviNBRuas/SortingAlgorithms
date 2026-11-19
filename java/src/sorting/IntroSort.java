// GENERATED from kernels/algos/intro_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class IntroSort {
    private IntroSort() {}

    static void intro_sort_x_insertion(int[] a, long lo, long hi) {
        long i = 0;
        long key = 0;
        long j = 0;
        long _e1 = 0;
        i = (lo + 1L);
        _e1 = (hi + 1L);
        while ((i < _e1)) {
            key = ((long)a[(int)(i)]);
            j = (i - 1L);
            while (((j >= lo) && (((long)a[(int)(j)]) > key))) {
                a[(int)((j + 1L))] = (int)(((long)a[(int)(j)]));
                j = (j - 1L);
            }
            a[(int)((j + 1L))] = (int)(key);
            i = (i + 1);
        }
    }

    static void intro_sort_x_sift(int[] a, long base, long root, long size) {
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
                if ((((child + 1L) < size) && (((long)a[(int)((base + child))]) < ((long)a[(int)(((base + child) + 1L))])))) {
                    child = (child + 1L);
                }
                if ((((long)a[(int)((base + root))]) < ((long)a[(int)((base + child))]))) {
                    _i1 = (base + root);
                    _i2 = (base + child);
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

    static void intro_sort_x_heap(int[] a, long lo, long hi) {
        long size = 0;
        long s = 0;
        long end = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        size = ((hi - lo) + 1L);
        s = (size / 2L);
        while ((s > 0L)) {
            s = (s - 1L);
            intro_sort_x_sift(a, lo, s, size);
        }
        end = (size - 1L);
        while ((end > 0L)) {
            _i1 = lo;
            _i2 = (lo + end);
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
            intro_sort_x_sift(a, lo, 0L, end);
            end = (end - 1L);
        }
    }

    static void intro_sort_x_sort(int[] a, long lo, long hi, long depth) {
        long mid = 0;
        long pivot = 0;
        long i = 0;
        long j = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        while ((((hi - lo) + 1L) > 16L)) {
            if ((depth == 0L)) {
                intro_sort_x_heap(a, lo, hi);
                return;
            }
            depth = (depth - 1L);
            mid = ((lo + hi) / 2L);
            if ((((long)a[(int)(mid)]) < ((long)a[(int)(lo)]))) {
                _i1 = mid;
                _i2 = lo;
                _t1 = ((long)a[(int)(_i1)]);
                a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                a[(int)(_i2)] = (int)(_t1);
            }
            if ((((long)a[(int)(hi)]) < ((long)a[(int)(lo)]))) {
                _i1 = hi;
                _i2 = lo;
                _t1 = ((long)a[(int)(_i1)]);
                a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                a[(int)(_i2)] = (int)(_t1);
            }
            if ((((long)a[(int)(hi)]) < ((long)a[(int)(mid)]))) {
                _i1 = hi;
                _i2 = mid;
                _t1 = ((long)a[(int)(_i1)]);
                a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                a[(int)(_i2)] = (int)(_t1);
            }
            pivot = ((long)a[(int)(mid)]);
            i = lo;
            j = hi;
            while ((i <= j)) {
                while ((((long)a[(int)(i)]) < pivot)) {
                    i = (i + 1L);
                }
                while ((((long)a[(int)(j)]) > pivot)) {
                    j = (j - 1L);
                }
                if ((i <= j)) {
                    _i1 = i;
                    _i2 = j;
                    _t1 = ((long)a[(int)(_i1)]);
                    a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                    a[(int)(_i2)] = (int)(_t1);
                    i = (i + 1L);
                    j = (j - 1L);
                }
            }
            intro_sort_x_sort(a, lo, j, depth);
            lo = i;
        }
        intro_sort_x_insertion(a, lo, hi);
    }

    static void intro_sort_impl(int[] a, long n) {
        long depth = 0;
        long t = 0;
        depth = 0L;
        t = n;
        while ((t > 1L)) {
            t = (t / 2L);
            depth = (depth + 2L);
        }
        intro_sort_x_sort(a, 0L, (n - 1L), depth);
    }

    public static void sort(int[] a) {
        intro_sort_impl(a, a.length);
    }
}
