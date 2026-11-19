// GENERATED from kernels/algos/tournament_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class TournamentSort {
    private TournamentSort() {}

    static long tournament_sort_x_better(int[] vals, long x, long y) {
        if ((x < 0L)) {
            return y;
        }
        if ((y < 0L)) {
            return x;
        }
        if ((((long)vals[(int)(x)]) <= ((long)vals[(int)(y)]))) {
            return x;
        }
        return y;
    }

    static void tournament_sort_impl(int[] a, long n) {
        long size = 0;
        long i = 0;
        long k = 0;
        long w = 0;
        long node = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        long _e4 = 0;
        int[] vals = null;
        int[] out = null;
        int[] tree = null;
        if ((n < 2L)) {
            return;
        }
        size = 1L;
        while ((size < n)) {
            size = (size * 2L);
        }
        vals = new int[(int)Math.max(1L, n)];
        out = new int[(int)Math.max(1L, n)];
        tree = new int[(int)Math.max(1L, (2L * size))];
        i = 0L;
        _e1 = (2L * size);
        while ((i < _e1)) {
            tree[(int)(i)] = (int)((-1L));
            i = (i + 1);
        }
        i = 0L;
        _e2 = n;
        while ((i < _e2)) {
            vals[(int)(i)] = (int)(((long)a[(int)(i)]));
            tree[(int)((size + i))] = (int)(i);
            i = (i + 1);
        }
        i = (size - 1L);
        while ((i >= 1L)) {
            tree[(int)(i)] = (int)(tournament_sort_x_better(vals, ((long)tree[(int)((2L * i))]), ((long)tree[(int)(((2L * i) + 1L))])));
            i = (i - 1L);
        }
        k = 0L;
        _e3 = n;
        while ((k < _e3)) {
            w = ((long)tree[(int)(1L)]);
            out[(int)(k)] = (int)(((long)vals[(int)(w)]));
            node = (size + w);
            tree[(int)(node)] = (int)((-1L));
            node = (node / 2L);
            while ((node >= 1L)) {
                tree[(int)(node)] = (int)(tournament_sort_x_better(vals, ((long)tree[(int)((2L * node))]), ((long)tree[(int)(((2L * node) + 1L))])));
                node = (node / 2L);
            }
            k = (k + 1);
        }
        i = 0L;
        _e4 = n;
        while ((i < _e4)) {
            a[(int)(i)] = (int)(((long)out[(int)(i)]));
            i = (i + 1);
        }
    }

    public static void sort(int[] a) {
        tournament_sort_impl(a, a.length);
    }
}
