// GENERATED from kernels/algos/cycle_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class CycleSort {
    private CycleSort() {}

    static long cycle_sort_x_rank_of(int[] a, long n, long start, long item) {
        long pos = 0;
        long i = 0;
        long _e1 = 0;
        pos = start;
        i = (start + 1L);
        _e1 = n;
        while ((i < _e1)) {
            if ((((long)a[(int)(i)]) < item)) {
                pos = (pos + 1L);
            }
            i = (i + 1);
        }
        return pos;
    }

    static void cycle_sort_impl(int[] a, long n) {
        long start = 0;
        long item = 0;
        long pos = 0;
        long tmp = 0;
        long _e1 = 0;
        start = 0L;
        _e1 = (n - 1L);
        while ((start < _e1)) {
            item = ((long)a[(int)(start)]);
            pos = cycle_sort_x_rank_of(a, n, start, item);
            if ((pos != start)) {
                while ((item == ((long)a[(int)(pos)]))) {
                    pos = (pos + 1L);
                }
                tmp = ((long)a[(int)(pos)]);
                a[(int)(pos)] = (int)(item);
                item = tmp;
                while ((pos != start)) {
                    pos = cycle_sort_x_rank_of(a, n, start, item);
                    while ((item == ((long)a[(int)(pos)]))) {
                        pos = (pos + 1L);
                    }
                    tmp = ((long)a[(int)(pos)]);
                    a[(int)(pos)] = (int)(item);
                    item = tmp;
                }
            }
            start = (start + 1);
        }
    }

    public static void sort(int[] a) {
        cycle_sort_impl(a, a.length);
    }
}
