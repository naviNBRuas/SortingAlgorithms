// GENERATED from kernels/algos/radix_sort_lsd.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn radix_sort_lsd_impl(a: &mut [i32], mut n: i64) {
    let mut mn: i64 = 0;
    let mut mx: i64 = 0;
    let mut i: i64 = 0;
    let mut exp: i64 = 0;
    let mut d: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    let mut _e3: i64 = 0;
    let mut _e4: i64 = 0;
    let mut _e5: i64 = 0;
    let mut _e6: i64 = 0;
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
    let mut out_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let out: &mut [i32] = &mut out_store[..];
    let mut count_store: Vec<i32> = vec![0; std::cmp::max(1, 11) as usize]; let count: &mut [i32] = &mut count_store[..];
    exp = 1;
    while (((mx - mn) / exp) > 0) {
        d = 0;
        _e2 = 11;
        while (d < _e2) {
            count[(d) as usize] = (0) as i32;
            d = (d + 1);
        }
        i = 0;
        _e3 = n;
        while (i < _e3) {
            count[((((((a[(i) as usize] as i64) - mn) / exp) % 10) + 1)) as usize] = (((count[((((((a[(i) as usize] as i64) - mn) / exp) % 10) + 1)) as usize] as i64) + 1)) as i32;
            i = (i + 1);
        }
        d = 1;
        _e4 = 11;
        while (d < _e4) {
            count[(d) as usize] = (((count[(d) as usize] as i64) + (count[((d - 1)) as usize] as i64))) as i32;
            d = (d + 1);
        }
        i = 0;
        _e5 = n;
        while (i < _e5) {
            d = ((((a[(i) as usize] as i64) - mn) / exp) % 10);
            out[((count[(d) as usize] as i64)) as usize] = ((a[(i) as usize] as i64)) as i32;
            count[(d) as usize] = (((count[(d) as usize] as i64) + 1)) as i32;
            i = (i + 1);
        }
        i = 0;
        _e6 = n;
        while (i < _e6) {
            a[(i) as usize] = ((out[(i) as usize] as i64)) as i32;
            i = (i + 1);
        }
        exp = (exp * 10);
    }
}

pub fn radix_sort_lsd(a: &mut [i32]) {
    radix_sort_lsd_impl(a, a.len() as i64);
}
