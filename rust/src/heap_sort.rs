// GENERATED from kernels/algos/heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn heap_sort_x_sift(a: &mut [i32], mut root: i64, mut size: i64) {
    let mut going: i64 = 0;
    let mut child: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    going = 1;
    while (going == 1) {
        child = ((2 * root) + 1);
        if (child >= size) {
            going = 0;
        } else {
            if (((child + 1) < size) && ((a[(child) as usize] as i64) < (a[((child + 1)) as usize] as i64))) {
                child = (child + 1);
            }
            if ((a[(root) as usize] as i64) < (a[(child) as usize] as i64)) {
                _i1 = root;
                _i2 = child;
                _t1 = (a[(_i1) as usize] as i64);
                a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                a[(_i2) as usize] = (_t1) as i32;
                root = child;
            } else {
                going = 0;
            }
        }
    }
}

fn heap_sort_impl(a: &mut [i32], mut n: i64) {
    let mut s: i64 = 0;
    let mut end: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    s = (n / 2);
    while (s > 0) {
        s = (s - 1);
        heap_sort_x_sift(a, s, n);
    }
    end = (n - 1);
    while (end > 0) {
        _i1 = 0;
        _i2 = end;
        _t1 = (a[(_i1) as usize] as i64);
        a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
        a[(_i2) as usize] = (_t1) as i32;
        heap_sort_x_sift(a, 0, end);
        end = (end - 1);
    }
}

pub fn heap_sort(a: &mut [i32]) {
    heap_sort_impl(a, a.len() as i64);
}
