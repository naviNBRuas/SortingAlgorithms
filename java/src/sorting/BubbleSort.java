// GENERATED from kernels/algos/bubble_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class BubbleSort {
    private BubbleSort() {}

    static void bubble_sort_impl(int[] a, long n) {
        long end = 0;
        long swapped = 0;
        long j = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        end = (n - 1L);
        swapped = 1L;
        while (((end > 0L) && (swapped == 1L))) {
            swapped = 0L;
            j = 0L;
            while ((j < end)) {
                if ((((long)a[(int)(j)]) > ((long)a[(int)((j + 1L))]))) {
                    _i1 = j;
                    _i2 = (j + 1L);
                    _t1 = ((long)a[(int)(_i1)]);
                    a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                    a[(int)(_i2)] = (int)(_t1);
                    swapped = 1L;
                }
                j = (j + 1L);
            }
            end = (end - 1L);
        }
    }

    public static void sort(int[] a) {
        bubble_sort_impl(a, a.length);
    }
}
