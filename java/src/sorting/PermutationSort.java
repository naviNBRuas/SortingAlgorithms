// GENERATED from kernels/algos/permutation_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class PermutationSort {
    private PermutationSort() {}

    static void permutation_sort_impl(int[] a, long n) {
        long i = 0;
        long found = 0;
        long ok = 0;
        long j = 0;
        long lo = 0;
        long hi = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        int[] vals = null;
        int[] idx = null;
        vals = new int[(int)Math.max(1L, n)];
        idx = new int[(int)Math.max(1L, n)];
        i = 0L;
        _e1 = n;
        while ((i < _e1)) {
            vals[(int)(i)] = (int)(((long)a[(int)(i)]));
            idx[(int)(i)] = (int)(i);
            i = (i + 1);
        }
        found = 0L;
        while ((found == 0L)) {
            ok = 1L;
            i = 0L;
            _e2 = (n - 1L);
            while ((i < _e2)) {
                if ((((long)vals[(int)(((long)idx[(int)((i + 1L))]))]) < ((long)vals[(int)(((long)idx[(int)(i)]))]))) {
                    ok = 0L;
                }
                i = (i + 1);
            }
            if ((ok == 1L)) {
                found = 1L;
            } else {
                i = (n - 2L);
                while (((i >= 0L) && (((long)idx[(int)(i)]) > ((long)idx[(int)((i + 1L))])))) {
                    i = (i - 1L);
                }
                if ((i < 0L)) {
                    found = 1L;
                } else {
                    j = (n - 1L);
                    while ((((long)idx[(int)(j)]) < ((long)idx[(int)(i)]))) {
                        j = (j - 1L);
                    }
                    _i1 = i;
                    _i2 = j;
                    _t1 = ((long)idx[(int)(_i1)]);
                    idx[(int)(_i1)] = (int)(((long)idx[(int)(_i2)]));
                    idx[(int)(_i2)] = (int)(_t1);
                    lo = (i + 1L);
                    hi = (n - 1L);
                    while ((lo < hi)) {
                        _i1 = lo;
                        _i2 = hi;
                        _t1 = ((long)idx[(int)(_i1)]);
                        idx[(int)(_i1)] = (int)(((long)idx[(int)(_i2)]));
                        idx[(int)(_i2)] = (int)(_t1);
                        lo = (lo + 1L);
                        hi = (hi - 1L);
                    }
                }
            }
        }
        i = 0L;
        _e3 = n;
        while ((i < _e3)) {
            a[(int)(i)] = (int)(((long)vals[(int)(((long)idx[(int)(i)]))]));
            i = (i + 1);
        }
    }

    public static void sort(int[] a) {
        permutation_sort_impl(a, a.length);
    }
}
