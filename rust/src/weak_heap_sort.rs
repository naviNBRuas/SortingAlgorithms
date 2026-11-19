// GENERATED from kernels/algos/weak_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn weak_heap_sort_x_gparent(r: &mut [i32], mut j: i64) -> i64 {
    while ((j % 2) == (r[((j / 2)) as usize] as i64)) {
        j = (j / 2);
    }
    return (j / 2);
}

fn weak_heap_sort_x_join(a: &mut [i32], r: &mut [i32], mut i: i64, mut j: i64) {
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    if ((a[(i) as usize] as i64) < (a[(j) as usize] as i64)) {
        _i1 = i;
        _i2 = j;
        _t1 = (a[(_i1) as usize] as i64);
        a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
        a[(_i2) as usize] = (_t1) as i32;
        r[(j) as usize] = ((1 - (r[(j) as usize] as i64))) as i32;
    }
}

fn weak_heap_sort_impl(a: &mut [i32], mut n: i64) {
    let mut j: i64 = 0;
    let mut g: i64 = 0;
    let mut m: i64 = 0;
    let mut x: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    if (n < 2) {
        return;
    }
    let mut r_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let r: &mut [i32] = &mut r_store[..];
    j = (n - 1);
    while (j > 0) {
        g = weak_heap_sort_x_gparent(r, j);
        weak_heap_sort_x_join(a, r, g, j);
        j = (j - 1);
    }
    m = (n - 1);
    while (m > 1) {
        _i1 = 0;
        _i2 = m;
        _t1 = (a[(_i1) as usize] as i64);
        a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
        a[(_i2) as usize] = (_t1) as i32;
        x = 1;
        while (((2 * x) + (r[(x) as usize] as i64)) < m) {
            x = ((2 * x) + (r[(x) as usize] as i64));
        }
        while (x > 0) {
            weak_heap_sort_x_join(a, r, 0, x);
            x = (x / 2);
        }
        m = (m - 1);
    }
    _i1 = 0;
    _i2 = 1;
    _t1 = (a[(_i1) as usize] as i64);
    a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
    a[(_i2) as usize] = (_t1) as i32;
}

pub fn weak_heap_sort(a: &mut [i32]) {
    weak_heap_sort_impl(a, a.len() as i64);
}
