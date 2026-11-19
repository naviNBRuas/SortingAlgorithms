// GENERATED from kernels/algos/bozo_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn bozo_sort_x_is_sorted(a: &mut [i32], mut n: i64) -> i64 {
    let mut i: i64 = 0;
    i = 0;
    while ((i + 1) < n) {
        if ((a[(i) as usize] as i64) > (a[((i + 1)) as usize] as i64)) {
            return 0;
        }
        i = (i + 1);
    }
    return 1;
}

fn bozo_sort_impl(a: &mut [i32], mut n: i64, mut max_swaps: i64) {
    let mut state: i64 = 0;
    let mut count: i64 = 0;
    let mut i: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    state = 987654321;
    count = 0;
    while ((bozo_sort_x_is_sorted(a, n) == 0) && (count < max_swaps)) {
        state = (((state * 1103515245) + 12345) % 2147483648);
        i = ((state / 16) % n);
        state = (((state * 1103515245) + 12345) % 2147483648);
        _i1 = i;
        _i2 = ((state / 16) % n);
        _t1 = (a[(_i1) as usize] as i64);
        a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
        a[(_i2) as usize] = (_t1) as i32;
        count = (count + 1);
    }
}

pub fn bozo_sort(a: &mut [i32], max_swaps: i64) {
    bozo_sort_impl(a, a.len() as i64, max_swaps);
}
