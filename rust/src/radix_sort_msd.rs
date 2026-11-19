// GENERATED from kernels/algos/radix_sort_msd.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn radix_sort_msd_x_rec(a: &mut [i32], tmp: &mut [i32], mut mn: i64, mut lo: i64, mut hi: i64, mut exp: i64) {
    let mut i: i64 = 0;
    let mut d: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    let mut _e3: i64 = 0;
    let mut _e4: i64 = 0;
    let mut _e5: i64 = 0;
    let mut _e6: i64 = 0;
    if (((hi - lo) < 2) || (exp == 0)) {
        return;
    }
    let mut count_store: Vec<i32> = vec![0; std::cmp::max(1, 11) as usize]; let count: &mut [i32] = &mut count_store[..];
    i = lo;
    _e1 = hi;
    while (i < _e1) {
        count[((((((a[(i) as usize] as i64) - mn) / exp) % 10) + 1)) as usize] = (((count[((((((a[(i) as usize] as i64) - mn) / exp) % 10) + 1)) as usize] as i64) + 1)) as i32;
        i = (i + 1);
    }
    d = 1;
    _e2 = 11;
    while (d < _e2) {
        count[(d) as usize] = (((count[(d) as usize] as i64) + (count[((d - 1)) as usize] as i64))) as i32;
        d = (d + 1);
    }
    let mut start_store: Vec<i32> = vec![0; std::cmp::max(1, 11) as usize]; let start: &mut [i32] = &mut start_store[..];
    d = 0;
    _e3 = 11;
    while (d < _e3) {
        start[(d) as usize] = ((count[(d) as usize] as i64)) as i32;
        d = (d + 1);
    }
    i = lo;
    _e4 = hi;
    while (i < _e4) {
        d = ((((a[(i) as usize] as i64) - mn) / exp) % 10);
        tmp[((lo + (count[(d) as usize] as i64))) as usize] = ((a[(i) as usize] as i64)) as i32;
        count[(d) as usize] = (((count[(d) as usize] as i64) + 1)) as i32;
        i = (i + 1);
    }
    i = lo;
    _e5 = hi;
    while (i < _e5) {
        a[(i) as usize] = ((tmp[(i) as usize] as i64)) as i32;
        i = (i + 1);
    }
    d = 0;
    _e6 = 10;
    while (d < _e6) {
        radix_sort_msd_x_rec(a, tmp, mn, (lo + (start[(d) as usize] as i64)), (lo + (start[((d + 1)) as usize] as i64)), (exp / 10));
        d = (d + 1);
    }
}

fn radix_sort_msd_impl(a: &mut [i32], mut n: i64) {
    let mut mn: i64 = 0;
    let mut mx: i64 = 0;
    let mut i: i64 = 0;
    let mut top: i64 = 0;
    let mut _e1: i64 = 0;
    if (n < 2) {
        return;
    }
    mn = (a[(0) as usize] as i64);
    mx = (a[(0) as usize] as i64);
    i = 1;
    _e1 = n;
    while (i < _e1) {
        if ((a[(i) as usize] as i64) < mn) {
            mn = (a[(i) as usize] as i64);
        }
        if ((a[(i) as usize] as i64) > mx) {
            mx = (a[(i) as usize] as i64);
        }
        i = (i + 1);
    }
    let mut tmp_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let tmp: &mut [i32] = &mut tmp_store[..];
    top = 1;
    while (((mx - mn) / top) >= 10) {
        top = (top * 10);
    }
    radix_sort_msd_x_rec(a, tmp, mn, 0, n, top);
}

pub fn radix_sort_msd(a: &mut [i32]) {
    radix_sort_msd_impl(a, a.len() as i64);
}
