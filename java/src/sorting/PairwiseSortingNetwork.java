// GENERATED from kernels/algos/pairwise_sorting_network.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class PairwiseSortingNetwork {
    private PairwiseSortingNetwork() {}

    static void pairwise_sorting_network_x_cmp_swap(int[] a, long i, long j, long n) {
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        if ((j < n)) {
            if ((((long)a[(int)(i)]) > ((long)a[(int)(j)]))) {
                _i1 = i;
                _i2 = j;
                _t1 = ((long)a[(int)(_i1)]);
                a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                a[(int)(_i2)] = (int)(_t1);
            }
        }
    }

    static void pairwise_sorting_network_impl(int[] a, long n) {
        long size = 0;
        long step = 0;
        long b = 0;
        long c = 0;
        long e = 0;
        long d = 0;
        size = 1L;
        while ((size < n)) {
            size = (size * 2L);
        }
        step = 1L;
        while ((step < size)) {
            b = step;
            c = 0L;
            while ((b < size)) {
                pairwise_sorting_network_x_cmp_swap(a, (b - step), b, n);
                b = (b + 1L);
                c = (c + 1L);
                if ((c >= step)) {
                    c = 0L;
                    b = (b + step);
                }
            }
            step = (step * 2L);
        }
        step = (step / 4L);
        e = 1L;
        while ((step > 0L)) {
            d = e;
            while ((d > 0L)) {
                b = ((d + 1L) * step);
                c = 0L;
                while ((b < size)) {
                    pairwise_sorting_network_x_cmp_swap(a, (b - (d * step)), b, n);
                    b = (b + 1L);
                    c = (c + 1L);
                    if ((c >= step)) {
                        c = 0L;
                        b = (b + step);
                    }
                }
                d = (d / 2L);
            }
            step = (step / 2L);
            e = ((e * 2L) + 1L);
        }
    }

    public static void sort(int[] a) {
        pairwise_sorting_network_impl(a, a.length);
    }
}
