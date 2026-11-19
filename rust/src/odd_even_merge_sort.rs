// GENERATED from kernels/algos/odd_even_merge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn odd_even_merge_sort_x_cmp_swap(a: &mut [i32], mut i: i64, mut j: i64) {
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    if ((a[(i) as usize] as i64) > (a[(j) as usize] as i64)) {
        _i1 = i;
        _i2 = j;
        _t1 = (a[(_i1) as usize] as i64);
        a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
        a[(_i2) as usize] = (_t1) as i32;
    }
}

fn odd_even_merge_sort_impl(a: &mut [i32], mut n: i64) {
    let mut p: i64 = 0;
    let mut k: i64 = 0;
    let mut j: i64 = 0;
    let mut lim: i64 = 0;
    let mut i: i64 = 0;
    let mut _e1: i64 = 0;
    p = 1;
    while (p < n) {
        k = p;
        while (k >= 1) {
            j = (k % p);
            while (j < (n - k)) {
                lim = std::cmp::min(k, ((n - j) - k));
                i = 0;
                _e1 = lim;
                while (i < _e1) {
                    if (((i + j) / (2 * p)) == (((i + j) + k) / (2 * p))) {
                        odd_even_merge_sort_x_cmp_swap(a, (i + j), ((i + j) + k));
                    }
                    i = (i + 1);
                }
                j = (j + (2 * k));
            }
            k = (k / 2);
        }
        p = (p * 2);
    }
}

pub fn odd_even_merge_sort(a: &mut [i32]) {
    odd_even_merge_sort_impl(a, a.len() as i64);
}
