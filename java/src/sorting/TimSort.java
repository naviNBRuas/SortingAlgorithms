// GENERATED from kernels/algos/tim_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class TimSort {
    private TimSort() {}

    static void tim_sort_x_insertion(int[] a, long lo, long hi) {
        long i = 0;
        long key = 0;
        long j = 0;
        long _e1 = 0;
        i = (lo + 1L);
        _e1 = hi;
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

    static long tim_sort_x_merge_at(int[] a, int[] tmp, int[] rs, int[] rl, long cnt, long i) {
        long s1 = 0;
        long l1 = 0;
        long l2 = 0;
        long x = 0;
        long j = 0;
        long k = 0;
        long end = 0;
        long t = 0;
        long _e1 = 0;
        long _e2 = 0;
        s1 = ((long)rs[(int)(i)]);
        l1 = ((long)rl[(int)(i)]);
        l2 = ((long)rl[(int)((i + 1L))]);
        x = 0L;
        _e1 = l1;
        while ((x < _e1)) {
            tmp[(int)(x)] = (int)(((long)a[(int)((s1 + x))]));
            x = (x + 1);
        }
        x = 0L;
        j = (s1 + l1);
        k = s1;
        end = (j + l2);
        while (((x < l1) && (j < end))) {
            if ((((long)a[(int)(j)]) < ((long)tmp[(int)(x)]))) {
                a[(int)(k)] = (int)(((long)a[(int)(j)]));
                j = (j + 1L);
            } else {
                a[(int)(k)] = (int)(((long)tmp[(int)(x)]));
                x = (x + 1L);
            }
            k = (k + 1L);
        }
        while ((x < l1)) {
            a[(int)(k)] = (int)(((long)tmp[(int)(x)]));
            x = (x + 1L);
            k = (k + 1L);
        }
        rl[(int)(i)] = (int)((l1 + l2));
        t = (i + 1L);
        _e2 = (cnt - 1L);
        while ((t < _e2)) {
            rs[(int)(t)] = (int)(((long)rs[(int)((t + 1L))]));
            rl[(int)(t)] = (int)(((long)rl[(int)((t + 1L))]));
            t = (t + 1);
        }
        return (cnt - 1L);
    }

    static long tim_sort_x_collapse(int[] a, int[] tmp, int[] rs, int[] rl, long cnt) {
        long going = 0;
        long m = 0;
        long need = 0;
        going = 1L;
        while (((going == 1L) && (cnt > 1L))) {
            m = (cnt - 2L);
            need = 0L;
            if (((m > 0L) && (((long)rl[(int)((m - 1L))]) <= (((long)rl[(int)(m)]) + ((long)rl[(int)((m + 1L))]))))) {
                need = 1L;
            }
            if (((m > 1L) && (((long)rl[(int)((m - 2L))]) <= (((long)rl[(int)((m - 1L))]) + ((long)rl[(int)(m)]))))) {
                need = 1L;
            }
            if ((need == 1L)) {
                if (((m > 0L) && (((long)rl[(int)((m - 1L))]) < ((long)rl[(int)((m + 1L))])))) {
                    m = (m - 1L);
                }
                cnt = tim_sort_x_merge_at(a, tmp, rs, rl, cnt, m);
            } else {
                if ((((long)rl[(int)(m)]) <= ((long)rl[(int)((m + 1L))]))) {
                    cnt = tim_sort_x_merge_at(a, tmp, rs, rl, cnt, m);
                } else {
                    going = 0L;
                }
            }
        }
        return cnt;
    }

    static void tim_sort_impl(int[] a, long n) {
        long r = 0;
        long t = 0;
        long minrun = 0;
        long cnt = 0;
        long lo = 0;
        long e = 0;
        long x = 0;
        long y = 0;
        long force = 0;
        long m = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        int[] tmp = null;
        int[] rs = null;
        int[] rl = null;
        if ((n < 2L)) {
            return;
        }
        tmp = new int[(int)Math.max(1L, n)];
        rs = new int[(int)Math.max(1L, 128L)];
        rl = new int[(int)Math.max(1L, 128L)];
        r = 0L;
        t = n;
        while ((t >= 64L)) {
            r = (r + (t % 2L));
            if ((r > 1L)) {
                r = 1L;
            }
            t = (t / 2L);
        }
        minrun = (t + r);
        cnt = 0L;
        lo = 0L;
        while ((lo < n)) {
            e = (lo + 1L);
            if ((e < n)) {
                if ((((long)a[(int)(e)]) < ((long)a[(int)((e - 1L))]))) {
                    while (((e < n) && (((long)a[(int)(e)]) < ((long)a[(int)((e - 1L))])))) {
                        e = (e + 1L);
                    }
                    x = lo;
                    y = (e - 1L);
                    while ((x < y)) {
                        _i1 = x;
                        _i2 = y;
                        _t1 = ((long)a[(int)(_i1)]);
                        a[(int)(_i1)] = (int)(((long)a[(int)(_i2)]));
                        a[(int)(_i2)] = (int)(_t1);
                        x = (x + 1L);
                        y = (y - 1L);
                    }
                } else {
                    while (((e < n) && (((long)a[(int)(e)]) >= ((long)a[(int)((e - 1L))])))) {
                        e = (e + 1L);
                    }
                }
            }
            force = Math.min(minrun, (n - lo));
            if (((e - lo) < force)) {
                tim_sort_x_insertion(a, lo, (lo + force));
                e = (lo + force);
            }
            rs[(int)(cnt)] = (int)(lo);
            rl[(int)(cnt)] = (int)((e - lo));
            cnt = (cnt + 1L);
            cnt = tim_sort_x_collapse(a, tmp, rs, rl, cnt);
            lo = e;
        }
        while ((cnt > 1L)) {
            m = (cnt - 2L);
            if (((m > 0L) && (((long)rl[(int)((m - 1L))]) < ((long)rl[(int)((m + 1L))])))) {
                m = (m - 1L);
            }
            cnt = tim_sort_x_merge_at(a, tmp, rs, rl, cnt, m);
        }
    }

    public static void sort(int[] a) {
        tim_sort_impl(a, a.length);
    }
}
