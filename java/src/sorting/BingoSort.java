// GENERATED from kernels/algos/bingo_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class BingoSort {
    private BingoSort() {}

    static void bingo_sort_impl(int[] a, long n) {
        long mx = 0;
        long nxt = 0;
        long i = 0;
        long bingo = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        if ((n < 2L)) {
            return;
        }
        mx = (n - 1L);
        nxt = ((long)a[(int)(mx)]);
        i = (mx - 1L);
        while ((i >= 0L)) {
            if ((((long)a[(int)(i)]) > nxt)) {
                nxt = ((long)a[(int)(i)]);
            }
            i = (i - 1L);
        }
        while (((mx > 0L) && (((long)a[(int)(mx)]) == nxt))) {
            mx = (mx - 1L);
        }
        while ((mx > 0L)) {
            bingo = nxt;
            nxt = ((long)a[(int)(mx)]);
            i = (mx - 1L);
            while ((i >= 0L)) {
                if ((((long)a[(int)(i)]) == bingo)) {
                    _i1 = i;
                    _i2 = mx;
                    _t1 = ((long)a[(int)(_i1)]);
                    a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                    a[(int)(_i2)] = (int)(_t1);
                    mx = (mx - 1L);
                } else {
                    if ((((long)a[(int)(i)]) > nxt)) {
                        nxt = ((long)a[(int)(i)]);
                    }
                }
                i = (i - 1L);
            }
            while (((mx > 0L) && (((long)a[(int)(mx)]) == nxt))) {
                mx = (mx - 1L);
            }
        }
    }

    public static void sort(int[] a) {
        bingo_sort_impl(a, a.length);
    }
}
