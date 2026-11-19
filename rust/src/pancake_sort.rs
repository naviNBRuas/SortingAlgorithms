// GENERATED from kernels/algos/pancake_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn pancake_sort_x_flip(a: &mut [i32], mut k: i64) {
    let mut i: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    i = 0;
    while (i < k) {
        _i1 = i;
        _i2 = k;
        _t1 = (a[(_i1) as usize] as i64);
        a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
        a[(_i2) as usize] = (_t1) as i32;
        i = (i + 1);
        k = (k - 1);
    }
}

fn pancake_sort_impl(a: &mut [i32], mut n: i64) {
    let mut size: i64 = 0;
    let mut mx: i64 = 0;
    let mut i: i64 = 0;
    size = n;
    while (size > 1) {
        mx = 0;
        i = 1;
        while (i < size) {
            if ((a[(i) as usize] as i64) > (a[(mx) as usize] as i64)) {
                mx = i;
            }
            i = (i + 1);
        }
        if (mx != (size - 1)) {
            if (mx > 0) {
                pancake_sort_x_flip(a, mx);
            }
            pancake_sort_x_flip(a, (size - 1));
        }
        size = (size - 1);
    }
}

pub fn pancake_sort(a: &mut [i32]) {
    pancake_sort_impl(a, a.len() as i64);
}
