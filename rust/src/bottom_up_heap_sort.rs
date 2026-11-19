// GENERATED from kernels/algos/bottom_up_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn bottom_up_heap_sort_x_sift(a: &mut [i32], mut root: i64, mut size: i64) {
    let mut j: i64 = 0;
    let mut x: i64 = 0;
    let mut cur: i64 = 0;
    let mut c: i64 = 0;
    j = root;
    while (((2 * j) + 2) < size) {
        if ((a[(((2 * j) + 1)) as usize] as i64) < (a[(((2 * j) + 2)) as usize] as i64)) {
            j = ((2 * j) + 2);
        } else {
            j = ((2 * j) + 1);
        }
    }
    if (((2 * j) + 1) < size) {
        j = ((2 * j) + 1);
    }
    x = (a[(root) as usize] as i64);
    while ((a[(j) as usize] as i64) < x) {
        j = ((j - 1) / 2);
    }
    cur = root;
    while (cur != j) {
        c = j;
        while (((c - 1) / 2) != cur) {
            c = ((c - 1) / 2);
        }
        a[(cur) as usize] = ((a[(c) as usize] as i64)) as i32;
        cur = c;
    }
    a[(j) as usize] = (x) as i32;
}

fn bottom_up_heap_sort_impl(a: &mut [i32], mut n: i64) {
    let mut s: i64 = 0;
    let mut end: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    s = (n / 2);
    while (s > 0) {
        s = (s - 1);
        bottom_up_heap_sort_x_sift(a, s, n);
    }
    end = (n - 1);
    while (end > 0) {
        _i1 = 0;
        _i2 = end;
        _t1 = (a[(_i1) as usize] as i64);
        a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
        a[(_i2) as usize] = (_t1) as i32;
        bottom_up_heap_sort_x_sift(a, 0, end);
        end = (end - 1);
    }
}

pub fn bottom_up_heap_sort(a: &mut [i32]) {
    bottom_up_heap_sort_impl(a, a.len() as i64);
}
