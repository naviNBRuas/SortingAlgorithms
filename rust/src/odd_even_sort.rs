// GENERATED from kernels/algos/odd_even_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn odd_even_sort_impl(a: &mut [i32], mut n: i64) {
    let mut done: i64 = 0;
    let mut start: i64 = 0;
    let mut i: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    done = 0;
    while (done == 0) {
        done = 1;
        start = 1;
        while (start >= 0) {
            i = start;
            while ((i + 1) < n) {
                if ((a[(i) as usize] as i64) > (a[((i + 1)) as usize] as i64)) {
                    _i1 = i;
                    _i2 = (i + 1);
                    _t1 = (a[(_i1) as usize] as i64);
                    a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                    a[(_i2) as usize] = (_t1) as i32;
                    done = 0;
                }
                i = (i + 2);
            }
            start = (start - 1);
        }
    }
}

pub fn odd_even_sort(a: &mut [i32]) {
    odd_even_sort_impl(a, a.len() as i64);
}
