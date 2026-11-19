// GENERATED from kernels/algos/gnome_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class GnomeSort {
    private GnomeSort() {}

    static void gnome_sort_impl(int[] a, long n) {
        long i = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        i = 0L;
        while ((i < n)) {
            if (((i == 0L) || (((long)a[(int)((i - 1L))]) <= ((long)a[(int)(i)])))) {
                i = (i + 1L);
            } else {
                _i1 = (i - 1L);
                _i2 = i;
                _t1 = ((long)a[(int)(_i1)]);
                a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                a[(int)(_i2)] = (int)(_t1);
                i = (i - 1L);
            }
        }
    }

    public static void sort(int[] a) {
        gnome_sort_impl(a, a.length);
    }
}
