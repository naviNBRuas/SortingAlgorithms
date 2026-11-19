// GENERATED from kernels/algos/in_place_merge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class InPlaceMergeSort {
    private InPlaceMergeSort() {}

    static void in_place_merge_sort_x_reverse(int[] a, long i, long j) {
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        j = (j - 1L);
        while ((i < j)) {
            _i1 = i;
            _i2 = j;
            _t1 = ((long)a[(int)(_i1)]);
            a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
            a[(int)(_i2)] = (int)(_t1);
            i = (i + 1L);
            j = (j - 1L);
        }
    }

    static void in_place_merge_sort_x_rotate(int[] a, long i, long m, long j) {
        in_place_merge_sort_x_reverse(a, i, m);
        in_place_merge_sort_x_reverse(a, m, j);
        in_place_merge_sort_x_reverse(a, i, j);
    }

    static void in_place_merge_sort_x_merge(int[] a, long lo, long mid, long hi) {
        long i = 0;
        long pivot = 0;
        long l = 0;
        long h = 0;
        long m = 0;
        long j = 0;
        long nm = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        if (((lo >= mid) || (mid >= hi))) {
            return;
        }
        if (((hi - lo) == 2L)) {
            if ((((long)a[(int)(mid)]) < ((long)a[(int)(lo)]))) {
                _i1 = lo;
                _i2 = mid;
                _t1 = ((long)a[(int)(_i1)]);
                a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                a[(int)(_i2)] = (int)(_t1);
            }
            return;
        }
        if (((mid - lo) >= (hi - mid))) {
            i = ((lo + mid) / 2L);
            pivot = ((long)a[(int)(i)]);
            l = mid;
            h = hi;
            while ((l < h)) {
                m = ((l + h) / 2L);
                if ((((long)a[(int)(m)]) < pivot)) {
                    l = (m + 1L);
                } else {
                    h = m;
                }
            }
            j = l;
            in_place_merge_sort_x_rotate(a, i, mid, j);
            nm = (i + (j - mid));
            in_place_merge_sort_x_merge(a, lo, i, nm);
            in_place_merge_sort_x_merge(a, (nm + 1L), j, hi);
        } else {
            j = ((mid + hi) / 2L);
            pivot = ((long)a[(int)(j)]);
            l = lo;
            h = mid;
            while ((l < h)) {
                m = ((l + h) / 2L);
                if ((pivot < ((long)a[(int)(m)]))) {
                    h = m;
                } else {
                    l = (m + 1L);
                }
            }
            i = l;
            in_place_merge_sort_x_rotate(a, i, mid, (j + 1L));
            nm = (i + ((j + 1L) - mid));
            in_place_merge_sort_x_merge(a, lo, i, (nm - 1L));
            in_place_merge_sort_x_merge(a, nm, (j + 1L), hi);
        }
    }

    static void in_place_merge_sort_x_rec(int[] a, long lo, long hi) {
        long mid = 0;
        if (((hi - lo) < 2L)) {
            return;
        }
        mid = ((lo + hi) / 2L);
        in_place_merge_sort_x_rec(a, lo, mid);
        in_place_merge_sort_x_rec(a, mid, hi);
        in_place_merge_sort_x_merge(a, lo, mid, hi);
    }

    static void in_place_merge_sort_impl(int[] a, long n) {
        in_place_merge_sort_x_rec(a, 0L, n);
    }

    public static void sort(int[] a) {
        in_place_merge_sort_impl(a, a.length);
    }
}
