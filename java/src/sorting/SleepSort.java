// GENERATED from kernels/algos/sleep_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class SleepSort {
    private SleepSort() {}

    static void sleep_sort_x_fallback(int[] a, long n) {
        long gap = 0;
        long i = 0;
        long key = 0;
        long j = 0;
        long _e1 = 0;
        gap = (n / 2L);
        while ((gap > 0L)) {
            i = gap;
            _e1 = n;
            while ((i < _e1)) {
                key = ((long)a[(int)(i)]);
                j = i;
                while (((j >= gap) && (((long)a[(int)((j - gap))]) > key))) {
                    a[(int)(j)] = (int)(((long)a[(int)((j - gap))]));
                    j = (j - gap);
                }
                a[(int)(j)] = (int)(key);
                i = (i + 1);
            }
            gap = (gap / 2L);
        }
    }

    static void sleep_sort_impl(int[] a, long n) {
        long mn = 0;
        long mx = 0;
        long i = 0;
        long rng = 0;
        long t = 0;
        long out = 0;
        long node = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        int[] head = null;
        int[] nxt = null;
        int[] vals = null;
        if ((n < 2L)) {
            return;
        }
        mn = ((long)a[(int)(0L)]);
        mx = ((long)a[(int)(0L)]);
        i = 1L;
        _e1 = n;
        while ((i < _e1)) {
            if ((((long)a[(int)(i)]) < mn)) {
                mn = ((long)a[(int)(i)]);
            }
            if ((((long)a[(int)(i)]) > mx)) {
                mx = ((long)a[(int)(i)]);
            }
            i = (i + 1);
        }
        rng = ((mx - mn) + 1L);
        if ((rng > 4000000L)) {
            sleep_sort_x_fallback(a, n);
            return;
        }
        head = new int[(int)Math.max(1L, rng)];
        nxt = new int[(int)Math.max(1L, n)];
        i = (n - 1L);
        while ((i >= 0L)) {
            t = (((long)a[(int)(i)]) - mn);
            nxt[(int)(i)] = (int)(((long)head[(int)(t)]));
            head[(int)(t)] = (int)((i + 1L));
            i = (i - 1L);
        }
        vals = new int[(int)Math.max(1L, n)];
        i = 0L;
        _e2 = n;
        while ((i < _e2)) {
            vals[(int)(i)] = (int)(((long)a[(int)(i)]));
            i = (i + 1);
        }
        out = 0L;
        t = 0L;
        _e3 = rng;
        while ((t < _e3)) {
            node = ((long)head[(int)(t)]);
            while ((node != 0L)) {
                a[(int)(out)] = (int)(((long)vals[(int)((node - 1L))]));
                out = (out + 1L);
                node = ((long)nxt[(int)((node - 1L))]);
            }
            t = (t + 1);
        }
    }

    public static void sort(int[] a) {
        sleep_sort_impl(a, a.length);
    }
}
