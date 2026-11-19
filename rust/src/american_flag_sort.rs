// GENERATED from kernels/algos/american_flag_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn american_flag_sort_x_rec(a: &mut [i32], mut mn: i64, mut lo: i64, mut hi: i64, mut exp: i64) {
    let mut i: i64 = 0;
    let mut s: i64 = 0;
    let mut d: i64 = 0;
    let mut b: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    let mut _e3: i64 = 0;
    let mut _e4: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    if (((hi - lo) < 2) || (exp == 0)) {
        return;
    }
    let mut count_store: Vec<i32> = vec![0; std::cmp::max(1, 10) as usize]; let count: &mut [i32] = &mut count_store[..];
    let mut starts_store: Vec<i32> = vec![0; std::cmp::max(1, 11) as usize]; let starts: &mut [i32] = &mut starts_store[..];
    let mut nxt_store: Vec<i32> = vec![0; std::cmp::max(1, 10) as usize]; let nxt: &mut [i32] = &mut nxt_store[..];
    i = lo;
    _e1 = hi;
    while (i < _e1) {
        count[(((((a[(i) as usize] as i64) - mn) / exp) % 10)) as usize] = (((count[(((((a[(i) as usize] as i64) - mn) / exp) % 10)) as usize] as i64) + 1)) as i32;
        i = (i + 1);
    }
    s = lo;
    d = 0;
    _e2 = 10;
    while (d < _e2) {
        starts[(d) as usize] = (s) as i32;
        nxt[(d) as usize] = (s) as i32;
        s = (s + (count[(d) as usize] as i64));
        d = (d + 1);
    }
    starts[(10) as usize] = (s) as i32;
    b = 0;
    _e3 = 10;
    while (b < _e3) {
        while ((nxt[(b) as usize] as i64) < (starts[((b + 1)) as usize] as i64)) {
            d = ((((a[((nxt[(b) as usize] as i64)) as usize] as i64) - mn) / exp) % 10);
            if (d == b) {
                nxt[(b) as usize] = (((nxt[(b) as usize] as i64) + 1)) as i32;
            } else {
                _i1 = (nxt[(b) as usize] as i64);
                _i2 = (nxt[(d) as usize] as i64);
                _t1 = (a[(_i1) as usize] as i64);
                a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                a[(_i2) as usize] = (_t1) as i32;
                nxt[(d) as usize] = (((nxt[(d) as usize] as i64) + 1)) as i32;
            }
        }
        b = (b + 1);
    }
    b = 0;
    _e4 = 10;
    while (b < _e4) {
        american_flag_sort_x_rec(a, mn, (starts[(b) as usize] as i64), (starts[((b + 1)) as usize] as i64), (exp / 10));
        b = (b + 1);
    }
}

fn american_flag_sort_impl(a: &mut [i32], mut n: i64) {
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
    top = 1;
    while (((mx - mn) / top) >= 10) {
        top = (top * 10);
    }
    american_flag_sort_x_rec(a, mn, 0, n, top);
}

pub fn american_flag_sort(a: &mut [i32]) {
    american_flag_sort_impl(a, a.len() as i64);
}
