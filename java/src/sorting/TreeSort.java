// GENERATED from kernels/algos/tree_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class TreeSort {
    private TreeSort() {}

    static void tree_sort_impl(int[] a, long n) {
        long i = 0;
        long cur = 0;
        long placed = 0;
        long node = 0;
        long sp = 0;
        long out = 0;
        long _e1 = 0;
        long _e2 = 0;
        int[] vals = null;
        int[] left = null;
        int[] right = null;
        int[] stack = null;
        if ((n < 2L)) {
            return;
        }
        vals = new int[(int)Math.max(1L, n)];
        left = new int[(int)Math.max(1L, n)];
        right = new int[(int)Math.max(1L, n)];
        stack = new int[(int)Math.max(1L, n)];
        i = 0L;
        _e1 = n;
        while ((i < _e1)) {
            vals[(int)(i)] = (int)(((long)a[(int)(i)]));
            i = (i + 1);
        }
        i = 1L;
        _e2 = n;
        while ((i < _e2)) {
            cur = 0L;
            placed = 0L;
            while ((placed == 0L)) {
                if ((((long)vals[(int)(i)]) < ((long)vals[(int)(cur)]))) {
                    if ((((long)left[(int)(cur)]) == 0L)) {
                        left[(int)(cur)] = (int)((i + 1L));
                        placed = 1L;
                    } else {
                        cur = (((long)left[(int)(cur)]) - 1L);
                    }
                } else {
                    if ((((long)right[(int)(cur)]) == 0L)) {
                        right[(int)(cur)] = (int)((i + 1L));
                        placed = 1L;
                    } else {
                        cur = (((long)right[(int)(cur)]) - 1L);
                    }
                }
            }
            i = (i + 1);
        }
        node = 1L;
        sp = 0L;
        out = 0L;
        while (((node != 0L) || (sp > 0L))) {
            if ((node != 0L)) {
                stack[(int)(sp)] = (int)(node);
                sp = (sp + 1L);
                node = ((long)left[(int)((node - 1L))]);
            } else {
                sp = (sp - 1L);
                node = ((long)stack[(int)(sp)]);
                a[(int)(out)] = (int)(((long)vals[(int)((node - 1L))]));
                out = (out + 1L);
                node = ((long)right[(int)((node - 1L))]);
            }
        }
    }

    public static void sort(int[] a) {
        tree_sort_impl(a, a.length);
    }
}
