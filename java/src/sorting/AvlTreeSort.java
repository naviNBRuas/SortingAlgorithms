// GENERATED from kernels/algos/avl_tree_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class AvlTreeSort {
    private AvlTreeSort() {}

    static long avl_tree_sort_x_height(int[] ht, long t) {
        if ((t == 0L)) {
            return 0L;
        }
        return ((long)ht[(int)((t - 1L))]);
    }

    static void avl_tree_sort_x_fix(int[] lc, int[] rc, int[] ht, long t) {
        ht[(int)((t - 1L))] = (int)((1L + Math.max(avl_tree_sort_x_height(ht, ((long)lc[(int)((t - 1L))])), avl_tree_sort_x_height(ht, ((long)rc[(int)((t - 1L))])))));
    }

    static long avl_tree_sort_x_rot_right(int[] lc, int[] rc, int[] ht, long y) {
        long x = 0;
        x = ((long)lc[(int)((y - 1L))]);
        lc[(int)((y - 1L))] = (int)(((long)rc[(int)((x - 1L))]));
        rc[(int)((x - 1L))] = (int)(y);
        avl_tree_sort_x_fix(lc, rc, ht, y);
        avl_tree_sort_x_fix(lc, rc, ht, x);
        return x;
    }

    static long avl_tree_sort_x_rot_left(int[] lc, int[] rc, int[] ht, long x) {
        long y = 0;
        y = ((long)rc[(int)((x - 1L))]);
        rc[(int)((x - 1L))] = (int)(((long)lc[(int)((y - 1L))]));
        lc[(int)((y - 1L))] = (int)(x);
        avl_tree_sort_x_fix(lc, rc, ht, x);
        avl_tree_sort_x_fix(lc, rc, ht, y);
        return y;
    }

    static long avl_tree_sort_x_insert(int[] vals, int[] lc, int[] rc, int[] ht, long t, long v) {
        long bal = 0;
        long l = 0;
        long r = 0;
        if ((t == 0L)) {
            ht[(int)(v)] = (int)(1L);
            return (v + 1L);
        }
        if ((((long)vals[(int)(v)]) < ((long)vals[(int)((t - 1L))]))) {
            lc[(int)((t - 1L))] = (int)(avl_tree_sort_x_insert(vals, lc, rc, ht, ((long)lc[(int)((t - 1L))]), v));
        } else {
            rc[(int)((t - 1L))] = (int)(avl_tree_sort_x_insert(vals, lc, rc, ht, ((long)rc[(int)((t - 1L))]), v));
        }
        avl_tree_sort_x_fix(lc, rc, ht, t);
        bal = (avl_tree_sort_x_height(ht, ((long)lc[(int)((t - 1L))])) - avl_tree_sort_x_height(ht, ((long)rc[(int)((t - 1L))])));
        if ((bal > 1L)) {
            l = ((long)lc[(int)((t - 1L))]);
            if ((avl_tree_sort_x_height(ht, ((long)lc[(int)((l - 1L))])) < avl_tree_sort_x_height(ht, ((long)rc[(int)((l - 1L))])))) {
                lc[(int)((t - 1L))] = (int)(avl_tree_sort_x_rot_left(lc, rc, ht, l));
            }
            return avl_tree_sort_x_rot_right(lc, rc, ht, t);
        }
        if ((bal < (-1L))) {
            r = ((long)rc[(int)((t - 1L))]);
            if ((avl_tree_sort_x_height(ht, ((long)rc[(int)((r - 1L))])) < avl_tree_sort_x_height(ht, ((long)lc[(int)((r - 1L))])))) {
                rc[(int)((t - 1L))] = (int)(avl_tree_sort_x_rot_right(lc, rc, ht, r));
            }
            return avl_tree_sort_x_rot_left(lc, rc, ht, t);
        }
        return t;
    }

    static void avl_tree_sort_impl(int[] a, long n) {
        long i = 0;
        long root = 0;
        long node = 0;
        long sp = 0;
        long out = 0;
        long _e1 = 0;
        long _e2 = 0;
        int[] vals = null;
        int[] lc = null;
        int[] rc = null;
        int[] ht = null;
        int[] stack = null;
        if ((n < 2L)) {
            return;
        }
        vals = new int[(int)Math.max(1L, n)];
        lc = new int[(int)Math.max(1L, n)];
        rc = new int[(int)Math.max(1L, n)];
        ht = new int[(int)Math.max(1L, n)];
        stack = new int[(int)Math.max(1L, n)];
        i = 0L;
        _e1 = n;
        while ((i < _e1)) {
            vals[(int)(i)] = (int)(((long)a[(int)(i)]));
            i = (i + 1);
        }
        root = 0L;
        i = 0L;
        _e2 = n;
        while ((i < _e2)) {
            root = avl_tree_sort_x_insert(vals, lc, rc, ht, root, i);
            i = (i + 1);
        }
        node = root;
        sp = 0L;
        out = 0L;
        while (((node != 0L) || (sp > 0L))) {
            if ((node != 0L)) {
                stack[(int)(sp)] = (int)(node);
                sp = (sp + 1L);
                node = ((long)lc[(int)((node - 1L))]);
            } else {
                sp = (sp - 1L);
                node = ((long)stack[(int)(sp)]);
                a[(int)(out)] = (int)(((long)vals[(int)((node - 1L))]));
                out = (out + 1L);
                node = ((long)rc[(int)((node - 1L))]);
            }
        }
    }

    public static void sort(int[] a) {
        avl_tree_sort_impl(a, a.length);
    }
}
