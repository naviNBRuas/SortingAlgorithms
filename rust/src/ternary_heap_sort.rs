// GENERATED from kernels/algos/ternary_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn ternary_heap_sort_x_sift(a: &mut [i32], mut root: i64, mut size: i64) {
    let mut going: i64 = 0;
    let mut first: i64 = 0;
    let mut best: i64 = 0;
    let mut c: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    going = 1;
    while (going == 1) {
        first = ((3 * root) + 1);
        if (first >= size) {
            going = 0;
        } else {
            best = first;
            c = (first + 1);
            while ((c < (first + 3)) && (c < size)) {
                if ((a[(best) as usize] as i64) < (a[(c) as usize] as i64)) {
                    best = c;
                }
                c = (c + 1);
            }
            if ((a[(root) as usize] as i64) < (a[(best) as usize] as i64)) {
                _i1 = root;
                _i2 = best;
                _t1 = (a[(_i1) as usize] as i64);
                a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                a[(_i2) as usize] = (_t1) as i32;
                root = best;
            } else {
                going = 0;
            }
        }
    }
}

fn ternary_heap_sort_impl(a: &mut [i32], mut n: i64) {
    let mut s: i64 = 0;
    let mut end: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    if (n < 2) {
        return;
    }
    s = (((n - 2) / 3) + 1);
    while (s > 0) {
        s = (s - 1);
        ternary_heap_sort_x_sift(a, s, n);
    }
    end = (n - 1);
    while (end > 0) {
        _i1 = 0;
        _i2 = end;
        _t1 = (a[(_i1) as usize] as i64);
        a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
        a[(_i2) as usize] = (_t1) as i32;
        ternary_heap_sort_x_sift(a, 0, end);
        end = (end - 1);
    }
}

pub fn ternary_heap_sort(a: &mut [i32]) {
    ternary_heap_sort_impl(a, a.len() as i64);
}
