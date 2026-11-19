// GENERATED from kernels/algos/cartesian_tree_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
package sorting;

public final class CartesianTreeSort {
    private CartesianTreeSort() {}

    static void cartesian_tree_sort_x_sift_up(int[] vals, int[] heap, long i) {
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        while (((i > 0L) && (((long)vals[(int)(((long)heap[(int)(i)]))]) < ((long)vals[(int)(((long)heap[(int)(((i - 1L) / 2L))]))])))) {
            _i1 = i;
            _i2 = ((i - 1L) / 2L);
            _t1 = ((long)heap[(int)(_i1)]);
            heap[(int)(_i1)] = (int)(((long)heap[(int)(_i2)]));
            heap[(int)(_i2)] = (int)(_t1);
            i = ((i - 1L) / 2L);
        }
    }

    static void cartesian_tree_sort_x_sift_down(int[] vals, int[] heap, long size, long i) {
        long going = 0;
        long c = 0;
        long _i1 = 0;
        long _i2 = 0;
        long _t1 = 0;
        going = 1L;
        while ((going == 1L)) {
            c = ((2L * i) + 1L);
            if ((c >= size)) {
                going = 0L;
            } else {
                if ((((c + 1L) < size) && (((long)vals[(int)(((long)heap[(int)((c + 1L))]))]) < ((long)vals[(int)(((long)heap[(int)(c)]))])))) {
                    c = (c + 1L);
                }
                if ((((long)vals[(int)(((long)heap[(int)(c)]))]) < ((long)vals[(int)(((long)heap[(int)(i)]))]))) {
                    _i1 = i;
                    _i2 = c;
                    _t1 = ((long)heap[(int)(_i1)]);
                    heap[(int)(_i1)] = (int)(((long)heap[(int)(_i2)]));
                    heap[(int)(_i2)] = (int)(_t1);
                    i = c;
                } else {
                    going = 0L;
                }
            }
        }
    }

    static void cartesian_tree_sort_impl(int[] a, long n) {
        long i = 0;
        long sp = 0;
        long last = 0;
        long size = 0;
        long out = 0;
        long node = 0;
        long _e1 = 0;
        long _e2 = 0;
        long _e3 = 0;
        int[] vals = null;
        int[] left = null;
        int[] right = null;
        int[] stack = null;
        int[] heap = null;
        if ((n < 2L)) {
            return;
        }
        vals = new int[(int)Math.max(1L, n)];
        left = new int[(int)Math.max(1L, n)];
        right = new int[(int)Math.max(1L, n)];
        stack = new int[(int)Math.max(1L, n)];
        heap = new int[(int)Math.max(1L, n)];
        i = 0L;
        _e1 = n;
        while ((i < _e1)) {
            vals[(int)(i)] = (int)(((long)a[(int)(i)]));
            left[(int)(i)] = (int)((-1L));
            right[(int)(i)] = (int)((-1L));
            i = (i + 1);
        }
        sp = 0L;
        i = 0L;
        _e2 = n;
        while ((i < _e2)) {
            last = (-1L);
            while (((sp > 0L) && (((long)vals[(int)(i)]) < ((long)vals[(int)(((long)stack[(int)((sp - 1L))]))])))) {
                sp = (sp - 1L);
                last = ((long)stack[(int)(sp)]);
            }
            left[(int)(i)] = (int)(last);
            if ((sp > 0L)) {
                right[(int)(((long)stack[(int)((sp - 1L))]))] = (int)(i);
            }
            stack[(int)(sp)] = (int)(i);
            sp = (sp + 1L);
            i = (i + 1);
        }
        heap[(int)(0L)] = (int)(((long)stack[(int)(0L)]));
        size = 1L;
        out = 0L;
        _e3 = n;
        while ((out < _e3)) {
            node = ((long)heap[(int)(0L)]);
            size = (size - 1L);
            heap[(int)(0L)] = (int)(((long)heap[(int)(size)]));
            cartesian_tree_sort_x_sift_down(vals, heap, size, 0L);
            a[(int)(out)] = (int)(((long)vals[(int)(node)]));
            if ((((long)left[(int)(node)]) >= 0L)) {
                heap[(int)(size)] = (int)(((long)left[(int)(node)]));
                size = (size + 1L);
                cartesian_tree_sort_x_sift_up(vals, heap, (size - 1L));
            }
            if ((((long)right[(int)(node)]) >= 0L)) {
                heap[(int)(size)] = (int)(((long)right[(int)(node)]));
                size = (size + 1L);
                cartesian_tree_sort_x_sift_up(vals, heap, (size - 1L));
            }
            out = (out + 1);
        }
    }

    public static void sort(int[] a) {
        cartesian_tree_sort_impl(a, a.length);
    }
}
