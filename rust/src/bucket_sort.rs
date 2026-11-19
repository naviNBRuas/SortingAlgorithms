// GENERATED from kernels/algos/bucket_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn bucket_sort_impl(a: &mut [i32], mut n: i64) {
    let mut mn: i64 = 0;
    let mut mx: i64 = 0;
    let mut i: i64 = 0;
    let mut rng: i64 = 0;
    let mut b: i64 = 0;
    let mut lo: i64 = 0;
    let mut hi: i64 = 0;
    let mut key: i64 = 0;
    let mut j: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    let mut _e3: i64 = 0;
    let mut _e4: i64 = 0;
    let mut _e5: i64 = 0;
    let mut _e6: i64 = 0;
    let mut _e7: i64 = 0;
    let mut _e8: i64 = 0;
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
    rng = (mx - mn);
    if (rng == 0) {
        return;
    }
    let mut count_store: Vec<i32> = vec![0; std::cmp::max(1, (n + 1)) as usize]; let count: &mut [i32] = &mut count_store[..];
    let mut out_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let out: &mut [i32] = &mut out_store[..];
    i = 0;
    _e2 = n;
    while (i < _e2) {
        count[((((((a[(i) as usize] as i64) - mn) * (n - 1)) / rng) + 1)) as usize] = (((count[((((((a[(i) as usize] as i64) - mn) * (n - 1)) / rng) + 1)) as usize] as i64) + 1)) as i32;
        i = (i + 1);
    }
    b = 1;
    _e3 = (n + 1);
    while (b < _e3) {
        count[(b) as usize] = (((count[(b) as usize] as i64) + (count[((b - 1)) as usize] as i64))) as i32;
        b = (b + 1);
    }
    let mut start_store: Vec<i32> = vec![0; std::cmp::max(1, (n + 1)) as usize]; let start: &mut [i32] = &mut start_store[..];
    b = 0;
    _e4 = (n + 1);
    while (b < _e4) {
        start[(b) as usize] = ((count[(b) as usize] as i64)) as i32;
        b = (b + 1);
    }
    i = 0;
    _e5 = n;
    while (i < _e5) {
        b = ((((a[(i) as usize] as i64) - mn) * (n - 1)) / rng);
        out[((count[(b) as usize] as i64)) as usize] = ((a[(i) as usize] as i64)) as i32;
        count[(b) as usize] = (((count[(b) as usize] as i64) + 1)) as i32;
        i = (i + 1);
    }
    b = 0;
    _e6 = n;
    while (b < _e6) {
        lo = (start[(b) as usize] as i64);
        hi = (start[((b + 1)) as usize] as i64);
        i = (lo + 1);
        _e7 = hi;
        while (i < _e7) {
            key = (out[(i) as usize] as i64);
            j = (i - 1);
            while ((j >= lo) && ((out[(j) as usize] as i64) > key)) {
                out[((j + 1)) as usize] = ((out[(j) as usize] as i64)) as i32;
                j = (j - 1);
            }
            out[((j + 1)) as usize] = (key) as i32;
            i = (i + 1);
        }
        b = (b + 1);
    }
    i = 0;
    _e8 = n;
    while (i < _e8) {
        a[(i) as usize] = ((out[(i) as usize] as i64)) as i32;
        i = (i + 1);
    }
}

pub fn bucket_sort(a: &mut [i32]) {
    bucket_sort_impl(a, a.len() as i64);
}
